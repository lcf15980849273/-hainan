//
//  BEnergySystemNoticeListCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "BEnergyNoticeCenterModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergySystemNoticeListCell = @"BEnergySystemNoticeListCell";
@interface BEnergySystemNoticeListCell : BEnergyBaseTableViewCell

@property(nonatomic, strong)BEnergyNoticeCenterModel *model;
@end

NS_ASSUME_NONNULL_END
