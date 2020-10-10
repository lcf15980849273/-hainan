//
//  UIButton+TimerCode.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/14.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TimerCode)
//- (void)startCountDownTime:(int)time withCountDownBlock:(void(^)(void))countDownBlock;

/**
 倒计时

 @param time 倒计时时间
 @param countDownBlock isFinsh：1、NO 开始 2、YES 结束
 */
- (void)startCountDownTime:(int)time withCountDownBlock:(void(^)(BOOL isFinsh))countDownBlock;

/**
 释放定时器
 */
- (void)invalidTimer;


/**
 倒计时显示文字类型（默认0） 0、登录 1、设置支付密码

 @param  type type
 */
- (void)setCustomText:(int)type;
@end
