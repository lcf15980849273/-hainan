//
//  NSString+ByEnergySize.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "NSString+ByEnergySize.h"

@implementation NSString (ByEnergySize)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary *dict = @{NSFontAttributeName: font};
    size = [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:dict
                              context:nil].size;
    return size;
}

@end
