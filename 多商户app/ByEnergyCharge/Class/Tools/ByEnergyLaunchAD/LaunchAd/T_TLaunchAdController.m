//
//  T_TLaunchAdController.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import "T_TLaunchAdController.h"
#import "T_TLaunchAdConst.h"
@interface T_TLaunchAdController ()

@end

@implementation T_TLaunchAdController

-(BOOL)shouldAutorotate{
    
    return NO;
}

-(BOOL)prefersHomeIndicatorAutoHidden{
    
    return T_TLaunchAdPrefersHomeIndicatorAutoHidden;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
