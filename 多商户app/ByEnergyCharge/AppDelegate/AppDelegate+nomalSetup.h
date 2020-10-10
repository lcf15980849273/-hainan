//
//  AppDelegate+nomalSetup.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/17.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "AppDelegate.h"

@class BEnergySystemInfoViewModel,BEnergyStubGroupViewModel;
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (nomalSetup)
@property (nonatomic, assign) BOOL hasShowUpdateVersison; //是否已经显示过更新提示并且已经点击查看过
@property (nonatomic, assign) BOOL hasRequestSysteminfo;  //是否已经请求过systeminfo
@property (nonatomic, strong) BEnergySystemInfoViewModel *viewModel;
@property (nonatomic, strong) BEnergyStubGroupViewModel *stubGroupViewModel;

- (void)initWindow;//初始化 window
- (void)setupByEnergyChargeUserManager;//初始化用户系统
- (void)byEnergyChargemonitorNetworkStatuChange;//监听网络状态

@end

NS_ASSUME_NONNULL_END
