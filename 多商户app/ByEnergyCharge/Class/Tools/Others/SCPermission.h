//
//  SCPermission.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SCPermissionType) {
    /*定位权限*/
    SCPermissionType_Location,
    /*相机权限*/
    SCPermissionType_Camera,
    /*相册权限*/
    SCPermissionType_Photos,
};

@interface SCPermission : NSObject

/**
 whether permission has been obtained, only return status, not request permission
 for example, u can use this method in app setting, show permission status
 in most cases, suggest call "authorizeWithType:completion" method
 
 @param type permission type
 */
+ (void)authorizedWithType:(SCPermissionType)type WithResult:(void(^)( BOOL granted))completion;

/**
 跳转至手机设置
 */
+ (void)displayAppPrivacySettings;

@end

NS_ASSUME_NONNULL_END
