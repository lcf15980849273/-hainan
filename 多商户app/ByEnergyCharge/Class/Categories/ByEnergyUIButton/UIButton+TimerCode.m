//
//  UIButton+TimerCode.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/14.
//  Copyright © 2018年 newyea. All rights reserved.
//

//注意：如果按钮出现闪烁，将xib或者storyboard中Type属性设置为custom即可

#import "UIButton+TimerCode.h"

static NSString *timerText;
static dispatch_source_t timers;
static int _type;

@implementation UIButton (TimerCode)

- (void)startCountDownTime:(int)time withCountDownBlock:(void(^)(BOOL isFinsh))countDownBlock{
    
    [self initButtonData];
    if (countDownBlock) {
        countDownBlock(NO);
    }
    [self startTime:time withCountDownBlock:countDownBlock];
}

- (void)initButtonData{
    timerText = [NSString stringWithFormat:@"%@",self.titleLabel.text];
}

- (void)startTime:(int)time withCountDownBlock:(void(^)(BOOL isFinsh))countDownBlock{

    __block int timeout = time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    timers = _timer;
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束
        if(timeout <= 0){
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:timerText forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                self.selected = NO;
                if (countDownBlock) {
                    countDownBlock(YES);
                }
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *text = [NSString stringWithFormat:@"%02d秒重新获取",timeout];
                switch (_type) {
                    case 0:
                        text = [NSString stringWithFormat:@"%02d秒重新获取",timeout];
                        break;
                    case 1:
                        text = [NSString stringWithFormat:@"获取中%02d",timeout];
                        break;
                    default:
                        break;
                }
                [self setTitle:text forState:UIControlStateNormal];
                self.backgroundColor = UIColor.whiteColor;
                self.selected = NO;
                self.userInteractionEnabled = NO;
            });
            
            timeout --;
        }
    });
    
    dispatch_resume(_timer);
}

- (void)setCustomText:(int)type {
    _type = type;
}

- (void)invalidTimer{
   
    if (timers) {
        [self setTitle:timerText forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        self.selected = NO;
        dispatch_source_cancel(timers);
    }
}

@end
