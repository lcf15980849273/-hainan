//
//  BEnergyUserCashViewModel.h
//  StarCharge
//
//  Created by newyea on 2020/8/22.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyUserCashViewModel : ByEnergyBaseViewModel
@property (nonatomic, strong) RACCommand *userCashInfoCommand; // 提现页信息
@property (nonatomic, strong) RACCommand *userCashApplyCommand; // 提现申请

@end

NS_ASSUME_NONNULL_END
