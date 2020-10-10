//
//  BEnergyChooseMoneyView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyChooseMoneyView : BEnergyBaseView
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) RACSubject *chooseSubject;
@end

NS_ASSUME_NONNULL_END
