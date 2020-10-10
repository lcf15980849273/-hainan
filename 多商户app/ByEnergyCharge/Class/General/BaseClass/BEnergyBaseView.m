//
//  BEnergyBaseView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"

@implementation BEnergyBaseView

#pragma mark - Overrides
- (void)awakeFromNib {
    [super awakeFromNib];
    [self byEnergyInitSubView];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self byEnergyInitSubView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self byEnergyInitSubView];
    }
    return self;
}

#pragma mark - Public Method

- (void)byEnergyInitSubView {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
@end
