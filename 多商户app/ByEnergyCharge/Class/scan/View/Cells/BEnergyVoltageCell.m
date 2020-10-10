//
//  BEnergyVoltageCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/28.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyVoltageCell.h"
@interface BEnergyVoltageCell ()
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;

@end
@implementation BEnergyVoltageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.oneButton.selected = YES;
    [self setButtonBorderWithButton:self.twoButton];
    [self setButtonBorderNoWithButton:self.oneButton];
    [self.oneButton setBackgroundImage:IMAGEWITHNAME(@"Group_select_Scan") forState:UIControlStateNormal];
    [self.twoButton setBackgroundImage:IMAGEWITHNAME(@"") forState:UIControlStateNormal];
    
}

- (IBAction)oneButtonClick:(UIButton *)sender {
    
    self.oneButton.selected = YES;
    self.twoButton.selected = NO;
    [self setButtonBorderWithButton:self.twoButton];
    [self setButtonBorderNoWithButton:self.oneButton];
    [self.oneButton setBackgroundImage:IMAGEWITHNAME(@"Group_select_Scan") forState:UIControlStateNormal];
    [self.twoButton setBackgroundImage:IMAGEWITHNAME(@"") forState:UIControlStateNormal];
    
    if (self.seleltVoltageButtonBlock) {
        self.seleltVoltageButtonBlock(12);//12V
        
    }
}

- (IBAction)twoButtonClick:(UIButton *)sender {
    
    self.twoButton.selected = YES;
    self.oneButton.selected = NO;
    [self setButtonBorderWithButton:self.oneButton];
    [self setButtonBorderNoWithButton:self.twoButton];
    [self.twoButton setBackgroundImage:IMAGEWITHNAME(@"Group_select_Scan") forState:UIControlStateNormal];
    [self.oneButton setBackgroundImage:IMAGEWITHNAME(@"") forState:UIControlStateNormal];
    
    if (self.seleltVoltageButtonBlock) {
        self.seleltVoltageButtonBlock(24);//12V
        
    }
}

- (void)setButtonBorderWithButton:(UIButton *)button {
    button.layer.borderWidth = 1;
    button.layer.borderColor = BYENERGYCOLOR(0xc7c7c7).CGColor;
}

- (void)setButtonBorderNoWithButton:(UIButton *)button {
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor clearColor].CGColor;
}
@end
