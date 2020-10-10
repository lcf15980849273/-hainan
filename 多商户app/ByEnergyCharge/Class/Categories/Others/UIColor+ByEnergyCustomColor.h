//
//  UIColor+ByEnergyCustomColor.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ByEnergyCustomColor)

/**
 * #FFFFFF 或者0xFFFFFF 字符串（html颜色值转 uicolor）
 */
+ (UIColor *) colorByEnergyWithBinaryString:(NSString *) hexString;

+ (UIColor *) colorByEnergyWithBinaryString:(NSString *) hexString Alpha:(CGFloat)alpha;

+ (UIColor *)byEnergyBlack;
+ (UIColor *)byEnergyGreen;
+ (UIColor *)byEnergyGray;
+ (UIColor *)byEnergyLightGray;
+ (UIColor *)byEnergyTextGray;
+ (UIColor *)byEnergyTextBlack;
+ (UIColor *)byEnergyPlaceholderGray;
+ (UIColor *)byEnergyLineGray;
+ (UIColor *)byEnergyDefaultWhite;
+ (UIColor *)byEnergyTitleTextBlack;
+ (UIColor *)byEnergyTextDefaultGray;
+ (UIColor *)byEnergyTarBarTextColor;
/**
 导航栏背景颜色
 */
+ (UIColor *)byEnergyNaiBarBackgroungColor;
@end
