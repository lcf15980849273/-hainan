//
//  BEnergyChargePayPopView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEnergyChargePayInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyChargePayPopView : UIView

- (void)viewShow;
- (void)viewHiden;

@property (nonatomic, copy) void(^commitButtonkBlock)(ChargeTypeModel *chargeTypeModel,ChargeMoneyModel *moneyModel);

@property(nonatomic, strong)BEnergyChargePayInfoModel *model;
@end

NS_ASSUME_NONNULL_END
