//
//  ApplicationUtil.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/12.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "ApplicationUtil.h"

@implementation ApplicationUtil

+ (NSString *)nowAppVersion {
    //系统直接读取的版本号
    NSString *str = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleShortVersionString"];
    return str;
}

+ (NSString *)lastAppVersionForKey:(NSString *)key {
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //读取
    NSString *str = (NSString *)[defaults objectForKey:key];
    return str;
}

+ (void)saveAppVersion:(NSString *)versionStr forKey:(NSString *)key {
    if ([versionStr length]==0) {
        return;
    }
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:versionStr forKey:key];
    [defaults synchronize];
}

+ (NSString *)appName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return appName;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //如果是present上来的appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    } else {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result = nav.childViewControllers.lastObject;
        
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    } else {
        result = nextResponder;
    }
    return result;
}

@end
