//
//  T_TLaunchAdDownloader.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - T_TLaunchAdDownload

typedef void(^T_TLaunchAdDownloadProgressBlock)(unsigned long long total, unsigned long long current);

typedef void(^T_TLaunchAdDownloadImageCompletedBlock)(UIImage *_Nullable image, NSData * _Nullable data, NSError * _Nullable error);

typedef void(^T_TLaunchAdDownloadVideoCompletedBlock)(NSURL * _Nullable location, NSError * _Nullable error);

typedef void(^T_TLaunchAdBatchDownLoadAndCacheCompletedBlock) (NSArray * _Nonnull completedArray);

@protocol T_TLaunchAdDownloadDelegate <NSObject>

- (void)downloadFinishWithURL:(nonnull NSURL *)url;

@end

@interface T_TLaunchAdDownload : NSObject
@property (assign, nonatomic ,nonnull)id<T_TLaunchAdDownloadDelegate> delegate;
@end

@interface T_TLaunchAdImageDownload : T_TLaunchAdDownload

@end

@interface T_TLaunchAdVideoDownload : T_TLaunchAdDownload

@end

#pragma mark - T_TLaunchAdDownloader
@interface T_TLaunchAdDownloader : NSObject

+(nonnull instancetype )sharedDownloader;

- (void)downloadImageWithURL:(nonnull NSURL *)url progress:(nullable T_TLaunchAdDownloadProgressBlock)progressBlock completed:(nullable T_TLaunchAdDownloadImageCompletedBlock)completedBlock;

- (void)downLoadImageAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray;
- (void)downLoadImageAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray completed:(nullable T_TLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock;

- (void)downloadVideoWithURL:(nonnull NSURL *)url progress:(nullable T_TLaunchAdDownloadProgressBlock)progressBlock completed:(nullable T_TLaunchAdDownloadVideoCompletedBlock)completedBlock;

- (void)downLoadVideoAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray;
- (void)downLoadVideoAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray completed:(nullable T_TLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock;
@end
