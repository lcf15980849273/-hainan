//
//  BEnergyChargeOrderModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargeOrderModel.h"


@implementation BEnergyChargeOrderModel

- (void)setStubGroupName:(NSString *)stubGroupName {
    _stubGroupName = stubGroupName;
    self.cellHeight = [byEnergyClearNilStr(_stubGroupName) sizeWithFont:ByEnergyRegularFont(16) maxSize:CGSizeMake(SCREENWIDTH-135, MAXFLOAT)].height+53;
}

- (void)setTimeCharge:(NSString *)timeCharge {
    _timeCharge = [StringUtils timeStrWithTimestamp:[timeCharge doubleValue] seperator:@":"];
}

@end
