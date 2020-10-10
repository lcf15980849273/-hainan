//
//  UIViewController+Navigation.m
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/23.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import <objc/runtime.h>
#import "WRNavigationBar.h"
#import "WRCustomNavigationBar.h"
#import "UIImage+Color.h"

@implementation UIViewController (Navigation)

#pragma mark - 当前导航栏的标题颜色
- (UIColor *)titleColorM {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if (color) {
        return color;
    }
    self.titleColorM = [UIColor blackColor];
    return [UIColor blackColor];
}

- (void)setTitleColorM:(UIColor *)titleColorM {
    SEL key = @selector(titleColorM);
    [self wr_setNavBarTitleColor:titleColorM];
    objc_setAssociatedObject(self, key, titleColorM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//隐藏导航栏
-(void)setNavigationBarHiddenM:(BOOL)navigationBarHiddenM{
    self.edgesForExtendedLayout = UIRectEdgeTop;
    [self wr_setNavBarBackgroundAlpha:navigationBarHiddenM?0:1];
    objc_setAssociatedObject(self, @selector(navigationBarHiddenM), [NSNumber numberWithBool:navigationBarHiddenM], OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)navigationBarHiddenM{
    id object = objc_getAssociatedObject(self, @selector(navigationBarHiddenM));
    return object?[object boolValue]:NO;
}


- (void)setNavigationBarBackgroundM:(UIColor *)navigationBarBackgroundM {
    SEL key = @selector(navigationBarBackgroundM);
    [self wr_setNavBarBarTintColor:navigationBarBackgroundM];
    objc_setAssociatedObject(self, key, navigationBarBackgroundM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)navigationBarBackgroundM {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if (color) {
        return color;
    }
    self.navigationBarBackgroundM = [UIColor whiteColor];
    return [UIColor whiteColor];
}

- (void)setNavigationBarTintColorM:(UIColor *)navigationBarTintColorM {
    SEL key = @selector(navigationBarTintColorM);
    if ([self.navigationItem.rightBarButtonItem.customView isKindOfClass:[UIButton class]]) {
        UIButton *button = self.navigationItem.rightBarButtonItem.customView;
        [button setTitleColor:navigationBarTintColorM forState:UIControlStateNormal];
    }else {
        [self wr_setNavBarTintColor:navigationBarTintColorM];
    }
    objc_setAssociatedObject(self, key, navigationBarTintColorM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)navigationBarTintColorM {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if (color) {
        return color;
    }
    return [UIColor blackColor];
}

@end
