//
//  BEnergyMyCouponsTableViewCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyMyCouponsTableViewCell : BEnergyBaseTableViewCell
/**
 
 券状态 0.有效，1.失效
 */
@property (nonatomic, assign) NSInteger status;
@end

NS_ASSUME_NONNULL_END
