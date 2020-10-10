//
//  BEnergyRechargeOneSelfView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"
#import "BEnergyChooseMoneyView.h"
#import "BEnergyCustomeMoneyView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyRechargeOneSelfView : BEnergyBaseView
@property (nonatomic, strong) RACSubject *reChargeSubject;
@property (nonatomic, strong) BEnergyChooseMoneyView *chooseView;
@property (nonatomic, strong) BEnergyCustomeMoneyView *customeMoneyView;
@end

NS_ASSUME_NONNULL_END
