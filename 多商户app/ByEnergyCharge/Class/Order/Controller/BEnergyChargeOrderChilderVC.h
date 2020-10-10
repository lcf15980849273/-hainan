//
//  BEnergyChargeOrderChilderVC.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ChargeOrderType) {
    ChargeOrderTypeForChargeing = 1,     //  充电中
    ChargeOrderTypeForWaitPay = 2,      //  待支付
    ChargeOrderTypeForFinish = 3,       //  已完成
};

@interface BEnergyChargeOrderChilderVC : BEnergyBaseViewController

@property (nonatomic, assign) ChargeOrderType orderType;

- (void)refreshDatas;

@end

NS_ASSUME_NONNULL_END
