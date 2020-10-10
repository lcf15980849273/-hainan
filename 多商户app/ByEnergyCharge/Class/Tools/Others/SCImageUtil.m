//
//  SCImageUtil.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "SCImageUtil.h"

@implementation SCImageUtil
//对图片尺寸进行压缩--
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = heightFactor;
        }
        else{
            scaleFactor = widthFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor <= heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor > heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaledWidth, scaledHeight), NO, 0);
    
    CGRect thumbnailRect = CGRectZero;
    //    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (UIImage *)imageInBundle:(NSString *)bundleName
                 directory:(NSString *)directory
                 imageName:(NSString *)imageName
                 imageType:(NSString *)imageType {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    // 找到对应images夹下的图片
    NSString *imagePath = [[NSBundle bundleWithPath:bundlePath] pathForResource:imageName ofType:imageType inDirectory:directory];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

/**
 在图片上画文字
 @param sourceImage 原图
 @param textString 需要显示的文字
 @param textColor 文字颜色
 @param textFont 文字大小
 @return 带文字图片
 */
+ (UIImage *)imageGraphicsBeginImage:(UIImage *)sourceImage
                          textString:(NSString *)textString
                           textColor:(UIColor *)textColor
                            textFont:(UIFont *)textFont {
    UIImage *image = sourceImage;
    
    CGSize size=CGSizeMake(image.size.width, image.size.height);//画布大小
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [image drawAtPoint:CGPointMake(0, 0)];
    
    //获得一个位图图形上下文
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context, kCGPathStroke);
    //画
    [textString drawAtPoint:CGPointMake(2, -2) withAttributes:@{NSFontAttributeName:textFont,NSForegroundColorAttributeName:textColor}];
    
    //画自己想画的内容。。。。。
    
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
