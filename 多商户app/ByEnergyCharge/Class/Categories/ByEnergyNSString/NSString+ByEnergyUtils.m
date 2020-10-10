//
//  NSString+ByEnergyUtils.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "NSString+ByEnergyUtils.h"

@implementation NSString (ByEnergyUtils)

+ (NSString *) doubleReplaceWithNumber:(double)d {
    
    NSString *dStr = [NSString stringWithFormat:@"%f", d];
    NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:dStr];
    return [NSString stringWithFormat:@"%@",dn.stringValue];
}
@end
