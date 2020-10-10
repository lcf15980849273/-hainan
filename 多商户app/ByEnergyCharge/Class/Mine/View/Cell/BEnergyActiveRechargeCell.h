//
//  BEnergyActiveRechargeCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/3.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEnergyActiveChargeModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergyActiveRechargeCell = @"BEnergyActiveRechargeCell";
@interface BEnergyActiveRechargeCell : UITableViewCell
@property (nonatomic, strong) BEnergyActiveChargeModel *model;
@end

NS_ASSUME_NONNULL_END
