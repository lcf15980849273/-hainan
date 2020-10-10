//
//  T_TLaunchAd.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import "T_TLaunchAd.h"
#import "T_TLaunchAdView.h"
#import "T_TLaunchAdImageView+T_TLaunchAdCache.h"
#import "T_TLaunchAdDownloader.h"
#import "T_TLaunchAdCache.h"
#import "FLAnimatedImage.h"
#import "T_TLaunchAdController.h"

typedef NS_ENUM(NSInteger, T_TLaunchAdType) {
    T_TLaunchAdTypeImage,
    T_TLaunchAdTypeVideo
};
#define HeadView_H (SCREENWIDTH*260)/720
static NSInteger defaultWaitDataDuration = 3;
static  SourceType _sourceType = SourceTypeLaunchImage;
@interface T_TLaunchAd()

@property(nonatomic,assign)T_TLaunchAdType launchAdType;
@property(nonatomic,assign)NSInteger waitDataDuration;
@property(nonatomic,strong)T_TLaunchImageAdConfiguration * imageAdConfiguration;
@property(nonatomic,strong)T_TLaunchVideoAdConfiguration * videoAdConfiguration;
@property(nonatomic,strong)T_TLaunchAdButton * skipButton;
@property(nonatomic,strong)T_TLaunchAdVideoView * adVideoView;
@property(nonatomic,strong)UIWindow * window;
@property(nonatomic,copy)dispatch_source_t waitDataTimer;
@property(nonatomic,copy)dispatch_source_t skipTimer;
@property (nonatomic, assign) BOOL detailPageShowing;
@property(nonatomic,assign) CGPoint clickPoint;
@end

@implementation T_TLaunchAd
+(void)setLaunchSourceType:(SourceType)sourceType{
    _sourceType = sourceType;
}
+(void)setWaitDataDuration:(NSInteger )waitDataDuration{
    T_TLaunchAd *launchAd = [T_TLaunchAd shareLaunchAd];
    launchAd.waitDataDuration = waitDataDuration;
}
+(T_TLaunchAd *)imageAdWithImageAdConfiguration:(T_TLaunchImageAdConfiguration *)imageAdconfiguration{
    return [T_TLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:nil];
}

+(T_TLaunchAd *)imageAdWithImageAdConfiguration:(T_TLaunchImageAdConfiguration *)imageAdconfiguration delegate:(id)delegate{
    T_TLaunchAd *launchAd = [T_TLaunchAd shareLaunchAd];
    if(delegate) launchAd.delegate = delegate;
    launchAd.imageAdConfiguration = imageAdconfiguration;
    return launchAd;
}

+(T_TLaunchAd *)videoAdWithVideoAdConfiguration:(T_TLaunchVideoAdConfiguration *)videoAdconfiguration{
    return [T_TLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:nil];
}

+(T_TLaunchAd *)videoAdWithVideoAdConfiguration:(T_TLaunchVideoAdConfiguration *)videoAdconfiguration delegate:(nullable id)delegate{
    T_TLaunchAd *launchAd = [T_TLaunchAd shareLaunchAd];
    if(delegate) launchAd.delegate = delegate;
    launchAd.videoAdConfiguration = videoAdconfiguration;
    return launchAd;
}

+(void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray{
    [self downLoadImageAndCacheWithURLArray:urlArray completed:nil];
}

+ (void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray completed:(nullable T_TLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock{
    if(urlArray.count==0) return;
    [[T_TLaunchAdDownloader sharedDownloader] downLoadImageAndCacheWithURLArray:urlArray completed:completedBlock];
}

+(void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray{
    [self downLoadVideoAndCacheWithURLArray:urlArray completed:nil];
}

+(void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray completed:(nullable T_TLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock{
    if(urlArray.count==0) return;
    [[T_TLaunchAdDownloader sharedDownloader] downLoadVideoAndCacheWithURLArray:urlArray completed:completedBlock];
}
+(void)removeAndAnimated:(BOOL)animated{
    [[T_TLaunchAd shareLaunchAd] removeAndAnimated:animated];
}

+(BOOL)checkImageInCacheWithURL:(NSURL *)url{
    return [T_TLaunchAdCache checkImageInCacheWithURL:url];
}

+(BOOL)checkVideoInCacheWithURL:(NSURL *)url{
    return [T_TLaunchAdCache checkVideoInCacheWithURL:url];
}
+(void)clearDiskCache{
    [T_TLaunchAdCache clearDiskCache];
}

+(void)clearDiskCacheWithImageUrlArray:(NSArray<NSURL *> *)imageUrlArray{
    [T_TLaunchAdCache clearDiskCacheWithImageUrlArray:imageUrlArray];
}

+(void)clearDiskCacheExceptImageUrlArray:(NSArray<NSURL *> *)exceptImageUrlArray{
    [T_TLaunchAdCache clearDiskCacheExceptImageUrlArray:exceptImageUrlArray];
}

+(void)clearDiskCacheWithVideoUrlArray:(NSArray<NSURL *> *)videoUrlArray{
    [T_TLaunchAdCache clearDiskCacheWithVideoUrlArray:videoUrlArray];
}

+(void)clearDiskCacheExceptVideoUrlArray:(NSArray<NSURL *> *)exceptVideoUrlArray{
    [T_TLaunchAdCache clearDiskCacheExceptVideoUrlArray:exceptVideoUrlArray];
}

+(float)diskCacheSize{
    return [T_TLaunchAdCache diskCacheSize];
}

+(NSString *)ttLaunchAdCachePath{
    return [T_TLaunchAdCache ttLaunchAdCachePath];
}

+(NSString *)cacheImageURLString{
    return [T_TLaunchAdCache getCacheImageUrl];
}

+(NSString *)cacheVideoURLString{
    return [T_TLaunchAdCache getCacheVideoUrl];
}

#pragma mark - 过期
/** 请使用removeAndAnimated: */
+(void)skipAction{
    [[T_TLaunchAd shareLaunchAd] removeAndAnimated:YES];
}
/** 请使用setLaunchSourceType: */
+(void)setLaunchImagesSource:(LaunchImagesSource)launchImagesSource{
    switch (launchImagesSource) {
        case LaunchImagesSourceLaunchImage:
            _sourceType = SourceTypeLaunchImage;
            break;
        case LaunchImagesSourceLaunchScreen:
            _sourceType = SourceTypeLaunchScreen;
            break;
        default:
            break;
    }
}

#pragma mark - private
+(T_TLaunchAd *)shareLaunchAd{
    static T_TLaunchAd *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[T_TLaunchAd alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupLaunchAd];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self setupLaunchAdEnterForeground];
        }];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self removeOnly];
        }];
        [[NSNotificationCenter defaultCenter] addObserverForName:T_TLaunchAdDetailPageWillShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            _detailPageShowing = YES;
        }];
        [[NSNotificationCenter defaultCenter] addObserverForName:T_TLaunchAdDetailPageShowFinishNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            _detailPageShowing = NO;
        }];
    }
    return self;
}

-(void)setupLaunchAdEnterForeground{
    switch (_launchAdType) {
        case T_TLaunchAdTypeImage:{
            if(!_imageAdConfiguration.showEnterForeground || _detailPageShowing) return;
            [self setupLaunchAd];
            [self setupImageAdForConfiguration:_imageAdConfiguration];
        }
            break;
        case T_TLaunchAdTypeVideo:{
            if(!_videoAdConfiguration.showEnterForeground || _detailPageShowing) return;
            [self setupLaunchAd];
            [self setupVideoAdForConfiguration:_videoAdConfiguration];
        }
            break;
        default:
            break;
    }
}

-(void)setupLaunchAd{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [T_TLaunchAdController new];
    window.rootViewController.view.backgroundColor = [UIColor clearColor];
    window.rootViewController.view.userInteractionEnabled = NO;
    window.windowLevel = UIWindowLevelStatusBar + 1;
    window.hidden = NO;
    window.alpha = 1;
    _window = window;
    /** 添加launchImageView */
    [_window addSubview:[[T_TLaunchImageView alloc] initWithSourceType:_sourceType]];
}

/**图片*/
-(void)setupImageAdForConfiguration:(T_TLaunchImageAdConfiguration *)configuration{
    if(_window == nil) return;
    [self removeSubViewsExceptLaunchAdImageView];
    T_TLaunchAdImageView *adImageView = [[T_TLaunchAdImageView alloc] init];
    [_window addSubview:adImageView];
    
    
//    UIView *view= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window.width, HeadView_H)];
//    view.backgroundColor = [UIColor whiteColor];
//    [_window addSubview:view];
//    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 386/2, 119/2)];
//    logoImage.image = [UIImage imageNamed:@"adsLogo"];
//    logoImage.center = CGPointMake(view.centerX, view.centerY+8);
//    view.alpha = 0;
//    [view addSubview:logoImage];
    BOOL isLoad = NO;
    
    /** frame */
    if(configuration.frame.size.width>0 && configuration.frame.size.height>0) adImageView.frame = configuration.frame;
    if(configuration.contentMode) adImageView.contentMode = configuration.contentMode;
    /** webImage */
    if(configuration.imageNameOrURLString.length && T_TISURLString(configuration.imageNameOrURLString)){
        [T_TLaunchAdCache async_saveImageUrl:configuration.imageNameOrURLString];
        /** 自设图片 */
        if ([self.delegate respondsToSelector:@selector(ttLaunchAd:launchAdImageView:URL:)]) {
            [self.delegate ttLaunchAd:self launchAdImageView:adImageView URL:[NSURL URLWithString:configuration.imageNameOrURLString]];
        }else{
            if(!configuration.imageOption) configuration.imageOption = T_TLaunchAdImageDefault;
            isLoad = YES;
            T_TWeakSelf
            [adImageView tt_setImageWithURL:[NSURL URLWithString:configuration.imageNameOrURLString] placeholderImage:nil GIFImageCycleOnce:configuration.GIFImageCycleOnce options:configuration.imageOption GIFImageCycleOnceFinish:^{
                //GIF不循环,播放完成
                [[NSNotificationCenter defaultCenter] postNotificationName:T_TLaunchAdGIFImageCycleOnceFinishNotification object:nil userInfo:@{@"imageNameOrURLString":configuration.imageNameOrURLString}];
                
            } completed:^(UIImage *image,NSData *imageData,NSError *error,NSURL *url){
                if(!error){
                    /** skipButton */
                    [self addSkipButtonForConfiguration:configuration];
                    [self startSkipDispathTimer];
//                    view.alpha = 1;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
                    
                    if ([weakSelf.delegate respondsToSelector:@selector(ttLaunchAd:imageDownLoadFinish:)]) {
                        [weakSelf.delegate ttLaunchAd:self imageDownLoadFinish:image];
                    }
#pragma clang diagnostic pop
                    if ([weakSelf.delegate respondsToSelector:@selector(ttLaunchAd:imageDownLoadFinish:imageData:)]) {
                        [self startSkipDispathTimer];
                        [weakSelf.delegate ttLaunchAd:self imageDownLoadFinish:image imageData:imageData];
                    }
                }
            }];
            if(configuration.imageOption == T_TLaunchAdImageCacheInBackground){
                /** 缓存中未有 */
                if(![T_TLaunchAdCache checkImageInCacheWithURL:[NSURL URLWithString:configuration.imageNameOrURLString]]){
                    [self removeAndAnimateDefault]; return; /** 完成显示 */
                }
            }
        }
    }else{
        if(configuration.imageNameOrURLString.length){
            NSData *data = T_TDataWithFileName(configuration.imageNameOrURLString);
            if(T_TISGIFTypeWithData(data)){
                FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
                adImageView.animatedImage = image;
                adImageView.image = nil;
                __weak typeof(adImageView) w_adImageView = adImageView;
                adImageView.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
                    if(configuration.GIFImageCycleOnce){
                        [w_adImageView stopAnimating];
                        T_TLaunchAdLog(@"GIF不循环,播放完成");
                        [[NSNotificationCenter defaultCenter] postNotificationName:T_TLaunchAdGIFImageCycleOnceFinishNotification object:@{@"imageNameOrURLString":configuration.imageNameOrURLString}];
                    }
                };
            }else{
                adImageView.animatedImage = nil;
                adImageView.image = [UIImage imageWithData:data];
            }
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            if ([self.delegate respondsToSelector:@selector(ttLaunchAd:imageDownLoadFinish:)]) {
                [self.delegate ttLaunchAd:self imageDownLoadFinish:[UIImage imageWithData:data]];
            }
#pragma clang diagnostic pop
        }else{
            T_TLaunchAdLog(@"未设置广告图片");
        }
    }
    if (!isLoad) {
        /** skipButton */
        [self addSkipButtonForConfiguration:configuration];
        [self startSkipDispathTimer];
//        view.alpha = 1;
    }
    /** customView */
    if(configuration.subViews.count>0)  [self addSubViews:configuration.subViews];
    T_TWeakSelf
    adImageView.click = ^(CGPoint point) {
        [weakSelf clickAndPoint:point];
    };
}

-(void)addSkipButtonForConfiguration:(T_TLaunchAdConfiguration *)configuration{
    if(!configuration.duration) configuration.duration = 5;
    if(!configuration.skipButtonType) configuration.skipButtonType = SkipTypeTimeText;
    if(configuration.customSkipView){
        [_window addSubview:configuration.customSkipView];
    }else{
        if(_skipButton == nil){
            _skipButton = [[T_TLaunchAdButton alloc] initWithSkipType:configuration.skipButtonType];
            _skipButton.hidden = YES;
            [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        [_window addSubview:_skipButton];
        [_skipButton setTitleWithSkipType:configuration.skipButtonType duration:configuration.duration];
    }
}

/**视频*/
-(void)setupVideoAdForConfiguration:(T_TLaunchVideoAdConfiguration *)configuration{
    if(_window ==nil) return;
    [self removeSubViewsExceptLaunchAdImageView];
    if(!_adVideoView){
        _adVideoView = [[T_TLaunchAdVideoView alloc] init];
    }
    [_window addSubview:_adVideoView];
    /** frame */
    if(configuration.frame.size.width>0&&configuration.frame.size.height>0) _adVideoView.frame = configuration.frame;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if(configuration.scalingMode) _adVideoView.videoScalingMode = configuration.scalingMode;
#pragma clang diagnostic pop
    if(configuration.videoGravity) _adVideoView.videoGravity = configuration.videoGravity;
    _adVideoView.videoCycleOnce = configuration.videoCycleOnce;
    if(configuration.videoCycleOnce){
        [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            T_TLaunchAdLog(@"video不循环,播放完成");
            [[NSNotificationCenter defaultCenter] postNotificationName:T_TLaunchAdVideoCycleOnceFinishNotification object:nil userInfo:@{@"videoNameOrURLString":configuration.videoNameOrURLString}];
        }];
    }
    /** video 数据源 */
    if(configuration.videoNameOrURLString.length && T_TISURLString(configuration.videoNameOrURLString)){
        [T_TLaunchAdCache async_saveVideoUrl:configuration.videoNameOrURLString];
        NSURL *pathURL = [T_TLaunchAdCache getCacheVideoWithURL:[NSURL URLWithString:configuration.videoNameOrURLString]];
        if(pathURL){
            if ([self.delegate respondsToSelector:@selector(ttLaunchAd:videoDownLoadFinish:)]) {
                [self.delegate ttLaunchAd:self videoDownLoadFinish:pathURL];
            }
            _adVideoView.contentURL = pathURL;
            _adVideoView.muted = configuration.muted;
            [_adVideoView.videoPlayer.player play];
        }else{
            T_TWeakSelf
            [[T_TLaunchAdDownloader sharedDownloader] downloadVideoWithURL:[NSURL URLWithString:configuration.videoNameOrURLString] progress:^(unsigned long long total, unsigned long long current) {
                if ([weakSelf.delegate respondsToSelector:@selector(ttLaunchAd:videoDownLoadProgress:total:current:)]) {
                    [weakSelf.delegate ttLaunchAd:self videoDownLoadProgress:current/(float)total total:total current:current];
                }
            }  completed:^(NSURL * _Nullable location, NSError * _Nullable error){
                if(!error){
                    if ([weakSelf.delegate respondsToSelector:@selector(ttLaunchAd:videoDownLoadFinish:)]){
                        [weakSelf.delegate ttLaunchAd:self videoDownLoadFinish:location];
                    }
                }
            }];
            /***视频缓存,提前显示完成 */
            [self removeAndAnimateDefault]; return;
        }
    }else{
        if(configuration.videoNameOrURLString.length){
            NSURL *pathURL = nil;
            NSURL *cachePathURL = [[NSURL alloc] initFileURLWithPath:[T_TLaunchAdCache videoPathWithFileName:configuration.videoNameOrURLString]];
            //若本地视频未在沙盒缓存文件夹中
            if (![T_TLaunchAdCache checkVideoInCacheWithFileName:configuration.videoNameOrURLString]) {
                /***如果不在沙盒文件夹中则将其复制一份到沙盒缓存文件夹中/下次直接取缓存文件夹文件,加快文件查找速度 */
                NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:configuration.videoNameOrURLString withExtension:nil];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[NSFileManager defaultManager] copyItemAtURL:bundleURL toURL:cachePathURL error:nil];
                });
                pathURL = bundleURL;
            }else{
                pathURL = cachePathURL;
            }
            
            if(pathURL){
                if ([self.delegate respondsToSelector:@selector(ttLaunchAd:videoDownLoadFinish:)]) {
                    [self.delegate ttLaunchAd:self videoDownLoadFinish:pathURL];
                }
                _adVideoView.contentURL = pathURL;
                _adVideoView.muted = configuration.muted;
                [_adVideoView.videoPlayer.player play];
                
            }else{
                T_TLaunchAdLog(@"Error:广告视频未找到,请检查名称是否有误!");
            }
        }else{
            T_TLaunchAdLog(@"未设置广告视频");
        }
    }
    /** skipButton */
    [self addSkipButtonForConfiguration:configuration];
    [self startSkipDispathTimer];
    /** customView */
    if(configuration.subViews.count>0) [self addSubViews:configuration.subViews];
    T_TWeakSelf
    _adVideoView.click = ^(CGPoint point) {
        [weakSelf clickAndPoint:point];
    };
}

#pragma mark - add subViews
-(void)addSubViews:(NSArray *)subViews{
    [subViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [_window addSubview:view];
    }];
}

#pragma mark - set
-(void)setImageAdConfiguration:(T_TLaunchImageAdConfiguration *)imageAdConfiguration{
    _imageAdConfiguration = imageAdConfiguration;
    _launchAdType = T_TLaunchAdTypeImage;
    [self setupImageAdForConfiguration:imageAdConfiguration];
}

-(void)setVideoAdConfiguration:(T_TLaunchVideoAdConfiguration *)videoAdConfiguration{
    _videoAdConfiguration = videoAdConfiguration;
    _launchAdType = T_TLaunchAdTypeVideo;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupVideoAdForConfiguration:videoAdConfiguration];
    });
}

-(void)setWaitDataDuration:(NSInteger)waitDataDuration{
    _waitDataDuration = waitDataDuration;
    /** 数据等待 */
    [self startWaitDataDispathTiemr];
}


#pragma mark - Action
-(void)skipButtonClick{
    [self removeAndAnimated:YES];
}

-(void)removeAndAnimated:(BOOL)animated{
    if(animated){
        [self removeAndAnimate];
    }else{
        [self remove];
    }
}

-(void)clickAndPoint:(CGPoint)point{
    self.clickPoint = point;
    T_TLaunchAdConfiguration * configuration = [self commonConfiguration];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if ([self.delegate respondsToSelector:@selector(ttLaunchAd:clickAndOpenURLString:)]) {
        [self.delegate ttLaunchAd:self clickAndOpenURLString:configuration.openURLString];
        [self removeAndAnimateDefault];
    }
    if ([self.delegate respondsToSelector:@selector(ttLaunchAd:clickAndOpenURLString:clickPoint:)]) {
        [self.delegate ttLaunchAd:self clickAndOpenURLString:configuration.openURLString clickPoint:point];
        [self removeAndAnimateDefault];
    }
#pragma clang diagnostic pop
    if ([self.delegate respondsToSelector:@selector(ttLaunchAd:clickAndOpenModel:clickPoint:)]) {
        if ([(NSString *)configuration.openModel length]>0) {
            [self.delegate ttLaunchAd:self clickAndOpenModel:configuration.openModel clickPoint:point];
            [self removeAndAnimateDefault];
        }
    }
}

-(T_TLaunchAdConfiguration *)commonConfiguration{
    T_TLaunchAdConfiguration *configuration = nil;
    switch (_launchAdType) {
        case T_TLaunchAdTypeVideo:
            configuration = _videoAdConfiguration;
            break;
        case T_TLaunchAdTypeImage:
            configuration = _imageAdConfiguration;
            break;
        default:
            break;
    }
    return configuration;
}

-(void)startWaitDataDispathTiemr{
    __block NSInteger duration = defaultWaitDataDuration;
    if(_waitDataDuration) duration = _waitDataDuration;
    _waitDataTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    NSTimeInterval period = 1.0;
    dispatch_source_set_timer(_waitDataTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_waitDataTimer, ^{
        if(duration==0){
            DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:T_TLaunchAdWaitDataDurationArriveNotification object:nil];
                [self remove];
                return ;
            });
        }
        duration--;
    });
    dispatch_resume(_waitDataTimer);
}

-(void)startSkipDispathTimer{
    T_TLaunchAdConfiguration * configuration = [self commonConfiguration];
    DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer);
    if(!configuration.skipButtonType) configuration.skipButtonType = SkipTypeTimeText;//默认
    __block NSInteger duration = 5;//默认
    if(configuration.duration) duration = configuration.duration;
    if(configuration.skipButtonType == SkipTypeRoundProgressTime || configuration.skipButtonType == SkipTypeRoundProgressText){
        [_skipButton startRoundDispathTimerWithDuration:duration];
    }
    NSTimeInterval period = 1.0;
    _skipTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_skipTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_skipTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(ttLaunchAd:customSkipView:duration:)]) {
                [self.delegate ttLaunchAd:self customSkipView:configuration.customSkipView duration:duration];
            }
            if(!configuration.customSkipView){
                [_skipButton setTitleWithSkipType:configuration.skipButtonType duration:duration];
            }
            if(duration==0){
                DISPATCH_SOURCE_CANCEL_SAFE(_skipTimer);
                [self removeAndAnimate]; return ;
            }
            duration--;
        });
    });
    dispatch_resume(_skipTimer);
}

-(void)removeAndAnimate{
    
    T_TLaunchAdConfiguration * configuration = [self commonConfiguration];
    CGFloat duration = showFinishAnimateTimeDefault;
    if(configuration.showFinishAnimateTime>0) duration = configuration.showFinishAnimateTime;
    switch (configuration.showFinishAnimate) {
        case ShowFinishAnimateNone:{
            [self remove];
        }
            break;
        case ShowFinishAnimateFadein:{
            [self removeAndAnimateDefault];
        }
            break;
        case ShowFinishAnimateLite:{
            [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
                _window.transform = CGAffineTransformMakeScale(1.5, 1.5);
                _window.alpha = 0;
            } completion:^(BOOL finished) {
                [self remove];
            }];
        }
            break;
        case ShowFinishAnimateFlipFromLeft:{
            [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                _window.alpha = 0;
            } completion:^(BOOL finished) {
                [self remove];
            }];
        }
            break;
        case ShowFinishAnimateFlipFromBottom:{
            [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                _window.alpha = 0;
            } completion:^(BOOL finished) {
                [self remove];
            }];
        }
            break;
        case ShowFinishAnimateCurlUp:{
            [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionTransitionCurlUp animations:^{
                _window.alpha = 0;
            } completion:^(BOOL finished) {
                [self remove];
            }];
        }
            break;
        default:{
            [self removeAndAnimateDefault];
        }
            break;
    }
}

-(void)removeAndAnimateDefault{
    T_TLaunchAdConfiguration * configuration = [self commonConfiguration];
    CGFloat duration = showFinishAnimateTimeDefault;
    if(configuration.showFinishAnimateTime>0) duration = configuration.showFinishAnimateTime;
    [UIView animateWithDuration:duration delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _window.transform = CGAffineTransformMakeScale(1.2, 1.2);
        _window.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self remove];
    }];
    
}
-(void)removeOnly{
    DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer)
    DISPATCH_SOURCE_CANCEL_SAFE(_skipTimer)
    REMOVE_FROM_SUPERVIEW_SAFE(_skipButton)
    if(_launchAdType==T_TLaunchAdTypeVideo){
        if(_adVideoView){
            [_adVideoView stopVideoPlayer];
            REMOVE_FROM_SUPERVIEW_SAFE(_adVideoView)
        }
    }
    if(_window){
        [_window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            REMOVE_FROM_SUPERVIEW_SAFE(obj)
        }];
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _window.transform = CGAffineTransformMakeScale(1.2, 1.2);
            _window.alpha = 0.0;
        } completion:^(BOOL finished) {
            _window.hidden = YES;
            _window = nil;
        }];
        
    }
}

-(void)remove{
    [self removeOnly];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"T_TLaunchAdDetailPageRemoveNotification" object:nil];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if ([self.delegate respondsToSelector:@selector(ttLaunchShowFinish:)]) {
        [self.delegate ttLaunchShowFinish:self];
    }
#pragma clang diagnostic pop
    if ([self.delegate respondsToSelector:@selector(ttLaunchAdShowFinish:)]) {
        [self.delegate ttLaunchAdShowFinish:self];
    }
}

-(void)removeSubViewsExceptLaunchAdImageView{
    [_window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(![obj isKindOfClass:[T_TLaunchImageView class]]){
            REMOVE_FROM_SUPERVIEW_SAFE(obj)
        }
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
