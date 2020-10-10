//
//  ByEnergyNotificationMacro.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/2/24.
//  Copyright © 2020年 newyea. All rights reserved.
//

#ifndef ByEnergyNotificationMacro_h
#define ByEnergyNotificationMacro_h

/*
 通知相关的宏定义
 */

/*  发通知  */
#define ByEnergySendNotification(name,obj)  [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

/*  RAC收通知免移除  */
#define ByEnergyReceivedNotification(name,block)  [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:name object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) { \
block; }];

#pragma mark - ——————— 用户相关 ————————

#define ByEnergyLoginStateChange                   @"loginStateChange" // 登录状态改变通知
#define ByEnergyLogout                             @"userHasLogout" // 户退出登录
#define ADDetailPushCenter                         @"ADDetailSelect" // 启动页广告通知key
#define ByEnergyErrorNetWork                       @"ErrorNetWork" // 网络断开通知
#define ByEnergySearchIdleStub                     @"searchIdleStub" // 搜索桩群
#define GuideAppVersionKey                         @"GuideAppVersionKey" // 引导页
#define ByEnergyNetworkReachable                   @"networkReachable" // 网络状态变化
#define ByEnergyRefreshFocusList                   @"refreshFocusList" // 刷新轮播图
#define ByEnergyChargeOrderRefresh                 @"ChargeOrderRefresh" // 刷新充电订单
#define ByEnergyUpdateHomeChargeList               @"UpdateHomeChargeList" // 刷新首页状态
#define ByEnergyUpdateUserInfo                     @"UpdateUserInfo" // 刷新用户信息
#define ByEnergyUpdateRemoveMapPopView             @"removeMapPopView" // 移除首页点击定位时弹出的小框
#define kByEnergyUpdateBadge                       @"updateBadge" // 刷新tabarBadge
#define ByEnergyUpdateNoticeHomePopView            @"noticeHomePopView" // 登录成功后展示弹窗
#define ByEnergyRefreshMyAmount                    @"refreshMyAmount" // 提现成功后刷新我的钱包页面

#pragma mark - ——————— 缓存key ————————
#define StubGroupSearchPreferences                 @"stubGroupSearchPreferences"
#define StubPreferences                            @"StubPreferences"
#define HistoryCity                                @"historyCity"
#define HistorySearch                              @"historySearch"
#define TokenFailure                               @"newyea_token_Failure"


#endif /* ByEnergyNotificationMacro_h */
