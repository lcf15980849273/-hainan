
//
//  ByEnergyBaseScrollView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/18.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseScrollView.h"

@implementation ByEnergyBaseScrollView

//滑动穿透
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
