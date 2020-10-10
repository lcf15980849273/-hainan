//
//  BEnergyRechargeViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"
#import "ByEnergyPayHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyRechargeViewModel : ByEnergyBaseViewModel
@property (nonatomic, assign) GDPayPlatform payType; //0、支付宝 1、微信 2、银联
@property (nonatomic, strong) RACCommand *hnMoneyChargeCommand; // 发起充值
@property (nonatomic, strong) RACCommand *hnPayOrderUpdateCommand;// 更新订单
@property (nonatomic, strong) RACCommand *hnSearchOrderCommand;// 查询订单号
@end

NS_ASSUME_NONNULL_END
