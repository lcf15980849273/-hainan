//
//  T_TLaunchAdConst.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import <UIKit/UIKit.h>

#define T_TLaunchAdDeprecated(instead) __attribute__((deprecated(instead)))

#define T_TWeakSelf __weak typeof(self) weakSelf = self;

#define T_T_ScreenW    [UIScreen mainScreen].bounds.size.width
#define T_T_ScreenH    [UIScreen mainScreen].bounds.size.height

#define T_T_IPHONEX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define T_TISURLString(string)  ([string hasPrefix:@"https://"] || [string hasPrefix:@"http://"]) ? YES:NO
#define T_TStringContainsSubString(string,subString)  ([string rangeOfString:subString].location == NSNotFound) ? NO:YES

#ifdef DEBUG
#define T_TLaunchAdLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define T_TLaunchAdLog(...)
#endif

#define T_TISGIFTypeWithData(data)\
({\
BOOL result = NO;\
if(!data) result = NO;\
uint8_t c;\
[data getBytes:&c length:1];\
if(c == 0x47) result = YES;\
(result);\
})

#define T_TISVideoTypeWithPath(path)\
({\
BOOL result = NO;\
if([path hasSuffix:@".mp4"])  result =  YES;\
(result);\
})

#define T_TDataWithFileName(name)\
({\
NSData *data = nil;\
NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];\
if([[NSFileManager defaultManager] fileExistsAtPath:path]){\
data = [NSData dataWithContentsOfFile:path];\
}\
(data);\
})

#define DISPATCH_SOURCE_CANCEL_SAFE(time) if(time)\
{\
dispatch_source_cancel(time);\
time = nil;\
}

#define REMOVE_FROM_SUPERVIEW_SAFE(view) if(view)\
{\
[view removeFromSuperview];\
view = nil;\
}

UIKIT_EXTERN NSString *const T_TCacheImageUrlStringKey;
UIKIT_EXTERN NSString *const T_TCacheVideoUrlStringKey;

UIKIT_EXTERN NSString *const T_TLaunchAdWaitDataDurationArriveNotification;
UIKIT_EXTERN NSString *const T_TLaunchAdDetailPageWillShowNotification;
UIKIT_EXTERN NSString *const T_TLaunchAdDetailPageShowFinishNotification;
/** GIFImageCycleOnce = YES(GIF不循环)时, GIF动图播放完成通知 */
UIKIT_EXTERN NSString *const T_TLaunchAdGIFImageCycleOnceFinishNotification;
/** videoCycleOnce = YES(视频不循环时) ,video播放完成通知 */
UIKIT_EXTERN NSString *const T_TLaunchAdVideoCycleOnceFinishNotification;
/** 视频播放失败通知 */
UIKIT_EXTERN NSString *const T_TLaunchAdVideoPlayFailedNotification;
UIKIT_EXTERN BOOL T_TLaunchAdPrefersHomeIndicatorAutoHidden;
