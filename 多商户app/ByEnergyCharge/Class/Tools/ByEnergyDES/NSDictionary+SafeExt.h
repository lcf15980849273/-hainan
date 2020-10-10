//
//  NSDictionary+SafeExt.h
//  SafeParam
//
//  Created by SRC on 2020/4/14.
//  Copyright © 2020 SRC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeExt)


/// 将base64字符串解码 解密 转成对象
/// @param string base64数据
+ (NSDictionary *)ext_dictionaryForBase64String:(NSString *)string key:(NSString *)key;


/// 将对象加密并转成base64输出
- (NSString *)ext_encryptForBase64String:(NSString *)key;

@end
