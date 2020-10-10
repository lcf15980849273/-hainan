//
//  BEnergyInvoiceDetailsModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceDetailsModel.h"

@implementation BEnergyInvoiceDetailsModel

@end

@implementation ConsumInfoItem

@end

@implementation BaseInfo

- (void)setAddress:(NSString *)address {
    _address = address;
    self.addressHeight = [self getHeihtWithValue:_address];;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.nameHeight = [self getHeihtWithValue:_name];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleHeight = [self getHeihtWithValue:_title];
}

- (void)setCorporationNum:(NSString *)corporationNum {
    _corporationNum = corporationNum;
    self.corporationNumHeight = [self getHeihtWithValue:_corporationNum];
}

- (CGFloat)getHeihtWithValue:(NSString *)value {
   return [byEnergyClearNilStr(value) sizeWithFont:ByEnergyRegularFont(14) maxSize:CGSizeMake(SCREENWIDTH-138, MAXFLOAT)].height > 50?:50;
}

@end

