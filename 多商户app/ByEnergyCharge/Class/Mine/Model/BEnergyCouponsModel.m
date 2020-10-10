//
//  BEnergyCouponsModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyCouponsModel.h"

@implementation BEnergyCouponsModel

- (void)setUseRangeDec:(NSString *)useRangeDec {
    _useRangeDec = useRangeDec;
    self.useRangeHeight = [byEnergyClearNilStr(useRangeDec) sizeWithFont:ByEnergyRegularFont(10) maxSize:CGSizeMake(SCREENWIDTH-138, 25)].height <= 14?14:25;
}


@end
