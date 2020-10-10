//
//  T_TLaunchAdImageManager.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "T_TLaunchAdDownloader.h"

typedef NS_OPTIONS(NSUInteger, T_TLaunchAdImageOptions) {
    /** 有缓存,读取缓存,不重新下载,没缓存先下载,并缓存 */
    T_TLaunchAdImageDefault = 1 << 0,
    /** 只下载,不缓存 */
    T_TLaunchAdImageOnlyLoad = 1 << 1,
    /** 先读缓存,再下载刷新图片和缓存 */
    T_TLaunchAdImageRefreshCached = 1 << 2 ,
    /** 后台缓存本次不显示,缓存OK后下次再显示(建议使用这种方式)*/
    T_TLaunchAdImageCacheInBackground = 1 << 3
};

typedef void(^T_TExternalCompletionBlock)(UIImage * _Nullable image,NSData * _Nullable imageData, NSError * _Nullable error, NSURL * _Nullable imageURL);

@interface T_TLaunchAdImageManager : NSObject

+(nonnull instancetype )sharedManager;
- (void)loadImageWithURL:(nullable NSURL *)url options:(T_TLaunchAdImageOptions)options progress:(nullable T_TLaunchAdDownloadProgressBlock)progressBlock completed:(nullable T_TExternalCompletionBlock)completedBlock;
@end
