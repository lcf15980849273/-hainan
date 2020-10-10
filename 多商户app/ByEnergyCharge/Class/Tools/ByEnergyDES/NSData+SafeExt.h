//
//  NSData+SafeExt.h
//  SafeParam
//
//  Created by SRC on 2020/4/14.
//  Copyright © 2020 SRC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SafeExt)

/// 数据流加密 base64编码输出
/// @param key key
/// @param iv 偏移量 不使用传nil
- (NSString *)ext_encryptToString:(NSString *)key ivString:(NSString *)iv;

/// 数据流加密
/// @param key key
/// @param iv 偏移量 不使用传nil
- (NSData *)ext_encryptToData:(NSString *)key ivString:(NSString *)iv;

/// 数据流解密
/// @param key key
/// @param iv 偏移量 不使用传nil
- (NSDictionary *)ext_decryptToDict:(NSString *)key ivString:(NSString *)iv;

/// 数据流解密
/// @param key key
/// @param iv 偏移量 不使用传nil
- (NSData *)ext_decryptToData:(NSString *)key ivString:(NSString *)iv;

@end
