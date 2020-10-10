//
//  BEnergyLocationView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/28.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyLocationView.h"

@interface BEnergyLocationView ()

@end

@implementation BEnergyLocationView

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self startAnimate];
}

- (void)startAnimate {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:1.4f];
    animation.autoreverses = YES;
    animation.duration = 1.f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:nil];
}

@end
