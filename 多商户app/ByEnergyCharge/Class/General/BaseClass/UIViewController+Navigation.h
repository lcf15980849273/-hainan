//
//  UIViewController+Navigation.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/23.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Navigation)

/**
 当前导航栏的标题颜色
 Setting the navigation bar titleColor by UIColor.
 */
@property(nonatomic, strong) UIColor          *titleColorM;

/**
 更改当前导航栏的背景颜色
 Setting the navigation bar backgroundColor color by UIColor.
 */
@property(nonatomic, strong) UIColor          *navigationBarBackgroundM;//背景颜色

/**
 当前导航栏是否隐藏
 Whether or not the navigation bar is currently hidden.
 */
@property(nonatomic, assign) BOOL             navigationBarHiddenM;

/**
 更改当前导航栏的item颜色
 record current ViewController navigationBar barTintColor.
 */
@property(nonatomic, strong) UIColor          *navigationBarTintColorM;//item颜色

@end

NS_ASSUME_NONNULL_END
