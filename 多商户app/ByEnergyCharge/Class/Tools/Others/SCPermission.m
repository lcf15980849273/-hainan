
//
//  SCPermission.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "SCPermission.h"
#import "SCAlertViewUtils.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>

#define DisplayName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

@implementation SCPermission

+ (void)authorizedWithType:(SCPermissionType)type WithResult:(void(^)( BOOL granted))completion{
    kWeakSelf(self);
    if (type == SCPermissionType_Photos) {
        [self isPhotoValidWithResult:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(granted);
            });
            if (granted == NO) {
                [weakself showPremissionAlert:NSStringFormat(@"请允许'%@'访问您的相册，是否前往设置",DisplayName)];
            }
        }];
    }else if (type == SCPermissionType_Camera) {
        [self isCameraValidWithResult:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(granted);
            });
            if (granted == NO) {
                [weakself showPremissionAlert:NSStringFormat(@"请允许'%@'访问您的相机，是否前往设置",DisplayName)];
            }
        }];
        
    }else if (type == SCPermissionType_Location) {
        [self isLocationEnabledWithResult:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(granted);
            });
            if (granted == NO) {
                [weakself showPremissionAlert:NSStringFormat(@"请允许'%@'确定您的当前位置，是否前往设置",DisplayName)];
            }
        }];
    }
}

+ (void)isPhotoValidWithResult:(void(^)( BOOL granted))completion {
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    if (photoStatus == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                completion(YES);
            } else {
                completion(NO);
            }
        }];
    } else if (photoStatus == PHAuthorizationStatusAuthorized) {
        completion(YES);
    } else if(photoStatus == PHAuthorizationStatusRestricted||photoStatus == PHAuthorizationStatusDenied){
        completion(NO);
    }else{
        completion(NO);
    }
}

+ (void)isCameraValidWithResult:(void(^)( BOOL granted))completion {
    if(NLSystemVersionGreaterOrEqualThan(7)) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusNotDetermined){
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                completion(granted);
            }];
        }  else if (authStatus == AVAuthorizationStatusAuthorized) {
            completion(YES);
        } else if(authStatus == AVAuthorizationStatusRestricted||authStatus == AVAuthorizationStatusDenied){
            completion(NO);
            
        }else{
            completion(NO);
        }
    }
}

+ (void)isLocationEnabledWithResult:(void(^)( BOOL granted))completion {
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        //定位功能可用
        completion(YES);
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //定位不能用
        completion(NO);
    }
}

+ (void)showPremissionAlert:(NSString *)message {
    [SCAlertViewUtils showAlertWithType:SCAlertTypeAlert
                                  title:nil
                                message:message
                      cancelButtonTitle:@"知道啦"
                 destructiveButtonTitle:nil
                      otherButtonTitles:@[@"设置"]
                      completionHandler:^(SCAlertButtonType buttonType, NSUInteger buttonIndex) {
                          if (buttonType == SCAlertButtonTypeOther) {
                              [SCPermission displayAppPrivacySettings];
                          }
                      }];
}

/**
 跳转至手机设置
 */
+ (void)displayAppPrivacySettings
{
    if (UIApplicationOpenSettingsURLString != NULL)
    {
        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if (@available(iOS 10,*)) {
            [[UIApplication sharedApplication]openURL:appSettings options:@{} completionHandler:^(BOOL success) {
            }];
        }
        else
        {
            [[UIApplication sharedApplication]openURL:appSettings];
        }
    }
}

@end
