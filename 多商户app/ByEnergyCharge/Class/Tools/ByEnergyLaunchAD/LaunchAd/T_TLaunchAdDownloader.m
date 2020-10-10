//
//  T_TLaunchAdDownloader.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import "T_TLaunchAdDownloader.h"
#import "T_TLaunchAdCache.h"
#import "FLAnimatedImage.h"
#import "T_TLaunchAdConst.h"

#pragma mark - T_TLaunchAdDownload

@interface T_TLaunchAdDownload()

@property (strong, nonatomic) NSURLSession *session;
@property(strong,nonatomic)NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, assign) unsigned long long totalLength;
@property (nonatomic, assign) unsigned long long currentLength;
@property (nonatomic, copy) T_TLaunchAdDownloadProgressBlock progressBlock;
@property (strong, nonatomic) NSURL *url;

@end
@implementation T_TLaunchAdDownload

@end

#pragma mark -  T_TLaunchAdImageDownload
@interface T_TLaunchAdImageDownload()<NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>

@property (nonatomic, copy ) T_TLaunchAdDownloadImageCompletedBlock completedBlock;

@end
@implementation T_TLaunchAdImageDownload

-(nonnull instancetype)initWithURL:(nonnull NSURL *)url delegateQueue:(nonnull NSOperationQueue *)queue progress:(nullable T_TLaunchAdDownloadProgressBlock)progressBlock completed:(nullable T_TLaunchAdDownloadImageCompletedBlock)completedBlock{
    self = [super init];
    if (self) {
        self.url = url;
        self.progressBlock = progressBlock;
        _completedBlock = completedBlock;
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 15.0;
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                     delegate:self
                                                delegateQueue:queue];
        self.downloadTask =  [self.session downloadTaskWithRequest:[NSURLRequest requestWithURL:url]];
        [self.downloadTask resume];
    }
    return self;
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    UIImage *image = [UIImage imageWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_completedBlock) {
            _completedBlock(image,data, nil);
            // 防止重复调用
            _completedBlock = nil;
        }
        //下载完成回调
        if ([self.delegate respondsToSelector:@selector(downloadFinishWithURL:)]) {
            [self.delegate downloadFinishWithURL:self.url];
        }
    });
    //销毁
    [self.session invalidateAndCancel];
    self.session = nil;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    self.currentLength = totalBytesWritten;
    self.totalLength = totalBytesExpectedToWrite;
    if (self.progressBlock) {
        self.progressBlock(self.totalLength, self.currentLength);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error){
        T_TLaunchAdLog(@"error = %@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_completedBlock) {
                _completedBlock(nil,nil, error);
            }
            _completedBlock = nil;
        });
    }
}

//处理HTTPS请求的
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    NSURLProtectionSpace *protectionSpace = challenge.protectionSpace;
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef serverTrust = protectionSpace.serverTrust;
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

@end

#pragma makr - T_TLaunchAdVideoDownload
@interface T_TLaunchAdVideoDownload()<NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>

@property (nonatomic, copy ) T_TLaunchAdDownloadVideoCompletedBlock completedBlock;
@end
@implementation T_TLaunchAdVideoDownload

-(nonnull instancetype)initWithURL:(nonnull NSURL *)url delegateQueue:(nonnull NSOperationQueue *)queue progress:(nullable T_TLaunchAdDownloadProgressBlock)progressBlock completed:(nullable T_TLaunchAdDownloadVideoCompletedBlock)completedBlock{
    self = [super init];
    if (self) {
        self.url = url;
        self.progressBlock = progressBlock;
        _completedBlock = completedBlock;
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 15.0;
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                     delegate:self
                                                delegateQueue:queue];
        self.downloadTask =  [self.session downloadTaskWithRequest:[NSURLRequest requestWithURL:url]];
        [self.downloadTask resume];
    }
    return self;
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSError *error=nil;
    NSURL *toURL = [NSURL fileURLWithPath:[T_TLaunchAdCache videoPathWithURL:self.url]];
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:toURL error:&error];
    if(error)  T_TLaunchAdLog(@"error = %@",error);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_completedBlock) {
            if(!error){
                _completedBlock(toURL,nil);
            }else{
                _completedBlock(nil,error);
            }
            // 防止重复调用
            _completedBlock = nil;
        }
        //下载完成回调
        if ([self.delegate respondsToSelector:@selector(downloadFinishWithURL:)]) {
            [self.delegate downloadFinishWithURL:self.url];
        }
    });
    [self.session invalidateAndCancel];
    self.session = nil;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    self.currentLength = totalBytesWritten;
    self.totalLength = totalBytesExpectedToWrite;
    if (self.progressBlock) {
        self.progressBlock(self.totalLength, self.currentLength);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error){
        T_TLaunchAdLog(@"error = %@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_completedBlock) {
                _completedBlock(nil, error);
            }
            _completedBlock = nil;
        });
    }
}
@end

#pragma mark - T_TLaunchAdDownloader
@interface T_TLaunchAdDownloader()<T_TLaunchAdDownloadDelegate>
@property (strong, nonatomic, nonnull) NSOperationQueue *downloadImageQueue;
@property (strong, nonatomic, nonnull) NSOperationQueue *downloadVideoQueue;
@property (strong, nonatomic) NSMutableDictionary *allDownloadDict;
@end

@implementation T_TLaunchAdDownloader

+(nonnull instancetype )sharedDownloader{
    static T_TLaunchAdDownloader *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[T_TLaunchAdDownloader alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _downloadImageQueue = [NSOperationQueue new];
        _downloadImageQueue.maxConcurrentOperationCount = 6;
        _downloadImageQueue.name = @"com.it7090.T_TLaunchAdDownloadImageQueue";
        _downloadVideoQueue = [NSOperationQueue new];
        _downloadVideoQueue.maxConcurrentOperationCount = 3;
        _downloadVideoQueue.name = @"com.it7090.T_TLaunchAdDownloadVideoQueue";
        T_TLaunchAdLog(@"T_TLaunchAdCachePath:%@",[T_TLaunchAdCache ttLaunchAdCachePath]);
    }
    return self;
}

- (void)downloadImageWithURL:(nonnull NSURL *)url progress:(nullable T_TLaunchAdDownloadProgressBlock)progressBlock completed:(nullable T_TLaunchAdDownloadImageCompletedBlock)completedBlock{
    NSString *key = [self keyWithURL:url];
    if(self.allDownloadDict[key]) return;
    T_TLaunchAdImageDownload * download = [[T_TLaunchAdImageDownload alloc] initWithURL:url delegateQueue:_downloadImageQueue progress:progressBlock completed:completedBlock];
    download.delegate = self;
    [self.allDownloadDict setObject:download forKey:key];
}

- (void)downloadImageAndCacheWithURL:(nonnull NSURL *)url completed:(void(^)(BOOL result))completedBlock{
    if(url == nil){
        if(completedBlock) completedBlock(NO);
        return;
    }
    [self downloadImageWithURL:url progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
        if(error){
            if(completedBlock) completedBlock(NO);
        }else{
            [T_TLaunchAdCache async_saveImageData:data imageURL:url completed:^(BOOL result, NSURL * _Nonnull URL) {
                if(completedBlock) completedBlock(result);
            }];
        }
    }];
}

-(void)downLoadImageAndCacheWithURLArray:(NSArray<NSURL *> *)urlArray{
    [self downLoadImageAndCacheWithURLArray:urlArray completed:nil];
}

- (void)downLoadImageAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray completed:(nullable T_TLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock{
    if(urlArray.count==0) return;
    __block NSMutableArray * resultArray = [[NSMutableArray alloc] init];
    dispatch_group_t downLoadGroup = dispatch_group_create();
    [urlArray enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL *stop) {
        if(![T_TLaunchAdCache checkImageInCacheWithURL:url]){
            dispatch_group_enter(downLoadGroup);
            [self downloadImageAndCacheWithURL:url completed:^(BOOL result) {
                dispatch_group_leave(downLoadGroup);
                [resultArray addObject:@{@"url":url.absoluteString,@"result":@(result)}];
            }];
        }else{
            [resultArray addObject:@{@"url":url.absoluteString,@"result":@(YES)}];
        }
    }];
    dispatch_group_notify(downLoadGroup, dispatch_get_main_queue(), ^{
        if(completedBlock) completedBlock(resultArray);
    });
}

- (void)downloadVideoWithURL:(nonnull NSURL *)url progress:(nullable T_TLaunchAdDownloadProgressBlock)progressBlock completed:(nullable T_TLaunchAdDownloadVideoCompletedBlock)completedBlock{
    NSString *key = [self keyWithURL:url];
    if(self.allDownloadDict[key]) return;
    T_TLaunchAdVideoDownload * download = [[T_TLaunchAdVideoDownload alloc] initWithURL:url delegateQueue:_downloadVideoQueue progress:progressBlock completed:completedBlock];
    download.delegate = self;
    [self.allDownloadDict setObject:download forKey:key];
}

- (void)downloadVideoAndCacheWithURL:(nonnull NSURL *)url completed:(void(^)(BOOL result))completedBlock{
    if(url == nil){
        if(completedBlock) completedBlock(NO);
        return;
    }
    [self downloadVideoWithURL:url progress:nil completed:^(NSURL * _Nullable location, NSError * _Nullable error) {
        if(error){
            if(completedBlock) completedBlock(NO);
        }else{
            [T_TLaunchAdCache async_saveVideoAtLocation:location URL:url completed:^(BOOL result, NSURL * _Nonnull URL) {
                if(completedBlock) completedBlock(result);
            }];
        }
    }];
}

- (void)downLoadVideoAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray{
    [self downLoadVideoAndCacheWithURLArray:urlArray completed:nil];
}

- (void)downLoadVideoAndCacheWithURLArray:(nonnull NSArray <NSURL *> * )urlArray completed:(nullable T_TLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock{
    if(urlArray.count==0) return;
    __block NSMutableArray * resultArray = [[NSMutableArray alloc] init];
    dispatch_group_t downLoadGroup = dispatch_group_create();
    [urlArray enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL *stop) {
        if(![T_TLaunchAdCache checkVideoInCacheWithURL:url]){
            dispatch_group_enter(downLoadGroup);
            [self downloadVideoAndCacheWithURL:url completed:^(BOOL result) {
                dispatch_group_leave(downLoadGroup);
                [resultArray addObject:@{@"url":url.absoluteString,@"result":@(result)}];
            }];
        }else{
            [resultArray addObject:@{@"url":url.absoluteString,@"result":@(YES)}];
        }
    }];
    dispatch_group_notify(downLoadGroup, dispatch_get_main_queue(), ^{
        if(completedBlock) completedBlock(resultArray);
    });
}

- (NSMutableDictionary *)allDownloadDict {
    if (!_allDownloadDict) {
        _allDownloadDict = [[NSMutableDictionary alloc] init];
    }
    return _allDownloadDict;
}

- (void)downloadFinishWithURL:(NSURL *)url{
    [self.allDownloadDict removeObjectForKey:[self keyWithURL:url]];
}

-(NSString *)keyWithURL:(NSURL *)url{
    return [T_TLaunchAdCache md5String:url.absoluteString];
}
@end
