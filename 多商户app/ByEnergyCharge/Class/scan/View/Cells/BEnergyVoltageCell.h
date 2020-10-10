//
//  BEnergyVoltageCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/28.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergyVoltageCell = @"BEnergyVoltageCell";
@interface BEnergyVoltageCell : UITableViewCell
@property (nonatomic, copy) void(^seleltVoltageButtonBlock)(int tag);
@end

NS_ASSUME_NONNULL_END
