//
//  BEnergyCarNumberTableViewCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "BEnergyCarListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyCarNumberTableViewCell : BEnergyBaseTableViewCell
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) BEnergyCarListModel *carListModel;
@end

NS_ASSUME_NONNULL_END
