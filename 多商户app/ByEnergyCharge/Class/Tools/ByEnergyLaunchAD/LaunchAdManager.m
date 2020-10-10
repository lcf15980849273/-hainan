//
//  LaunchAdManager.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import "LaunchAdManager.h"
#import "T_TLaunchAd.h"
#import "LaunchAdModel.h"
#import "ApplicationUtil.h"
#import "BEnergyAdsPageViewModel.h"
#import "GuideFigure.h"
#import "ByEnergyBaseWebVc.h"

/** 以下连接供测试使用 */

/** 静态图 */
#define imageURL1 @""
#define imageURL2 @""
#define imageURL3 @""
#define imageURL4 @""

/** 动态图 */
#define imageURL5 @""
#define imageURL6 @""

/** 视频链接 */
#define videoURL1 @""
#define videoURL2 @""
#define videoURL3 @""


static kGuideShowType guideShowType = kGuideShowTypeOnce;

@interface LaunchAdManager()<T_TLaunchAdDelegate>

@property (nonatomic ,strong) BEnergyAdsPageViewModel *viewModel;
@property (nonatomic, assign) CGSize focusViewSize;

@end

@implementation LaunchAdManager

+(void)load{
    [self shareManager];
}

+(LaunchAdManager *)shareManager{
    static LaunchAdManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[LaunchAdManager alloc] init];
    });
    return instance;
}

+ (void)setGuideShowType:(kGuideShowType)showType {
    guideShowType = showType;
}

+ (BOOL)canShowGuide {
    
    if (guideShowType==kGuideShowTypeNone) {
        return NO;
    }
    else if (guideShowType==kGuideShowTypeAlways) {
        return YES;
    }
    else if (guideShowType==kGuideShowTypeOnce) {
        //当前app的版本号
        NSString *versionStrForNow = [ApplicationUtil nowAppVersion];
        
        //上一次本地存储的版本号
        NSString *versionStrForLast = [ApplicationUtil lastAppVersionForKey:GuideAppVersionKey];
        
        if(versionStrForLast!=nil && [versionStrForNow isEqualToString:versionStrForLast]){//说明有本地版本记录，且和当前系统版本一致
            return NO;
        }
        else {//无本地版本记录或本地版本记录与当前系统版本不一致
            return YES;
        }
    }else if (guideShowType==kGuideShowTypeOnlyOnce) {
        NSString *versionStrForLast = [ApplicationUtil lastAppVersionForKey:GuideAppVersionKey];
        if(versionStrForLast!=nil){
            //说明有本地版本记录
            return NO;
        }
        else {
            //无本地版本记录
            return YES;
        }
    }
    return NO;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
            BOOL canShowGuide = [LaunchAdManager canShowGuide];
            if (!canShowGuide) {
                [self setupT_TLaunchAd];
            }else {
                [GuideFigure figureWithImages:@[@"LaunchImages.jpg"] finashMainViewController:ByEnergyAppWindow.rootViewController];
            }
            
        }];
    }
    return self;
}

-(void)setupT_TLaunchAd{
    
    /** 1.图片开屏广告 - 网络数据 */
//    [self example01];  //注释的话即不显示开屏广告
    
    //2.******图片开屏广告 - 本地数据******
//        [self example02];
    
}

- (BEnergyAdsPageViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[BEnergyAdsPageViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)example01{
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [T_TLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [T_TLaunchAd setWaitDataDuration:3];
    
    //广告数据请求
    ByEnergyWeakSekf
    [[[self.viewModel.hnAdsPageCommand.executionSignals takeUntil:self.rac_willDeallocSignal] switchToLatest] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            //广告数据转模型
            LaunchAdModel *model = [[LaunchAdModel alloc] init];
            model.imgUrl = [self.viewModel.value imgUrl];
            model.id = [self.viewModel.value id];
            model.refId = byEnergyClearNilStr([self.viewModel.value refId]);
            model.refType = [self.viewModel.value refType];
            //配置广告数据
            T_TLaunchImageAdConfiguration *imageAdconfiguration = [T_TLaunchImageAdConfiguration new];
            //广告停留时间
            imageAdconfiguration.duration = 3;
            //广告frame
            imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
            imageAdconfiguration.imageNameOrURLString = model.imgUrl;
            //设置GIF动图是否只循环播放一次(仅对动图设置有效)
            imageAdconfiguration.GIFImageCycleOnce = NO;
            //缓存机制(仅对网络图片有效)
            //为告展示效果更好,可设置为T_TLaunchAdImageCacheInBackground,先缓存,下次显示
            imageAdconfiguration.imageOption = T_TLaunchAdImageDefault;
            //图片填充模式
            imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
            //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
            imageAdconfiguration.openModel =  model.refType == 1?model.refId:model.id;
            //广告显示完成动画
            imageAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
            //广告显示完成动画时间
            imageAdconfiguration.showFinishAnimateTime = 0.8;
            //跳过按钮类型
            imageAdconfiguration.skipButtonType = SkipTypeRoundText;
            //后台返回时,是否显示广告
            imageAdconfiguration.showEnterForeground = NO;
            
            //图片已缓存 - 显示一个 "已预载" 视图 (可选)
            if([T_TLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.imgUrl]]){
                //设置要添加的自定义视图(可选)
                imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
            }
            //显示开屏广告
            [T_TLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        }else {
            [self example02];
        }
    }];

    [[self.viewModel.hnAdsPageCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [self example02];
    }];
    
    [self.viewModel.hnAdsPageCommand execute:nil];
    
}

#pragma mark - 图片开屏广告-本地数据-示例
//图片开屏广告 - 本地数据
-(void)example02{
    //配置广告数据
    T_TLaunchImageAdConfiguration *imageAdconfiguration = [T_TLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 3;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"LaunchImages.jpg";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeRoundText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [T_TLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}
#pragma mark - 批量下载并缓存
/**
 *  批量下载并缓存图片
 */
-(void)batchDownloadImageAndCache{
    
    [T_TLaunchAd downLoadImageAndCacheWithURLArray:@[[NSURL URLWithString:imageURL1],[NSURL URLWithString:imageURL2],[NSURL URLWithString:imageURL3],[NSURL URLWithString:imageURL4],[NSURL URLWithString:imageURL5]] completed:^(NSArray * _Nonnull completedArray) {
        
        /** 打印批量下载缓存结果 */
        
        //url:图片的url字符串,
        //result:0表示该图片下载失败,1表示该图片下载并缓存完成或本地缓存中已有该图片
        NSLog(@"批量下载缓存图片结果 = %@" ,completedArray);
    }];
}

/**
 *  批量下载并缓存视频
 */
-(void)batchDownloadVideoAndCache{
    
    [T_TLaunchAd downLoadVideoAndCacheWithURLArray:@[[NSURL URLWithString:videoURL1],[NSURL URLWithString:videoURL2],[NSURL URLWithString:videoURL3]] completed:^(NSArray * _Nonnull completedArray) {
        
        /** 打印批量下载缓存结果 */
        
        //url:视频的url字符串,
        //result:0表示该视频下载失败,1表示该视频下载并缓存完成或本地缓存中已有该视频
        NSLog(@"批量下载缓存视频结果 = %@" ,completedArray);
        
    }];
    
}

#pragma mark - subViews
-(NSArray<UIView *> *)launchAdSubViews_alreadyView{
    
    CGFloat y = IsIphoneXLater ? 46:22;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, y, 60, 30)];
    label.centerX = SCREENWIDTH/2;
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

-(NSArray<UIView *> *)launchAdSubViews{
    
    CGFloat y = T_T_IPHONEX ? 54 : 30;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-170, y, 60, 30)];
    label.text  = @"subViews";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}

#pragma mark - customSkipView
//自定义跳过按钮
-(UIView *)customSkipView{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor orangeColor];
    button.layer.cornerRadius = 5.0;
    button.layer.borderWidth = 1.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    CGFloat y = T_T_IPHONEX ? 54 : 30;
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100,y, 85, 30);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //移除广告
        [T_TLaunchAd removeAndAnimated:YES];
    }];
    return button;
}

#pragma mark - T_TLaunchAd delegate - 倒计时回调
/**
 *  倒计时回调
 *
 *  @param launchAd T_TLaunchAd
 *  @param duration 倒计时时间
 */
-(void)ttLaunchAd:(T_TLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration{
    //设置自定义跳过按钮时间
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    //设置时间
    [button setTitle:[NSString stringWithFormat:@"自定义%lds",duration] forState:UIControlStateNormal];
}

#pragma mark - T_TLaunchAd delegate - 其他
/**
 广告点击事件回调
 */
-(void)ttLaunchAd:(T_TLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    NSLog(@"广告点击事件");
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(self.viewModel.value == nil) return;
    LaunchAdModel *model = [[LaunchAdModel alloc] init];
    model.imgUrl = [self.viewModel.value imgUrl];
    model.id = [self.viewModel.value id];
    model.refId = byEnergyClearNilStr([self.viewModel.value refId]);
    model.refType = [self.viewModel.value refType];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:model forKey:@"models"];
    [[NSNotificationCenter defaultCenter] postNotificationName:ADDetailPushCenter object:dic];
    //移除广告
    [T_TLaunchAd removeAndAnimated:YES];
}

/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd  T_TLaunchAd
 *  @param image 读取/下载的image
 *  @param imageData 读取/下载的imageData
 */
-(void)ttLaunchAd:(T_TLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image imageData:(NSData *)imageData{
    
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}

/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd T_TLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
-(void)ttLaunchAd:(T_TLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL{
    
    NSLog(@"video下载/加载完成 path = %@",pathURL.absoluteString);
}

/**
 *  视频下载进度回调
 */
-(void)ttLaunchAd:(T_TLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current{
    
    NSLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
}

/**
 *  广告显示完成
 */
-(void)ttLaunchAdShowFinish:(T_TLaunchAd *)launchAd{
    
    /**
     如果你设置了APP从后台恢复时也显示广告,
     当用户停留在广告详情页时,APP从后台恢复时,你不想再次显示启动广告,
     请在广告详情控制器销毁时,发下面通知,告诉XHLaunchAd,广告详情页面已显示完
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:T_TLaunchAdDetailPageShowFinishNotification object:nil];
}

/**
 如果你想用SDWebImage等框架加载网络广告图片,请实现此代理(注意:实现此方法后,图片缓存将不受T_TLaunchAd管理)
 
 @param launchAd          T_TLaunchAd
 @param launchAdImageView launchAdImageView
 @param url               图片url
 */
//-(void)ttLaunchAd:(T_TLaunchAd *)launchAd launchAdImageView:(UIImageView *)launchAdImageView URL:(NSURL *)url
//{
//    [launchAdImageView sd_setImageWithURL:url];
//
//}
@end
