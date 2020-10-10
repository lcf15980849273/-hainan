//
//  BEnergyStubGroupFilterTableViewCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BEnergyStubGroupFilterTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectedBtn;

- (void)configUIWithStartChargeCellModel:(BEnergyStartChargeCellModel *)model;

@end
