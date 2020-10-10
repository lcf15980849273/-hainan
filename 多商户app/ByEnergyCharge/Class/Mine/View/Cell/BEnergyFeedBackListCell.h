//
//  BEnergyFeedBackListCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "BEnergyFeedBackTypeModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergyFeedBackListCell = @"BEnergyFeedBackListCell";

@interface BEnergyFeedBackListCell : BEnergyBaseTableViewCell
@property(nonatomic, strong)BEnergyFeedBackTypeModel *model;

@end

NS_ASSUME_NONNULL_END
