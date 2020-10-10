//
//  LYEmptyView+Runtime.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "LYEmptyView+Runtime.h"
#import <objc/runtime.h>
@implementation LYEmptyView (Runtime)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel = @selector(prepare);
        SEL swizzSel = @selector(sw_prepare);
        Method method = class_getInstanceMethod([self class], sel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        BOOL isAdd = class_addMethod(self, sel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            class_replaceMethod(self, swizzSel, method_getImplementation(method), method_getTypeEncoding(method));
        }else{
            method_exchangeImplementations(method, swizzMethod);
        }
        
    });
}

- (void)sw_prepare {
    [self sw_prepare];
    self.titleLabTextColor = [UIColor colorByEnergyWithBinaryString:@"#B9B9B9"];
    self.titleLabFont = ByEnergyRegularFont(14);
    self.subViewMargin = 35.0f;
    self.actionBtnVerticalMargin = 47.0f;
    self.actionBtnHeight = 40;
    self.actionBtnBorderColor = [UIColor colorByEnergyWithBinaryString:@"#9A9A9A"];
    self.actionBtnTitleColor = [UIColor colorByEnergyWithBinaryString:@"#9A9A9A"];
    self.actionBtnBorderWidth = 1.0f;
    self.actionBtnHorizontalMargin = 46;
    self.actionBtnCornerRadius = 20.0f;
    self.emptyViewIsCompleteCoverSuperView = YES;
    self.actionBtnBackGroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    self.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f4fa"];
}
@end
