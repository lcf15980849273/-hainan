//
//  NSString+ByEnergySize.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ByEnergySize)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;
@end
