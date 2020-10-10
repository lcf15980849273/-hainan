//
//  NSDictionary+SafeExt.m
//  SafeParam
//
//  Created by SRC on 2020/4/14.
//  Copyright © 2020 SRC. All rights reserved.
//

#import "NSDictionary+SafeExt.h"
#import "NSData+SafeExt.h"

@implementation NSDictionary (SafeExt)

+ (NSDictionary *)ext_dictionaryForBase64String:(NSString *)string key:(NSString *)key{
    if (!string || !string.length) {
        return nil;
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [data ext_decryptToDict:key ivString:nil];
}

- (NSString *)ext_encryptForBase64String:(NSString *)key{
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    return [data ext_encryptToString:key ivString:nil];
}

@end
