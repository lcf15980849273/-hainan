//
//  BEnergyCustomeMoneyView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"
#import "ByEnergyRechargeTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyCustomeMoneyView : BEnergyBaseView
@property (nonatomic, strong) ByEnergyRechargeTextField *textField;
@property (nonatomic, strong) RACSubject *reChargeSubject;
@end

NS_ASSUME_NONNULL_END
