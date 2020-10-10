//
//  UIImage+Color.m
//  StarCharge
//
//  Created by newyea on 2019/3/21.
//  Copyright © 2019年 newyea. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+(UIImage *)imageFromColorMu:(UIColor *)color{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
