//
//  NSString+ByEnergyAnimation.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/27.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "NSString+ByEnergyAnimation.h"

@implementation UIView (ByEnergyAnimation)

- (void)byEnergyViewWithAnimation:(UIView *)view {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation]; //帧动画
    anim.keyPath = @"transform.scale";
    anim.values = @[@(1.5),@(1)];
    anim.repeatCount = 1;
    anim.duration = 0.25;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:anim forKey:nil];
}

- (void)byEnergyViewWithAnimationtoNarrow:(UIView *)view sate:(BOOL)state {  //为yes 放大，no缩小
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation]; //帧动画
    anim.keyPath = @"transform.scale";
    anim.values =  state ? @[@(1.5)] : @[@(1)];
    anim.repeatCount = 1;
    anim.duration = 0.25;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:anim forKey:nil];
}
@end
