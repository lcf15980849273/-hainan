//
//  BEnergyCouponsViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyCouponsViewModel : ByEnergyBaseViewModel
@property (nonatomic, assign) NSInteger status;// 券状态 0.有效，1.失效
@property (nonatomic, strong) RACCommand *hnCouponCountCommand;// 优惠券待使用数目
@property (nonatomic, strong) RACCommand *hnCouponListCommand;// 待使用、失效优惠券列表

@end

NS_ASSUME_NONNULL_END
