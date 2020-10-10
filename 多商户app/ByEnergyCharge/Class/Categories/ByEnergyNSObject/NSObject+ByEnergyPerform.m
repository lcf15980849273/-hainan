//
//  NSObject+ByEnergyPerform.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "NSObject+ByEnergyPerform.h"

@implementation NSObject (ByEnergyPerform)

#pragma mark Public Method
- (void)hnByEnergyAfter:(NSTimeInterval)second action:(void (^)(void))action {
    [[self class] hnByEnergyAfter:second
                                 action:action];
}

+ (void)hnByEnergyAfter:(NSTimeInterval)second action:(void (^)(void))action {
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * second);
    dispatch_after(delay, dispatch_get_main_queue(), [action copy]);
}
@end
