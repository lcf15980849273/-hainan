//
//  NSDate+date.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "NSDate+date.h"

@implementation NSDate (date)
#pragma mark - 获取当前的时间
+ (NSString *)byEnergyFetchCurrentDateString {
    return [self byEnergyFetchCurrentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark - 按指定格式获取当前的时间
+ (NSString *)byEnergyFetchCurrentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}

//获取当前时间戳
+ (NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}
@end
