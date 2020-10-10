//
//  NSString+ByEnergyEmoji.h
//  黑马微博
//
//  Created by MJ Lee on 14/7/12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ByEnergyEmoji)

/*
 *  16进制字符串转emoji字符串
 */
@property (nonatomic,copy,readonly) NSString *emoji;


/**
 *  是否为emoji字符
 */
- (BOOL)stringContainsEmoji;

// 主要是第三方键盘上的表情判断
- (BOOL)hasEmoji;

/**
 判断是不是九宫格
 @return YES(是九宫格拼音键盘)
 */
-(BOOL)isNineKeyBoard;

@end
