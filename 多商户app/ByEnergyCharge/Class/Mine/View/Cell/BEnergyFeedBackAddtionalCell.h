//
//  BEnergyFeedBackAddtionalCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/7.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "BEnergyMyFeedBackListModel.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const kBEnergyFeedBackAddtionalCell = @"BEnergyFeedBackAddtionalCell";
@interface BEnergyFeedBackAddtionalCell : BEnergyBaseTableViewCell

@property(nonatomic, strong)BEnergyMyFeedBackListModel *model;
@end

NS_ASSUME_NONNULL_END
