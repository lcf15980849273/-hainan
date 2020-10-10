//
//  ShareViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/23.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ByEnergyShareViewModel : ByEnergyBaseViewModel
@property (nonatomic, strong) RACCommand *ShareWithCouponInfo; // 分享送优惠券相关信息
@end

NS_ASSUME_NONNULL_END
