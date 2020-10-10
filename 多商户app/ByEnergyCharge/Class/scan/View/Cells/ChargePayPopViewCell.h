//
//  ChargePayPopViewCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEnergyChargePayInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kChargePayPopViewCell = @"ChargePayPopViewCell";
@interface ChargePayPopViewCell : UITableViewCell

@property(nonatomic, strong)ChargeTypeModel *model;
@end

NS_ASSUME_NONNULL_END
