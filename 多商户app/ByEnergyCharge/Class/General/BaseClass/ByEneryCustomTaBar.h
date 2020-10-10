//
//  ByEneryCustomTaBar.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/12/30.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ByEneryCustomTaBar;
NS_ASSUME_NONNULL_BEGIN
@protocol CustomTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(ByEneryCustomTaBar *)tabBar;
@end
@interface ByEneryCustomTaBar : UITabBar

@property (nonatomic, weak) id<CustomTabBarDelegate> myDelegate;
@end

NS_ASSUME_NONNULL_END
