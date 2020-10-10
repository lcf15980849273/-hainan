//
//  MoneyCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "MoneyCell.h"

@interface MoneyCell ()

@property (weak, nonatomic) IBOutlet UIButton *moneyButton;

@end
@implementation MoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moneyButton.layer.cornerRadius = 3;
    self.moneyButton.layer.borderWidth = 1;
    self.moneyButton.layer.borderColor = BYENERGYCOLOR(0xc7c7c7).CGColor;
}

- (void)setModel:(ChargeMoneyModel *)model {
    _model = model;
    [self.moneyButton setBackgroundColor:_model.isSelcet ? BYENERGYCOLOR(0x00BFE5) : [UIColor whiteColor]];
    [self.moneyButton setTitle:_model.name forState:UIControlStateNormal];
    if (_model.isSelcet) {
        [self.moneyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         self.moneyButton.layer.borderColor = [UIColor clearColor].CGColor;
    }else {
        [self.moneyButton setTitleColor:BYENERGYCOLOR(0xc7c7c7) forState:UIControlStateNormal];
        self.moneyButton.layer.borderColor = BYENERGYCOLOR(0xc7c7c7).CGColor;
    }
}
@end
