//
//  UIImage+BDColorImage.h
//

#import <UIKit/UIKit.h>

@interface UIImage (BDColorImage)

+ (UIImage *)zm_imageWithColor:(UIColor *)color;
+ (UIImage *)zm_imageWithColor:(UIColor *)color withImageSize:(CGSize)size;
+ (UIImage *)zm_imageWithColor:(UIColor *)color withImageSize:(CGSize)size withCornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)zm_imageWithName:(NSString *)name;
@end
