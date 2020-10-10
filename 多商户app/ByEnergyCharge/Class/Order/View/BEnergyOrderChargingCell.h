//
//  BEnergyOrderChargingCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEnergyChargeListModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergyOrderChargingCell = @"BEnergyOrderChargingCell";
@interface BEnergyOrderChargingCell : UITableViewCell

@property (nonatomic, strong) BEnergyChargeListModel *chargeListModel;
@property (nonatomic, copy) void(^stopChargingBlock)(void);
@end

NS_ASSUME_NONNULL_END
