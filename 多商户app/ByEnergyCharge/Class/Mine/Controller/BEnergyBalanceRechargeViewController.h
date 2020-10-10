//
//  BEnergyBalanceRechargeViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"
#import "BEnergyActiveChargeModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum {
    BalanceRechargeForOneself,   //  为自己充值
    BalanceRechargeForOther,     //  为他人充值
}BalanceRechargeType;

@interface BEnergyBalanceRechargeViewController : BEnergyBaseViewController
@property (nonatomic, strong) NSArray <BEnergyActiveChargeModel *> *activeArray;
@property (nonatomic, copy) void(^refreshChargeStartViewData)(void);
@end

NS_ASSUME_NONNULL_END
