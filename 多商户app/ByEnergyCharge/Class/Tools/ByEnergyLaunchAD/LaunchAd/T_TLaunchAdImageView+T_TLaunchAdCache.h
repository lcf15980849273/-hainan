//
//  T_TLaunchAdImageView+T_TLaunchAdCache.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import "T_TLaunchAdView.h"
#import "T_TLaunchAdImageManager.h"

@interface T_TLaunchAdImageView (T_TLaunchAdCache)

/**
 设置url图片
 
 @param url 图片url
 */
- (void)tt_setImageWithURL:(nonnull NSURL *)url;

/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 */
- (void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder;

/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 @param options T_TLaunchAdImageOptions
 */
- (void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(T_TLaunchAdImageOptions)options;

/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 @param completedBlock T_TExternalCompletionBlock
 */
- (void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable T_TExternalCompletionBlock)completedBlock;

/**
 设置url图片
 
 @param url 图片url
 @param completedBlock T_TExternalCompletionBlock
 */
- (void)tt_setImageWithURL:(nonnull NSURL *)url completed:(nullable T_TExternalCompletionBlock)completedBlock;


/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 @param options T_TLaunchAdImageOptions
 @param completedBlock T_TExternalCompletionBlock
 */
- (void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(T_TLaunchAdImageOptions)options completed:(nullable T_TExternalCompletionBlock)completedBlock;

/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 @param GIFImageCycleOnce gif是否只循环播放一次
 @param options T_TLaunchAdImageOptions
 @param GIFImageCycleOnceFinish gif播放完回调(GIFImageCycleOnce = YES 有效)
 @param completedBlock T_TExternalCompletionBlock
 */
- (void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder GIFImageCycleOnce:(BOOL)GIFImageCycleOnce options:(T_TLaunchAdImageOptions)options GIFImageCycleOnceFinish:(void(^_Nullable)(void))cycleOnceFinishBlock completed:(nullable T_TExternalCompletionBlock)completedBlock ;
@end

