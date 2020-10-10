//
//  BEnergyUserAmountDetailModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyUserAmountDetailModel.h"

@implementation BEnergyUserAmountDetailModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"bank_description":@"description"}];
}

@end
