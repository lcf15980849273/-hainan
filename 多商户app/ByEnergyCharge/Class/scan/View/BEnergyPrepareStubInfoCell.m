//
//  BEnergyPrepareStubInfoCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/26.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyPrepareStubInfoCell.h"

@interface BEnergyPrepareStubInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *chargeTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *chargePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stubNumberLabel;
@end
@implementation BEnergyPrepareStubInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}

- (void)setModel:(BEnergyStubChargeDetailsModel *)model {
    _model = model;
    self.chargePriceLabel.text = [NSString stringWithFormat:@"%.4f元/度",_model.totalFee];
    self.stubNumberLabel.text = _model.stuId;
    if ([_model.type isEqualToString:@"0"]) { //0：交流电(ac)，1：直流电(dc)，2：交直流'
        self.chargeTypeLabel.text = @"交流充电";
    }else if ([_model.type isEqualToString:@"1"]) {
        self.chargeTypeLabel.text = @"直流充电";
    }else {
        self.chargeTypeLabel.text = @"交直流充电";
    }
}

@end
