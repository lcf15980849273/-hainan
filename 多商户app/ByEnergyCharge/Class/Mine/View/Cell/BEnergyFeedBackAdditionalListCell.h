//
//  BEnergyFeedBackAdditionalListCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/7.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "BEnergyFeedBackCallBackListModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergyFeedBackAdditionalListCell = @"BEnergyFeedBackAdditionalListCell";

@interface BEnergyFeedBackAdditionalListCell : BEnergyBaseTableViewCell

@property(nonatomic, strong)ListModel *model;
@end

NS_ASSUME_NONNULL_END
