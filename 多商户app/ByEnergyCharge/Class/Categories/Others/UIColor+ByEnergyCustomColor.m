//
//  UIColor+ByEnergyCustomColor.m
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "UIColor+ByEnergyCustomColor.h"

@implementation UIColor (ByEnergyCustomColor)

/**
 * #FFFFFF 或者0xFFFFFF 字符串（html颜色值转 uicolor）
 */
+ (UIColor *) colorByEnergyWithBinaryString:(NSString *) hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6)
    return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
    cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
    return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *) colorByEnergyWithBinaryString:(NSString *) hexString Alpha:(CGFloat)alpha
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6)
    return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"])
    cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
    return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)byEnergyBlack {
    return [UIColor colorByEnergyWithBinaryString:@"2F2F2F"];
}

+ (UIColor *)byEnergyGreen {
    return [UIColor colorByEnergyWithBinaryString:@"08DF56"];
}

+ (UIColor *)byEnergyGray {
    return [UIColor colorByEnergyWithBinaryString:@"919191"];
}

+ (UIColor *)byEnergyLightGray {
    return [UIColor colorByEnergyWithBinaryString:@"eeeeee"];
}

+ (UIColor *)byEnergyTextGray {
    return [UIColor colorByEnergyWithBinaryString:@"D2D2D2"];
}

+ (UIColor *)byEnergyPlaceholderGray {
    return [UIColor colorByEnergyWithBinaryString:@"C5C5C5"];
}

+ (UIColor *)byEnergyLineGray {
    return [UIColor colorByEnergyWithBinaryString:@"F4F4F4"];
}

+ (UIColor *)byEnergyTextBlack {
    return [UIColor colorByEnergyWithBinaryString:@"333333"];
}

+ (UIColor *)byEnergyTitleTextBlack {
    return [UIColor colorByEnergyWithBinaryString:@"353535"];
}

+ (UIColor *)byEnergyDefaultWhite {
    return [UIColor colorByEnergyWithBinaryString:@"#FFFFFF"];
}

+ (UIColor *)byEnergyTextDefaultGray {
    return [UIColor colorByEnergyWithBinaryString:@"7C7C7C"];
}

+ (UIColor *)byEnergyNaiBarBackgroungColor {
    return [UIColor colorByEnergyWithBinaryString:@"0CE152"];
}

+ (UIColor *)byEnergyTarBarTextColor {
    return [UIColor colorByEnergyWithBinaryString:@"#2FD076"];
}

@end
