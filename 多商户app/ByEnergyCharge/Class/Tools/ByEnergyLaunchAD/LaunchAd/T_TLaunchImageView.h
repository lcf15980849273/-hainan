//
//  T_TLaunchImageView.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 启动图来源 */
typedef NS_ENUM(NSInteger,SourceType) {
    /** LaunchImage(default) */
    SourceTypeLaunchImage = 1,
    /** LaunchScreen.storyboard */
    SourceTypeLaunchScreen = 2,
};

typedef NS_ENUM(NSInteger,LaunchImagesSource){
    LaunchImagesSourceLaunchImage = 1,
    LaunchImagesSourceLaunchScreen = 2,
};

@interface T_TLaunchImageView : UIImageView

- (instancetype)initWithSourceType:(SourceType)sourceType;

@end
