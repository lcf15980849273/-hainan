//
//  T_TLaunchAdButton.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  倒计时类型
 */
typedef NS_ENUM(NSInteger,SkipType) {
    SkipTypeNone      = 1,//无
    /** 方形 */
    SkipTypeTime      = 2,//方形:倒计时
    SkipTypeText      = 3,//方形:跳过
    SkipTypeTimeText  = 4,//方形:倒计时+跳过 (default)
    /** 圆形 */
    SkipTypeRoundTime = 5,//圆形:倒计时
    SkipTypeRoundText = 6,//圆形:跳过
    SkipTypeRoundProgressTime = 7,//圆形:进度圈+倒计时
    SkipTypeRoundProgressText = 8,//圆形:进度圈+跳过
};

@interface T_TLaunchAdButton : UIButton

- (instancetype)initWithSkipType:(SkipType)skipType;
- (void)startRoundDispathTimerWithDuration:(CGFloat )duration;
- (void)setTitleWithSkipType:(SkipType)skipType duration:(NSInteger)duration;
@end
