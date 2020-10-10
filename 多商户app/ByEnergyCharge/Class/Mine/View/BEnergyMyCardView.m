//
//  BEnergyMyCardView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/13.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyMyCardView.h"

@implementation BEnergyMyCardView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"BEnergyMyCardView" owner:self options:nil]lastObject];
        [self byEnergyInitSubView];
    }
    return self;
}
@end
