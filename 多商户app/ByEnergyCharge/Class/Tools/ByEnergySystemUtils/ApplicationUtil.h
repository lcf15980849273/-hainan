//
//  ApplicationUtil.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/12.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationUtil : NSObject

/**
 返回当前App的版本号
 @return    NSString    当前版本号
 */
+ (NSString *)nowAppVersion;

/**
 保存与key关联的App版本号
 @param     versionStr  要保存的版本号
 @param     key         关联的key，比如引导页、用户信息等
 @return    无返回值
 */
+ (void)saveAppVersion:(NSString *)versionStr forKey:(NSString *)key;

/**
 返回上次保存的与key关联的App版本号
 @param     key         关联的key，比如引导页、用户信息等
 @return    NSString    上次版本号
 */
+ (NSString *)lastAppVersionForKey:(NSString *)key;

/**
 返回App名称
 @return    NSString    App名称
 */
+ (NSString *)appName;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

@end
