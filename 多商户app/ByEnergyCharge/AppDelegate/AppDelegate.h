//
//  AppDelegate.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/22.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByEnergyBaseNavi.h"
#import "ByEnergyBaseTB.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ByEnergyBaseNavi *rootNav;
@property (nonatomic, strong) ByEnergyBaseTB *tabbarController;

@end

