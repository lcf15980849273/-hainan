//
//  UITableViewCell+SC.m
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "UITableViewCell+SC.h"
#import <objc/runtime.h>

@implementation UITableViewCell (SC)

+ (void)load{
    static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
           SEL originalSelector = @selector(layoutSubviews);//原始方法
            SEL swizzledSelector = @selector(sc_layoutSubViews);// 要替换的方法
           Method originalMethod = class_getInstanceMethod([UITableViewCell class], originalSelector);
           Method swizzledMethod = class_getInstanceMethod([UITableViewCell class], swizzledSelector);
           method_exchangeImplementations(originalMethod, swizzledMethod);
        });
}

- (void)sc_layoutSubViews {
    [self sc_layoutSubViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end

