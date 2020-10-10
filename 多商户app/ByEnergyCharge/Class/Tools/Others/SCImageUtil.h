//
//  SCImageUtil.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCImageUtil : NSObject
/**
 对图片sourceImage按照尺寸size进行压缩
 @param     sourceImage     源图片
 @param     size            目标尺寸
 @return    UIImage
 */
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

/**
 通过颜色color来生成一个指定尺寸size的纯色图片
 @param     color   颜色
 @param     size    目标尺寸
 @return    UIImage
 */
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;

/**
 静态方法，返回bundle下的图片
 @param     bundleName      bundle名称
 @param     directory       图片在bundle中的路径
 @param     imageName       图片名称
 @param     imageType       图片类型
 @return    UIImage
 */
+ (UIImage *)imageInBundle:(NSString *)bundleName
                 directory:(NSString *)directory
                 imageName:(NSString *)imageName
                 imageType:(NSString *)imageType;


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
                            textFont:(UIFont *)textFont;
@end

NS_ASSUME_NONNULL_END
