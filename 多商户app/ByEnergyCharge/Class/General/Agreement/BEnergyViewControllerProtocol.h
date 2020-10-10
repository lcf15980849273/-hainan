//
//  BEnergyViewControllerProtocol.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BEnergyViewControllerProtocol <NSObject>

@optional
- (void) byEnergyInitDatas;
- (void) byEnergyInitViews;
- (void) byEnergySetViewLayout;
- (void) byEnergyInitViewModel;
- (void)loadRefreshData;

@end
