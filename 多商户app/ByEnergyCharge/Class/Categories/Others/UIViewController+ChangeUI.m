//
//  UIViewController+ChangeUI.m
//  StarCharge
//
//  Created by newyea on 2019/9/26.
//  Copyright © 2019年 newyea. All rights reserved.
//

#import "UIViewController+ChangeUI.h"

@implementation UIViewController (ChangeUI)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(presentViewController:animated:completion:);//原始方法
        SEL swizzledSelector = @selector(sc_presentViewController:animated:completion:);// 要替换的方法
        Method originalMethod = class_getInstanceMethod([UIViewController class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([UIViewController class], swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)sc_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if(@available(iOS 13.0, *)) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self sc_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
