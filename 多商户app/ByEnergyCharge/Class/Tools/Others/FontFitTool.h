//
//  FontFitTool.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, FontFitType) {
    /*HelveticaNeue*/
    FontTypeHN,
    /*HelveticaNeue-Medium*/
    FontTypeHN_Medium,
    /*HelveticaNeue-Bold 加粗*/
    FontTypeHN_Bold,
    /*HelveticaNeue-Light*/
    FontTypeHN_Light,
    /*Helvetica-Bold 加粗*/
    FontTypeHel_Bold,
    /*Helvetica-Oblique 斜体*/
    FontTypeHel_Oblique,
    /*Helvetica-BoldOblique 加粗斜体*/
    FontTypeHel_BoldOblique,
    /*FontTypePing_SemiBold */
    FontTypePing_SemiBold,
};

@interface FontFitTool : NSObject

+ (nullable UIFont *)FontWithType:(FontFitType)fontType size:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
