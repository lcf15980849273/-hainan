//
//  BEnergyStubGroupDetailIntegralCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "BEnergyStubGroupDetailModel.h"
#import "BEnergyPriceFormView.h"
NS_ASSUME_NONNULL_BEGIN
/**
 价格时间表
 */
static NSString *const kBEnergyStubGroupDetailIntegralCell = @"BEnergyStubGroupDetailIntegralCell";
@interface BEnergyStubGroupDetailIntegralCell : BEnergyBaseTableViewCell

@property (nonatomic, strong) UIButton *scheduleBtn;
@property (nonatomic, strong) BEnergyPriceFormView *formView;
@property (nonatomic, strong) BEnergyStubGroupDetailModel *model;
- (void)configUIWithPricedetailsModel:(Pricedetails *)model;
@end

NS_ASSUME_NONNULL_END
