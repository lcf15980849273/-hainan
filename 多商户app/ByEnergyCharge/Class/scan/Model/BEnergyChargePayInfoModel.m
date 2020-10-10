//
//  BEnergyChargePayInfoModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargePayInfoModel.h"

@implementation BEnergyChargePayInfoModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"chargeType" : @"ChargeTypeModel",
             @"chargeMoney" : @"ChargeMoneyModel"
             };
}
@end

@implementation ChargeTypeModel


@end

@implementation ChargeMoneyModel


@end
