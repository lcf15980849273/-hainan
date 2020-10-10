//
//  BDShopCounponDetailModel.m
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopCounponDetailModel.h"

@implementation BDShopCounponDetailModel

- (NSString *)storeAddress {
    if (self.businessProvince.length > 0 && self.businessCity.length > 0 && self.businessCounty.length > 0 && self.businessAddress.length > 0) {
        return [NSString stringWithFormat:@"%@%@%@%@",self.businessProvince,self.businessCity,self.businessCounty,self.businessAddress];
    }else if (self.businessProvince.length > 0 && self.businessCity.length > 0 && self.businessCounty.length > 0 && self.businessAddress.length == 0) {
        return [NSString stringWithFormat:@"%@%@%@",self.businessProvince,self.businessCity,self.businessCounty];
    }else if (self.businessProvince.length > 0 && self.businessCity.length > 0 && self.businessCounty.length == 0 && self.businessAddress.length == 0) {
        return [NSString stringWithFormat:@"%@%@",self.businessProvince,self.businessCity];
    }else {
        return [NSString stringWithFormat:@"%@",self.businessProvince];
    }
}
@end
