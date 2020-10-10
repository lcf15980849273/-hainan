//
//  BEnergyAmountDetailViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyAmountDetailViewModel : ByEnergyBaseViewModel
@property (nonatomic, strong) RACCommand *hnUserAmountDetailCommand;// 资金明细
@property (nonatomic, strong) RACCommand *hnUserWalletBalanceCommand;// 账户余额
@end

NS_ASSUME_NONNULL_END
