//
//  SCPhotoUtil.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SCPhotoCompleteBlock)(NSData *imageData);
@interface SCPhotoUtil : NSObject
/**
 类方法，单例化
 @return    GDPhotoUtil实例
 */
+ (instancetype)sharedInstance;

/**
 返回folder下面fileName的本地路径
 @param     folder      文件夹名称
 @param     fileName    文件名称
 @return    NSString    文件的本地路径
 */
+ (NSString *)getPhotoLocalPathWithFolder:(NSString *)folder fileName:(NSString *)fileName;

/**
 从相机或者照片中获取图片
 @param     editEnabled         是否允许编辑
 @param     targetSize          目标尺寸
 @param     compressionQuality  压缩率
 @param     completeBlock       获取图片成功后的回调block  
 */
- (void)takePhotoWithEditEnabled:(BOOL)editEnabled
                      targetSize:(CGSize)targetSize
              compressionQuality:(CGFloat)compressionQuality
                       completed:(SCPhotoCompleteBlock)completeBlock;

@end

NS_ASSUME_NONNULL_END
