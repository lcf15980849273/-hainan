//
//  BEnergyHomeChargeListModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/24.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class Unpaid, BEnergyChargeListModel;

@interface BEnergyHomeChargeListModel : BEnergyBaseModel
/**
 *当前余额
 */
@property (nonatomic, assign) float userAmount;
/**
 *折扣
 */
@property (nonatomic, copy) NSString *unpaidDiscount;
/**
 *是否后置支付
 */
@property (nonatomic, assign) BOOL isUnpaid;
/**
 *后置支付门槛金额
 */
@property (nonatomic, assign) float userLessMoney;
/**
 *正在充电列表（与原取值一值）,无则为空数组
 */
@property (nonatomic, strong) NSArray <BEnergyChargeListModel *>*chargelist;
/**
 *待支付，无则为null
 */
@property (nonatomic, strong) BEnergyChargeListModel *unpaid;

@end


NS_ASSUME_NONNULL_END
