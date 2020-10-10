//
//  AppDelegate.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/22.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "AppDelegate.h"
//#import "AppDelegate+Service.h"
#import "UncaughtExceptionHandler.h"
#import "LaunchAdManager.h"
#import "AFNetWorkUtils.h"
#import <objc/runtime.h>
#import <Bugly/Bugly.h>
#import "AppDelegate+nomalSetup.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //网络请求设置
    //设置请求超时时间
    [AFNetWorkUtils setRequestTimeoutInterval:30.0f];
    //按App版本号缓存网络请求内容 可修改版本号查看效果 或 使用自定义版本号方法
    [AFNetWorkUtils setCacheVersionEnabled:YES];
    
    //设置引导页模式
    [LaunchAdManager setGuideShowType:kGuideShowTypeNone];
    //    [self setupTouchItem];
    ///配置高德地图
    [AMapServices sharedServices].apiKey = ByEnergyECAMAPKey;
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    //初始化window
    [self initWindow];
    [self setupByEnergyChargeUserManager];
    [self byEnergyChargemonitorNetworkStatuChange];
#pragma mark -----异常处理
#ifdef DEBUG
    [AFNetWorkUtils setLogEnabled:YES];
#else
    /*
     默认样式
     InstallUncaughtExceptionHandler();
     */
    InstallUncaughtExceptionHandler().showAlert(YES).logFileHandle(^(NSString *path) {
        //path：日志文件的路径，日志是一个名字为“ExceptionLog_sp”的“txt”文件
        //也可用这种方法获得路径：[[UncaughtExceptionHandler shareInstance]exceptionFilePath]
        //每次异常都会调用该block
        //处理完成后调用（如果不调用则程序不会退出）主要是为了处理耗时操作
        ExceptionHandlerFinishNotify();
        
    }).showExceptionInfor(NO).didClick(^(NSString *ExceptionMessage){
        //点击（继续）后的处理，比如将崩溃信息上传到服务器，该字符串为：异常信息
    }).message(@"请联系客服人员，我们会尽快让技术人员解决，给您带来的不便，敬请谅解！").title(@"抱歉，程序出现了异常");
#endif

    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
