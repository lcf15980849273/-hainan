//
//  BEnergyStubChargeDetailsModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubChargeDetailsModel.h"

@implementation BEnergyStubChargeDetailsModel

- (void)setName:(NSString *)name {
    _name = name;
    CGSize size = [byEnergyClearNilStr(_name) sizeWithFont:ByEnergyRegularFont(18) maxSize:CGSizeMake(SCREENWIDTH-40, MAXFLOAT)];
    self.cellHeight = size.height?:50;
}

@end
