//
//  StringForUnit.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "StringForUnit.h"

@implementation StringForUnit
//米转km
+ (NSString *)getKmStrWithMeter:(int)meter unitStr:(NSString *)unitStr {
    NSString *kmStr = nil;
    if (meter < 100) {
        kmStr = [NSString stringWithFormat:@"<0.1%@",unitStr];
    }
    else {
        float km = (float)meter/1000.0;
        kmStr = [NSString stringWithFormat:@"%.01f%@",km,unitStr];
    }
    return kmStr;
}

@end
