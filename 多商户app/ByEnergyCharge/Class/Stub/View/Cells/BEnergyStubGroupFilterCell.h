//
//  BEnergyStubGroupFilterCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/15.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import <UIKit/UIKit.h>

@interface BEnergyStubGroupFilterCell : BEnergyBaseTableViewCell
@property (nonatomic, strong) RACSubject *selectSubject;
- (instancetype)initWithStartChargeCellModel:(BEnergyStartChargeCellModel *)model;
- (void)configUIWithSelectedIndex:(int)index;
@end
