//
//  AppDelegate+nomalSetup.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/17.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "AppDelegate+nomalSetup.h"
#import <AFNetworkReachabilityManager.h>
#import "IQKeyboardManager.h"
#import "ByEnergyPayHandler.h"//支付
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMCommon/UMConfigure.h>
#import "WXApi.h"
#import <objc/runtime.h>
#import "BEnergySystemInfoModel.h"
#import "BEnergySystemInfoViewModel.h"
#import "BEnergyStubGroupViewModel.h"
#import "BEnergyApiCloudStorage.h"
#import "BEnergyHomeVc.h"
#import "ByEnergyBaseNavi.h"
#import "WRNavigationBar.h"
#import "ByEnergyUserLoaction.h"
#import "UMSPPPayUnifyPayPlugin.h"
#import "ByEnergyUpateVersionTool.h"
static const void *kHasShowUpdateVersison = @"hasShowUpdateVersison";
static const void *kHasRequestSysteminfo = @"hasRequestSysteminfo";
static const void *kViewModel = @"viewModel";
static const void *kBEnergyStubGroupViewModel = @"BEnergyStubGroupViewModel";
@implementation AppDelegate (nomalSetup)

- (void)initWindow {
    [self setNaviBarAttributes];
    [self setupIQKeyboardManager];
    [self initUmenAttributes];
    [ByEnergyUserLoaction sharedByEnergyUserLoaction];
    [[UIButton appearance] setExclusiveTouch:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma mark 初始化
- (void)setupByEnergyChargeUserManager {
    self.tabbarController = [ByEnergyBaseTB shareInstance];
    self.window.rootViewController = self.tabbarController;
    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
    self.viewModel = [[BEnergySystemInfoViewModel alloc] init];
    self.stubGroupViewModel = [[BEnergyStubGroupViewModel alloc] init];
    [self bindViewModel];
    kWeakSelf(self);
    ByEnergyReceivedNotification(ByEnergyLoginStateChange, ^{
        [weakself.viewModel.hnSystemInfoCommand execute:nil];
    }());
    ByEnergyReceivedNotification(ByEnergyNetworkReachable, ^{
        if (weakself.hasRequestSysteminfo == NO) {
            [weakself.viewModel.hnSystemInfoCommand execute:nil];
            weakself.hasRequestSysteminfo = YES;
        }else {
            if([[BEnergyAppStorage sharedInstance] systemInfo]==nil) {
                [weakself.viewModel.hnSystemInfoCommand execute:nil];
            }
        }
    }());
}

#pragma 设置导航条
- (void)setNaviBarAttributes {
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    NSDictionary * dict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                            NSForegroundColorAttributeName:[UIColor blackColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:dict];
    [[UINavigationBar appearance] setTranslucent:NO];
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];

}

#pragma 设置键盘
- (void)setupIQKeyboardManager {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setShouldShowToolbarPlaceholder:NO];
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
}

#pragma mark 监听网络变化
- (void)byEnergyChargemonitorNetworkStatuChange {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            if ([BEnergyAppStorage sharedInstance].isNoNetContent == YES) {
                [[BEnergyAppStorage sharedInstance] setIsNoNetContent:NO];
            }
            ByEnergySendNotification(ByEnergyNetworkReachable, nil);
        }else if (status == AFNetworkReachabilityStatusNotReachable) {
            [[BEnergyAppStorage sharedInstance] setIsNoNetContent:YES];
        }
    }];
}

#pragma 设置友盟的分享所需参数
- (void)initUmenAttributes {
    [UMConfigure initWithAppkey:ByEnergyECUMAppKey channel:nil];
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:ByEnergyECWXAppId
                                       appSecret:ByEnergyECWXAppSecret
                                     redirectURL:@"https://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:@"1106094060"
                                       appSecret:nil
                                     redirectURL:@"http://mobile.umeng.com/social"];
//    [WXApi registerApp:ByEnergyECWXAppId];
    //微信sdk1.8.7.1
    [WXApi registerApp:ByEnergyECWXAppId universalLink:@"https://app.xmnewyea.com/"];
#ifdef DEBUG
#else
    [MobClick setScenarioType:E_UM_NORMAL];
    [UMConfigure setEncryptEnabled:YES];
#endif
}

- (void)bindViewModel {
    ByEnergyWeakSekf
    [[[[self.viewModel.hnSystemInfoCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            if ([[[BEnergyAppStorage sharedInstance] systemInfo] updateEnabled] >= 1) {
                [self.viewModel.hnCheckAppStoreVersion execute:nil];
            }
        }
    }];
    
    [[[[self.viewModel.hnCheckAppStoreVersion executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            NSDictionary *returnInfo = [NSJSONSerialization JSONObjectWithData:x options:0 error:nil];
            NSArray *returnArray = returnInfo[@"results"];
            if (returnArray.count <= 0) {
                return;
            }
            NSDictionary *releaseInfo = [returnArray firstObject];
            NSString *latestVersion = releaseInfo[@"version"];
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
            NSComparisonResult comparisonResult = [currentVersion compare:latestVersion options:NSNumericSearch];
            if (comparisonResult == NSOrderedAscending) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *appstoreUrl = [releaseInfo objectForKey:@"trackViewUrl"];
                    NSString *releaseNotes = [releaseInfo objectForKey:@"releaseNotes"];
                    int isEnabled = [[[BEnergyAppStorage sharedInstance] systemInfo] updateEnabled];
                    [SCAlertViewUtils showAlertWithType:SCAlertTypeAlert
                                                  title:@"更新提示！"
                                                message:([releaseNotes length] > 0 ? releaseNotes:@"有新版本发布了！")
                                      cancelButtonTitle:isEnabled == 2 ? nil : @"稍后再说"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@[@"立即升级"]
                                      completionHandler:^(SCAlertButtonType buttonType, NSUInteger buttonIndex) {
                                          ByEnergyStrongSelf
                                          if (buttonType == SCAlertButtonTypeOther) {
                                              if ([[[[[BEnergyAppStorage sharedInstance] systemInfo] auth] versionUpdate] value] == 2) {
                                                  self.hasShowUpdateVersison = YES;
                                              }
                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl]];
                                          }
                                      }];
                });
            }
        }
    }];
    
    [[[[self.viewModel.hnGetTokenCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        
    }];
    [self.viewModel.hnGetTokenCommand execute:nil];
}

#pragma 设置根视图
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler  API_AVAILABLE(ios(9.0)){
    NSLog(@"shortcutItem%@", shortcutItem);
}

- (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self byEnergyChargemonitorNetworkStatuChange];
    if([[[BEnergyAppStorage sharedInstance] systemInfo] updateEnabled] == 2 && self.hasShowUpdateVersison) {
        self.hasShowUpdateVersison = NO;
        [self.viewModel.hnCheckAppStoreVersion execute:nil];
    }
}

#pragma mark - 3rd app methods
//独立客户端回调函数
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"url.absoluteString)=%@",url.absoluteString);
    BOOL result2 = [[UMSocialManager defaultManager] handleOpenURL:url];
    BOOL result1 = [ByEnergyPayHandler handleOpenURL:url];
    return result1||result2;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    // TODO: 测试微信支付和微信分享时，是否进入同一代理方法
    BOOL result2 = [[UMSocialManager defaultManager] handleOpenURL:url];
    BOOL result1 = [ByEnergyPayHandler handleOpenURL:url];
    return result1||result2;
}

//微信sdk1.7以上需要加上这个支付成功才会走回调
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
   return [WXApi handleOpenUniversalLink:userActivity delegate:[ByEnergyPayHandler sharedInstance]];
}

#pragma mark ----- setter,getter
- (void)setHasShowUpdateVersison:(BOOL)hasShowUpdateVersison {
    objc_setAssociatedObject(self, kHasShowUpdateVersison, [NSNumber numberWithBool:hasShowUpdateVersison], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hasShowUpdateVersison {
    return [objc_getAssociatedObject(self, kHasShowUpdateVersison) boolValue];
}

- (void)setHasRequestSysteminfo:(BOOL)hasRequestSysteminfo {
    objc_setAssociatedObject(self, kHasRequestSysteminfo, [NSNumber numberWithBool:hasRequestSysteminfo], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hasRequestSysteminfo {
    return [objc_getAssociatedObject(self, kHasRequestSysteminfo) boolValue];
}

- (void)setViewModel:(BEnergySystemInfoViewModel *)viewModel {
    objc_setAssociatedObject(self, kViewModel, viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BEnergySystemInfoViewModel *)viewModel {
    return objc_getAssociatedObject(self, kViewModel);
}

- (void)setStubGroupViewModel:(BEnergyStubGroupViewModel *)stubGroupViewModel {
    objc_setAssociatedObject(self, kBEnergyStubGroupViewModel, stubGroupViewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BEnergyStubGroupViewModel *)stubGroupViewModel {
    return objc_getAssociatedObject(self, kBEnergyStubGroupViewModel);
}

@end
