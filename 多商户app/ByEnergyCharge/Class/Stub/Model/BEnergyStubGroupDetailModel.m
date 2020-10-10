
//
//  BEnergyStubGroupDetailModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubGroupDetailModel.h"
#import "StringForUnit.h"

@implementation BEnergyStubGroupDetailModel

- (void)setName:(NSString *)name {
    _name = name;
    NSString *distance = [StringForUnit getKmStrWithMeter:[self.distance intValue] unitStr:@"km"];
    CGFloat distanceWidth = [distance sizeWithFont:ByEnergyRegularFont(14) maxSize:CGSizeMake(SCREENWIDTH-100, MAXFLOAT)].width;
    self.stubNameHeight = [byEnergyClearNilStr(_name) sizeWithFont:ByEnergyRegularFont(18) maxSize:CGSizeMake(SCREENWIDTH-40-distanceWidth, 60)].height;
}

- (void)setInfo:(NSString *)info {
    _info = info;
    self.remarkHeight = [byEnergyClearNilReturnStr(_info, @"暂无备注") sizeWithFont:ByEnergyRegularFont(14) maxSize:CGSizeMake(SCREENWIDTH-40, MAXFLOAT)].height+58?:65;
}

- (void)setParkingFeeInfo:(NSString *)parkingFeeInfo {
    _parkingFeeInfo = parkingFeeInfo;
    self.parkingHeight = [byEnergyClearNilReturnStr(_parkingFeeInfo, @"暂无说明") sizeWithFont:ByEnergyRegularFont(14) maxSize:CGSizeMake(SCREENWIDTH-40, MAXFLOAT)].height+58?:65;
}

@end

@implementation Electricrulelist

@end


@implementation Stublist

@end


@implementation Pricedetails

@end

@implementation auxiliaryList

@end

