
//
//  BRAddressModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BRAddressModel.h"

@implementation BRProvinceModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"v",
             @"city": @"n"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"city": [BRCityModel class]
             };
}

@end


@implementation BRCityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"v",
             @"town": @"n"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"town": [BRTownModel class]
             };
}

@end


@implementation BRTownModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"v"
             };
}

@end

