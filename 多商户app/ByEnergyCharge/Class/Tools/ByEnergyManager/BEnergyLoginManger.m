//
//  BEnergyLoginManger.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/24.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyLoginManger.h"
#import "BEnergyLoginViewController.h"
#import "AppDelegate.h"
@implementation BEnergyLoginManger

+ (void)ByEnergyPresentLoginViewController {
    
    if ([[USER_DEFAULT objectForKey:@"token"] length] > 0) {
        return;
    }
    
    BEnergyLoginViewController *loginVC = nil;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([[ByEnergyLoadViews getCurrentViewController] isKindOfClass:[BEnergyLoginViewController class]]) {
        loginVC = (BEnergyLoginViewController *)[ByEnergyLoadViews getCurrentViewController];
    }
    if (loginVC == nil) {
        BEnergyLoginViewController *controller = [[BEnergyLoginViewController alloc]init];
        controller.isShowLiftBack = NO;
        ByEnergyBaseNavi *loginNav = [[ByEnergyBaseNavi alloc] initWithRootViewController:controller];
        loginNav.navigationBarBackgroundM = [UIColor whiteColor];
        loginNav.navigationBar.backgroundColor = [UIColor whiteColor];
        [ByEnergyTopVC presentViewController:loginNav animated:YES completion:^{}];
    }else {
        [[appDelegate rootNav] popToRootViewControllerAnimated:NO];
    }
}
@end
