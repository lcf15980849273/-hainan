//
//  BEnergyPrepareStubInfoCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/26.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEnergyStubChargeDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergyPrepareStubInfoCell = @"BEnergyPrepareStubInfoCell";
@interface BEnergyPrepareStubInfoCell : UITableViewCell

@property (nonatomic, strong) BEnergyStubChargeDetailsModel *model;
@end

NS_ASSUME_NONNULL_END
