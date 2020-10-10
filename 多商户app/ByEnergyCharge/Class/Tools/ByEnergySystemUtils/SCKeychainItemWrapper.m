//
//  SCKeychainItemWrapper.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "SCKeychainItemWrapper.h"

#import <Security/Security.h>

/*
 
 These are the default constants and their respective types,
 available for the kSecClassGenericPassword Keychain Item class:
 
 kSecAttrAccessGroup            -        CFStringRef
 kSecAttrCreationDate        -        CFDateRef
 kSecAttrModificationDate    -        CFDateRef
 kSecAttrDescription            -        CFStringRef
 kSecAttrComment                -        CFStringRef
 kSecAttrCreator                -        CFNumberRef
 kSecAttrType                -        CFNumberRef
 kSecAttrLabel                -        CFStringRef
 kSecAttrIsInvisible            -        CFBooleanRef
 kSecAttrIsNegative            -        CFBooleanRef
 kSecAttrAccount                -        CFStringRef
 kSecAttrService                -        CFStringRef
 kSecAttrGeneric                -        CFDataRef
 
 See the header file Security/SecItem.h for more details.
 
 */

@interface SCKeychainItemWrapper (PrivateMethods)
/*
 The decision behind the following two methods (secItemFormatToDictionary and dictionaryToSecItemFormat) was
 to encapsulate the transition between what the detail view controller was expecting (NSString *) and what the
 Keychain API expects as a validly constructed container class.
 */
- (NSMutableDictionary *)secItemFormatToDictionary:(NSDictionary *)dictionaryToConvert;
- (NSMutableDictionary *)dictionaryToSecItemFormat:(NSDictionary *)dictionaryToConvert;

// Updates the item in the keychain, or adds it if it doesn't exist.
- (void)writeToKeychain;

@end

@implementation SCKeychainItemWrapper

@synthesize keychainItemData, genericPasswordQuery;

- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *) accessGroup;
{
    if (self = [super init])
    {
        // Begin Keychain search setup. The genericPasswordQuery leverages the special user
        // defined attribute kSecAttrGeneric to distinguish itself between other generic Keychain
        // items which may be included by the same application.
        genericPasswordQuery = [[NSMutableDictionary alloc] init];
        
        [genericPasswordQuery setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
        _identifier = identifier;
        [genericPasswordQuery setObject:identifier forKey:(__bridge id)kSecAttrGeneric];
        
        // The keychain access group attribute determines if this item can be shared
        // amongst multiple apps whose code signing entitlements contain the same keychain access group.
        if (accessGroup != nil)
        {
#if TARGET_IPHONE_SIMULATOR
            // Ignore the access group if running on the iPhone simulator.
            //
            // Apps that are built for the simulator aren't signed, so there's no keychain access group
            // for the simulator to check. This means that all apps can see all keychain items when run
            // on the simulator.
            //
            // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
            // simulator will return -25243 (errSecNoAccessForItem).
#else
            [genericPasswordQuery setObject:accessGroup forKey:(__bridge id)kSecAttrAccessGroup];
#endif
        }
        
        // Use the proper search constants, return only the attributes of the first match.
        [genericPasswordQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
        [genericPasswordQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnAttributes];
        
        NSDictionary *tempQuery = [NSDictionary dictionaryWithDictionary:genericPasswordQuery];
        
        CFTypeRef cfDictionary = NULL;
        if (SecItemCopyMatching((__bridge CFDictionaryRef)tempQuery, &cfDictionary) != noErr)
        {
            // Stick these default values into keychain item if nothing found.
            [self resetKeychainItem];
            
            // Add the generic attribute and the keychain access group.
            [keychainItemData setObject:identifier forKey:(__bridge id)kSecAttrGeneric];
            if (accessGroup != nil)
            {
#if TARGET_IPHONE_SIMULATOR
                // Ignore the access group if running on the iPhone simulator.
                //
                // Apps that are built for the simulator aren't signed, so there's no keychain access group
                // for the simulator to check. This means that all apps can see all keychain items when run
                // on the simulator.
                //
                // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
                // simulator will return -25243 (errSecNoAccessForItem).
#else
                [keychainItemData setObject:accessGroup forKey:(__bridge id)kSecAttrAccessGroup];
#endif
            }
        }
        else
        {
            // load the saved data from Keychain.
            NSMutableDictionary *outDictionary = (__bridge_transfer NSMutableDictionary *)cfDictionary;
            self.keychainItemData = [self secItemFormatToDictionary:outDictionary];
        }
    }
    
    return self;
}


- (void)setObject:(id)inObject forKey:(id)key
{
    if (inObject == nil) return;
    id currentObject = [keychainItemData objectForKey:key];
    if (![currentObject isEqual:inObject])
    {
        [keychainItemData setObject:inObject forKey:key];
        [self writeToKeychain];
    }
}

- (id)objectForKey:(id)key
{
    return [keychainItemData objectForKey:key];
}

- (void)resetKeychainItem
{
    OSStatus junk = noErr;
    if (!keychainItemData)
    {
        self.keychainItemData = [[NSMutableDictionary alloc] init];
    }
    else if (keychainItemData)
    {
        NSMutableDictionary *tempDictionary = [self dictionaryToSecItemFormat:keychainItemData];
        junk = SecItemDelete((__bridge CFDictionaryRef)tempDictionary);
        NSAssert( junk == noErr || junk == errSecItemNotFound, @"Problem deleting current dictionary." );
    }
    
    // Default attributes for keychain item.
    [keychainItemData setObject:@"" forKey:(__bridge id)kSecAttrAccount];
    [keychainItemData setObject:@"" forKey:(__bridge id)kSecAttrService];
    [keychainItemData setObject:@"" forKey:(__bridge id)kSecAttrLabel];
    [keychainItemData setObject:@"" forKey:(__bridge id)kSecAttrDescription];
    
    // Default data for keychain item.
    [keychainItemData setObject:[NSDictionary dictionary] forKey:(__bridge id)kSecValueData];
}

- (NSMutableDictionary *)dictionaryToSecItemFormat:(NSDictionary *)dictionaryToConvert
{
    /*// The assumption is that this method will be called with a properly populated dictionary
     // containing all the right key/value pairs for a SecItem.
     
     // Create a dictionary to return populated with the attributes and data.
     NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
     
     // Add the Generic Password keychain item class attribute.
     [returnDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
     
     // Convert the NSString to NSData to meet the requirements for the value type kSecValueData.
     // This is where to store sensitive data that should be encrypted.
     NSString *passwordString = [dictionaryToConvert objectForKey:(id)kSecValueData];
     [returnDictionary setObject:[passwordString dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecValueData];
     
     return returnDictionary;*/
    
    NSMutableDictionary * returnDict = [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
    //[returnDict setObject:_identifier forKey:(id)kSecAttrGeneric];
    [returnDict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    // convert the dictionary to an info list for serialization
    // could contain multiple result sets to be handled
    NSDictionary * resultsInfo = [dictionaryToConvert objectForKey:(__bridge id)kSecValueData];
    
    NSError * error;
    NSData * xmlData = [NSPropertyListSerialization dataWithPropertyList:resultsInfo
                                                                  format:NSPropertyListXMLFormat_v1_0 options:0
                                                                   error:&error];
    
    if (error != nil)
    {
        NSLog(@"dictionaryToSecItemFormat: Error! %@", error);
    }
    
    if (xmlData)
        [returnDict setObject:xmlData forKey:(__bridge id)kSecValueData];
    
    return returnDict;
}

- (NSMutableDictionary *)secItemFormatToDictionary:(NSDictionary *)dictionaryToConvert
{
    /*// The assumption is that this method will be called with a properly populated dictionary
     // containing all the right key/value pairs for the UI element.
     
     // Create a dictionary to return populated with the attributes and data.
     NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
     
     // Add the proper search key and class attribute.
     [returnDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
     [returnDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
     
     // Acquire the password data from the attributes.
     NSData *passwordData = NULL;
     if (SecItemCopyMatching((CFDictionaryRef)returnDictionary, (CFTypeRef *)&passwordData) == noErr)
     {
     // Remove the search, class, and identifier key/value, we don't need them anymore.
     [returnDictionary removeObjectForKey:(id)kSecReturnData];
     
     // Add the password to the dictionary, converting from NSData to NSString.
     NSString *password = [[[NSString alloc] initWithBytes:[passwordData bytes] length:[passwordData length]
     encoding:NSUTF8StringEncoding] autorelease];
     [returnDictionary setObject:password forKey:(id)kSecValueData];
     }
     else
     {
     // Don't do anything if nothing is found.
     NSAssert(NO, @"Serious error, no matching item found in the keychain.\n");
     }
     
     [passwordData release];
     
     return returnDictionary;*/
    
    
    NSMutableDictionary * returnDict = [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
    
    // to get the password data from the keychain item, add the search key and class attr required to obtain the password
    [returnDict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [returnDict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    // call the keychain services to get the password
    OSStatus keychainErr = noErr;
    
    CFTypeRef cfXmlData = NULL;
    keychainErr = SecItemCopyMatching((__bridge CFDictionaryRef)returnDict, &cfXmlData);
    
    if (keychainErr == noErr)
    {
        NSData * xmlData = (__bridge_transfer NSData *) cfXmlData;
        [returnDict removeObjectForKey:(__bridge id)kSecReturnData];
        
        NSError * errorDesc = nil;
        NSPropertyListFormat fmt = NSPropertyListXMLFormat_v1_0;
        
        NSDictionary * resultsInfo = (NSDictionary *) [NSPropertyListSerialization dataWithPropertyList:xmlData
                                                                                                 format:fmt options:0
                                                                                                  error:&errorDesc];
        
        if (resultsInfo)
            [returnDict setObject:resultsInfo forKey:(__bridge id)kSecValueData];
        
    } else {
        NSLog(@"secItemFormatToDictionary: format error.");
    }
    
    return returnDict;
}

- (void)writeToKeychain
{
    OSStatus result;
    CFTypeRef cfAttributes = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)genericPasswordQuery, &cfAttributes) == noErr)
    {
        NSDictionary *attributes = (__bridge_transfer NSDictionary *) cfAttributes;
        
        // First we need the attributes from the Keychain.
        NSMutableDictionary *updateItem = [NSMutableDictionary dictionaryWithDictionary:attributes];
        // Second we need to add the appropriate search key/values.
        [updateItem setObject:[genericPasswordQuery objectForKey:(__bridge id)kSecClass] forKey:(__bridge id)kSecClass];
        
        // Lastly, we need to set up the updated attribute list being careful to remove the class.
        NSMutableDictionary *tempCheck = [self dictionaryToSecItemFormat:keychainItemData];
        [tempCheck removeObjectForKey:(__bridge id)kSecClass];
        
#if TARGET_IPHONE_SIMULATOR
        // Remove the access group if running on the iPhone simulator.
        //
        // Apps that are built for the simulator aren't signed, so there's no keychain access group
        // for the simulator to check. This means that all apps can see all keychain items when run
        // on the simulator.
        //
        // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
        // simulator will return -25243 (errSecNoAccessForItem).
        //
        // The access group attribute will be included in items returned by SecItemCopyMatching,
        // which is why we need to remove it before updating the item.
        [tempCheck removeObjectForKey:(__bridge id)kSecAttrAccessGroup];
#endif
        
        // An implicit assumption is that you can only update a single item at a time.
        
        result = SecItemUpdate((__bridge CFDictionaryRef)updateItem, (__bridge CFDictionaryRef)tempCheck);
        NSAssert( result == noErr || result == errSecDuplicateItem, @"Couldn't update the Keychain Item." );
    }
    else
    {
        // No previous item found; add the new one.
        /*NSMutableDictionary* query = [[NSMutableDictionary alloc] init];
         [query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
         [query setObject:_identifier forKey:(id)kSecAttrGeneric];
         [query setObject:@"Account" forKey:(id)kSecAttrAccount];
         [query setObject:@"Service" forKey:(id)kSecAttrService];
         result = SecItemDelete((CFDictionaryRef)query);*/
        
        result = SecItemAdd((__bridge CFDictionaryRef)[self dictionaryToSecItemFormat:keychainItemData], NULL);
        NSAssert( result == noErr || result == errSecDuplicateItem, @"Couldn't add the Keychain Item." );
    }
}

@end
