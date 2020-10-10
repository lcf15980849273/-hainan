//
//  UIImage+Color.h
//  StarCharge
//
//  Created by newyea on 2020/3/21.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)
+ (UIImage *)imageFromColorMu:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
