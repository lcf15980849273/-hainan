//
//  BEnergyBalanceRechargeCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class RechargeModel;
static NSString *kBEnergyBalanceRechargeCell = @"BEnergyBalanceRechargeCell";
@interface BEnergyBalanceRechargeCell : BEnergyBaseTableViewCell
@property (nonatomic, strong) RechargeModel *model;

@end

@interface RechargeModel : NSObject
@property (nonatomic, copy) NSString *payKey;
@property (nonatomic, copy) NSString *payTitle;
@property (nonatomic, copy) NSString *payValue;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) BOOL selected; //是否选中
@end
NS_ASSUME_NONNULL_END
