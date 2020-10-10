//
//  SystemUtils.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "SystemUtils.h"
#import "SCKeychainItemWrapper.h"

@implementation SystemUtils
static SCKeychainItemWrapper *wrapper;
#pragma mark ------ 查看本机安装的地图

+(NSArray *)checkHasOwnApp{
    NSArray *mapSchemeArr = @[@"iosamap://navi",@"baidumap://map/",@"qqmap://"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] init];
    [appListArr addObject:@"苹果地图"];
    for (int i = 0; i < [mapSchemeArr count]; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i == 0){
                [appListArr addObject:@"高德地图"];
            }else if (i == 1){
                [appListArr addObject:@"百度地图"];
            }else if (i == 2){
                [appListArr addObject:@"腾讯地图"];
            }
        }
    }
    
    return appListArr;
}

+ (NSString *)noNilWithString:(NSString *)oldStr {
    return byEnergyIsValidStr(oldStr)==NO?@"":oldStr;
}

#pragma mark - 获取DeviceId
+ (NSString *)getDeviceId {
    @try {
        if (wrapper==nil) {
            wrapper = [[SCKeychainItemWrapper alloc] initWithIdentifier:@"SCdeviceIdentifier" accessGroup:nil];
        }
        
        NSString *uniqueIdentifier = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
        if (byEnergyIsValidStr(uniqueIdentifier)==NO) {
            [wrapper setObject:[SystemUtils getUUID] forKey:(__bridge id)kSecAttrAccount];
        }
        uniqueIdentifier = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
        return [SystemUtils noNilWithString:uniqueIdentifier];
    }
    @catch (NSException *exception) {
        return @"";
    }
}

#pragma mark - 获取UUID
+ (NSString *)getUUID {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

@end
