//
//  NSData+SafeExt.m
//  SafeParam
//
//  Created by SRC on 2020/4/14.
//  Copyright © 2020 SRC. All rights reserved.
//

#import "NSData+SafeExt.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCrypto.h>


@implementation NSData (SafeExt)

/// 数据流加密
/// @param key key
/// @param iv 偏移量 不使用传nil
- (NSString *)ext_encryptToString:(NSString *)key ivString:(NSString *)iv{
    return [[[self ext_encryptToData:key ivString:iv] base64EncodedDataWithOptions:kNilOptions] base64EncodedStringWithOptions:kNilOptions];
}


/// 数据流加密
/// @param key key
/// @param iv 偏移量 不使用传nil
- (NSData *)ext_encryptToData:(NSString *)key ivString:(NSString *)iv{
    return [self ext_3decCodeForOperation:kCCEncrypt key:key ivString:iv];
}

/// 数据流解密
/// @param key key
/// @param iv 偏移量 不使用传nil
- (NSDictionary *)ext_decryptToDict:(NSString *)key ivString:(NSString *)iv {
    NSData *data = [self ext_decryptToData:key ivString:iv];
 
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions | NSJSONReadingFragmentsAllowed error:&error];
    if (error) {
        return nil;
    }
    return dict;
}

/// 数据流解密
/// @param key key
/// @param iv 偏移量 不使用传nil
- (NSData *)ext_decryptToData:(NSString *)key ivString:(NSString *)iv{
    return [self ext_3decCodeForOperation:kCCDecrypt key:key ivString:iv];
}


- (NSData *)ext_3decCodeForOperation:(CCOperation)op key:(NSString *)key ivString:(NSString *)iv {
    CCCryptorStatus status;
    
    ///加密数据输入区域
    NSMutableData *outData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    size_t dataOutMoved = 0;
    
    const void * keyInfo = [[self buildKeys:key] bytes];

    ///进行加密
    status = CCCrypt(op,
                     kCCAlgorithm3DES,
                     kCCOptionECBMode | kCCOptionPKCS7Padding,
                     keyInfo,
                     kCCKeySize3DES,
                     [iv UTF8String],
                     [self bytes],
                     [self length],
                     [outData mutableBytes],
                     [outData length],
                     &dataOutMoved);
    if (status != kCCSuccess) {
        return nil;
    }
    ///数据真实长度
    outData.length = dataOutMoved;
    
    return outData;
}

- (NSMutableData *)buildKeys:(NSString *)key {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger outLength = keyData.length > 24 ? 24 : keyData.length;
    NSMutableData *outData = [NSMutableData dataWithLength:24];
    [outData replaceBytesInRange:NSMakeRange(0, outLength) withBytes:[keyData bytes]];
    return outData;
}

@end
