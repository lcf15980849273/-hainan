//
//  SystemUtils.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemUtils : NSObject

/**
 查看本机安装的地图

 @return NSArray
 */
+(NSArray *)checkHasOwnApp;

/**
 获取UUID

 @return NSString
 */
+ (NSString *)getUUID;

/**
 获取DeviceId

 @return NSString
 */
+ (NSString *)getDeviceId;

@end
