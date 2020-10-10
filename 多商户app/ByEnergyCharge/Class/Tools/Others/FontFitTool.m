//
//  FontFitTool.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "FontFitTool.h"

@implementation FontFitTool

+ (nullable UIFont *)FontWithType:(FontFitType)fontType size:(CGFloat)fontSize {
    
    UIFont *font;
    switch (fontType) {
        case FontTypeHN:
            font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
            break;
        case FontTypeHN_Medium:
            font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
            break;
        case FontTypeHN_Bold:
            font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
            break;
        case FontTypeHN_Light:
            font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
            break;
        case FontTypeHel_Bold:
            font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
            break;
        case FontTypeHel_Oblique:
            font = [UIFont fontWithName:@"Helvetica-Oblique" size:fontSize];
            break;
        case FontTypeHel_BoldOblique:
            font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:fontSize];
            break;
        case FontTypePing_SemiBold:
            font = [UIFont fontWithName:@"PingFangSC-SemiBold" size:fontSize];
            break;
            
        default:
            font = [UIFont systemFontOfSize:fontSize];
            break;
    }
    
    return font;
    
}

@end
