//
//  BDCityBusinessModel.m
//  bydeal
//
//  Created by chenfeng on 2019/1/2.
//  Copyright © 2019年 BD. All rights reserved.
//

#import "BDCityBusinessModel.h"

@implementation BDCityBusinessModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"business" : [BDBusinessModel class],
             @"citys" : [BDCityModel class],
             };
}
@end

@implementation BDCityModel

@end

@implementation BDBusinessModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"business" : [BDBusinessItemModel class],
             };
}
@end

@implementation BDBusinessItemModel

@end
