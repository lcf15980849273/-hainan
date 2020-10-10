//
//  BEnergySCUserStorage.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEnergySCUserStorage : NSObject
/**
 类方法，判断用户是否登录
 @return    BOOL
 */
+ (BOOL)hasLogined;

/**
 单例化
 @return    GDUserStorage实例
 */
+ (instancetype)sharedInstance;

/**
 返回用户信息
 @return    用户信息
 */
- (id)userInfo;

/**
 保存用户信息
 @param     userInfo    用户信息
 */
- (void)saveUserInfo:(id)userInfo;

/**
 清空用户信息
 */
- (void)clearUserInfo;
@end
