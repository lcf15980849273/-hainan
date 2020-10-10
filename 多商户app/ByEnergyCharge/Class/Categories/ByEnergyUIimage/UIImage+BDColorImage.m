//
//  UIImage+BDColorImage.m
//

#import "UIImage+BDColorImage.h"

@implementation UIImage (BDColorImage)

#pragma mark - Public Method

+ (UIImage *)zm_imageWithColor:(UIColor *)color {
    return [self zm_imageWithColor:color withImageSize:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)zm_imageWithColor:(UIColor *)color withImageSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = nil;
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)zm_imageWithColor:(UIColor *)color withImageSize:(CGSize)size withCornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius) ];
    
    [path closePath];
    [path fill];
    
    UIImage *image = nil;
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)zm_imageWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    if (SCREENHEIGHT == 568) {
        CGFloat scale = 320.f / 375.f;
        CGSize newSize = CGSizeMake(image.size.width * scale, image.size.height * scale);
        ;
        return [image scaleToSize:newSize];
    }
    return image;
}

- (UIImage *)scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //Determine whether the screen is retina
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
