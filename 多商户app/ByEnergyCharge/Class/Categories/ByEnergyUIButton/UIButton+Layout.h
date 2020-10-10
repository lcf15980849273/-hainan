//
//  UIButton+Layout.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/19.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Layout)

/**
 设置文字位置
 */
@property (nonatomic,assign) CGRect titleRect;
/**
 设置图片位置
 */
@property (nonatomic,assign) CGRect imageRect;

/**
图片左，文字右
*/
- (void)setIconInLeftWithSpacing:(CGFloat)Spacing;
/**
图片右，文字左
*/
- (void)setIconInRightWithSpacing:(CGFloat)Spacing;
/**
图片上，文字下
*/
- (void)setIconInTopWithSpacing:(CGFloat)Spacing;
/**
图片下，文字上
*/
- (void)setIconInBottomWithSpacing:(CGFloat)Spacing;
@end
