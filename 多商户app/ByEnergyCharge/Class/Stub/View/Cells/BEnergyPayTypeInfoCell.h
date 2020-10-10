//
//  BEnergyPayTypeInfoCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/7.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "BEnergyStubGroupDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergyPayTypeInfoCell = @"BEnergyPayTypeInfoCell";
@interface BEnergyPayTypeInfoCell : BEnergyBaseTableViewCell

@property(nonatomic, strong)BEnergyStubGroupDetailModel *model;
@end

NS_ASSUME_NONNULL_END
