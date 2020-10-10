//
//  UIView+cornerRadius.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020 newyea. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (cornerRadius)
/*
 给UIView及子类单独添加圆角
 cornerRadius 圆角值
 borderWidth  边框大小
 borderColor  边框颜色
 corners      需要设置圆角的方向
 */
- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners;
@end

NS_ASSUME_NONNULL_END
