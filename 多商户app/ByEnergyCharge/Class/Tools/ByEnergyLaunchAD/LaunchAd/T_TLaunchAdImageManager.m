//
//  T_TLaunchAdImageManager.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import "T_TLaunchAdImageManager.h"
#import "T_TLaunchAdCache.h"

@interface T_TLaunchAdImageManager()

@property(nonatomic,strong) T_TLaunchAdDownloader *downloader;
@end

@implementation T_TLaunchAdImageManager

+(nonnull instancetype )sharedManager{
    static T_TLaunchAdImageManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[T_TLaunchAdImageManager alloc] init];
        
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _downloader = [T_TLaunchAdDownloader sharedDownloader];
    }
    return self;
}

- (void)loadImageWithURL:(nullable NSURL *)url options:(T_TLaunchAdImageOptions)options progress:(nullable T_TLaunchAdDownloadProgressBlock)progressBlock completed:(nullable T_TExternalCompletionBlock)completedBlock{
    if(!options) options = T_TLaunchAdImageDefault;
    if(options & T_TLaunchAdImageOnlyLoad){
        [_downloader downloadImageWithURL:url progress:progressBlock completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
            if(completedBlock) completedBlock(image,data,error,url);
        }];
    }else if (options & T_TLaunchAdImageRefreshCached){
        NSData *imageData = [T_TLaunchAdCache getCacheImageDataWithURL:url];
        UIImage *image =  [UIImage imageWithData:imageData];
        if(image && completedBlock) completedBlock(image,imageData,nil,url);
        [_downloader downloadImageWithURL:url progress:progressBlock completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
            if(completedBlock) completedBlock(image,data,error,url);
            [T_TLaunchAdCache async_saveImageData:data imageURL:url completed:nil];
        }];
    }else if (options & T_TLaunchAdImageCacheInBackground){
        NSData *imageData = [T_TLaunchAdCache getCacheImageDataWithURL:url];
        UIImage *image =  [UIImage imageWithData:imageData];
        if(image && completedBlock){
            completedBlock(image,imageData,nil,url);
        }else{
            [_downloader downloadImageWithURL:url progress:progressBlock completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
                [T_TLaunchAdCache async_saveImageData:data imageURL:url completed:nil];
            }];
        }
    }else{//default
        NSData *imageData = [T_TLaunchAdCache getCacheImageDataWithURL:url];
        UIImage *image =  [UIImage imageWithData:imageData];
        if(image && completedBlock){
            completedBlock(image,imageData,nil,url);
        }else{
            [_downloader downloadImageWithURL:url progress:progressBlock completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
                if(completedBlock) completedBlock(image,data,error,url);
                [T_TLaunchAdCache async_saveImageData:data imageURL:url completed:nil];
            }];
        }
    }
}
@end
