//
//  NSDate+date.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (date)
/** 获取当前的时间 */
+ (NSString *)byEnergyFetchCurrentDateString;
/** 按指定格式获取当前的时间 */
+ (NSString *)byEnergyFetchCurrentDateStringWithFormat:(NSString *)formatterStr;
//获取当前时间戳
+(NSString *)getNowTimeTimestamp;
@end
