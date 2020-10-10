//
//  BEnergyUserWalletBalanceModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/8/21.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"
#import "BEnergyActiveChargeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyUserWalletBalanceModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *totalAmount; //当前余额
@property (nonatomic, copy) NSString *availableAmount; //可用金额
@property (nonatomic, assign) CGFloat userAmount; //用户余额
@property (nonatomic, copy) NSString *freezingAmount; //冻结金额
@property (nonatomic, assign) NSInteger cashFreezingStatus; //是否有冻结金额  0.有,1.没有
@property (nonatomic, assign) NSInteger cashStatus; //提现开关：0.开，1.关
@property(nonatomic, assign) int isBandChargeCard; //是否有绑卡
@property (nonatomic, copy) NSString *chargeCardNo; //卡号
@property (nonatomic, copy) NSString *giveAmount;//活动充值金额
@property (nonatomic, strong) NSArray <BEnergyActiveChargeModel *> *rechargeActivityList;//活动列表
@end

NS_ASSUME_NONNULL_END
