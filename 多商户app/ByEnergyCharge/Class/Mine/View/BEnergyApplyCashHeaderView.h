//
//  BEnergyApplyCashHeaderView.h
//  StarCharge
//
//  Created by newyea on 2020/8/22.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"
#import "ByEnergyRechargeTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyApplyCashHeaderView : BEnergyBaseView
@property (nonatomic, strong) ByEnergyRechargeTextField *textField;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, strong) UILabel *tipsLabel;//活动提示语句
@end

NS_ASSUME_NONNULL_END
