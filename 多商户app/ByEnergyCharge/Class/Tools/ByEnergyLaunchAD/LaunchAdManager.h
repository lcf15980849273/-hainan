//
//  LaunchAdManager.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kGuideShowTypeOnce = 0,   //每一次更新时显示
    kGuideShowTypeAlways,     //每次启动时都展示
    kGuideShowTypeOnlyOnce,   //仅第一次安装并启动时展示
    kGuideShowTypeNone        //一直不展示
} kGuideShowType;

@interface LaunchAdManager : NSObject
+ (void)setGuideShowType:(kGuideShowType)showType;
+ (BOOL)canShowGuide;
@end
