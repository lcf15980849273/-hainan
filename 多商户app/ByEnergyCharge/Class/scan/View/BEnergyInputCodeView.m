//
//  BEnergyInputCodeView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInputCodeView.h"


@interface BEnergyInputCodeView ()



@end
@implementation BEnergyInputCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"BEnergyInputCodeView" owner:self options:nil]lastObject];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return self;
}


- (IBAction)commitButton:(UIButton *)sender {
    if (self.comitButtonBlock) {
        self.comitButtonBlock();
    }
}


- (void)viewHiden {
    [self removeFromSuperview];
}
@end
