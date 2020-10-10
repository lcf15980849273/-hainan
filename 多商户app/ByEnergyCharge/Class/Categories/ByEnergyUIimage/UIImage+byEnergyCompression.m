//
//  UIImage+byEnergyCompression.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "UIImage+byEnergyCompression.h"

@implementation UIImage (byEnergyCompression)

- (void)byEnergyCompressWithMaxKB:(NSUInteger)maxLengthKB
                          image:(UIImage *)image
                           Block :(void (^)(NSData *imageData))block {
    if (maxLengthKB <= 0 || [image isKindOfClass:[NSNull class]] || image == nil) block(nil);
    
    maxLengthKB = maxLengthKB*1024;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        CGFloat compression = 1;
        NSData *data = UIImageJPEGRepresentation(image, compression);
//        NSLog(@"初始 : %ld KB",data.length/1024);
        if (data.length < maxLengthKB){
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"压缩完成： %zd kb", data.length/1024);
                block(data);
            });
            return;
        }
        
        //质量压缩
        CGFloat scale = 1;
        CGFloat lastLength=0;
        for (int i = 0; i < 7; ++i) {
            compression = scale / 2;
            data = UIImageJPEGRepresentation(image, compression);
//            NSLog(@"质量压缩中： %ld KB", data.length / 1024);
            if (i>0) {
                if (data.length>0.95*lastLength) break;//当前压缩后大小和上一次进行对比，如果大小变化不大就退出循环
                if (data.length < maxLengthKB) break;//当前压缩后大小和目标大小进行对比，小于则退出循环
            }
            scale = compression;
            lastLength = data.length;
            
        }
//        NSLog(@"压缩图片质量后: %ld KB", data.length / 1024);
        if (data.length < maxLengthKB){
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"压缩完成： %zd kb", data.length/1024);
                block(data);
            });
            return;
        }
        
        //大小压缩
        UIImage *resultImage = [UIImage imageWithData:data];
        NSUInteger lastDataLength = 0;
        while (data.length > maxLengthKB && data.length != lastDataLength) {
            lastDataLength = data.length;
            CGFloat ratio = (CGFloat)maxLengthKB / data.length;
//            NSLog(@"Ratio = %.1f", ratio);
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                     (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            UIGraphicsBeginImageContext(size);
            [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            data = UIImageJPEGRepresentation(resultImage, compression);
//            NSLog(@"绘图压缩中： %ld KB", data.length / 1024);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"压缩完成： %ld kb", data.length/1024);
            block(data);
        });return;
    });
    
 }
@end
