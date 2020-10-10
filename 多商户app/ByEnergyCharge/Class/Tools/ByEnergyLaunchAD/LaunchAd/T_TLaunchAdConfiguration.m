//
//  T_TLaunchAdConfiguration.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import "T_TLaunchAdConfiguration.h"

#pragma mark - 公共
@implementation T_TLaunchAdConfiguration

@end

#pragma mark - 图片广告相关
@implementation T_TLaunchImageAdConfiguration

+(T_TLaunchImageAdConfiguration *)defaultConfiguration{
    //配置广告数据
    T_TLaunchImageAdConfiguration *configuration = [T_TLaunchImageAdConfiguration new];
    //广告停留时间
    configuration.duration = 5;
    //广告frame
    configuration.frame = [UIScreen mainScreen].bounds;
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    configuration.GIFImageCycleOnce = NO;
    //缓存机制
    configuration.imageOption = T_TLaunchAdImageDefault;
    //图片填充模式
    configuration.contentMode = UIViewContentModeScaleToFill;
    //广告显示完成动画
    configuration.showFinishAnimate =ShowFinishAnimateFadein;
    //显示完成动画时间
    configuration.showFinishAnimateTime = showFinishAnimateTimeDefault;
    //跳过按钮类型
    configuration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    configuration.showEnterForeground = NO;
    return configuration;
}

@end

#pragma mark - 视频广告相关
@implementation T_TLaunchVideoAdConfiguration
+(T_TLaunchVideoAdConfiguration *)defaultConfiguration{
    //配置广告数据
    T_TLaunchVideoAdConfiguration *configuration = [T_TLaunchVideoAdConfiguration new];
    //广告停留时间
    configuration.duration = 5;
    //广告frame
    configuration.frame = [UIScreen mainScreen].bounds;
    //视频填充模式
    configuration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //是否只循环播放一次
    configuration.videoCycleOnce = NO;
    //广告显示完成动画
    configuration.showFinishAnimate =ShowFinishAnimateFadein;
    //显示完成动画时间
    configuration.showFinishAnimateTime = showFinishAnimateTimeDefault;
    //跳过按钮类型
    configuration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    configuration.showEnterForeground = NO;
    //是否静音播放
    configuration.muted = NO;
    return configuration;
}
@end
