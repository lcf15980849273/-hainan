//
//  BEnergyPayTypeInfoCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/7.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyPayTypeInfoCell.h"

@interface BEnergyPayTypeInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@end

@implementation BEnergyPayTypeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(BEnergyStubGroupDetailModel *)model {
    _model = model;
    self.timeLabel.text = _model.serviceTime;
    self.addressLabel.text = _model.address;
    self.telLabel.text = _model.tel.length > 0 ? _model.tel : @"无";
}

@end
