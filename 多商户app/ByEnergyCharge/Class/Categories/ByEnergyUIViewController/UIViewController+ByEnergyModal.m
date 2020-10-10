//
//  UIViewController+ByEnergyModal.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/10.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "UIViewController+ByEnergyModal.h"


#import <objc/runtime.h>

@implementation UIViewController (ByEnergyModal)

+ (void)load {
    [super load];
    SEL exchangeSel = @selector(lg_presentViewController:animated:coption:);
    SEL originalSel = @selector(presentViewController:animated:completion:);
    method_exchangeImplementations(class_getInstanceMethod(self.class, originalSel), class_getInstanceMethod(self.class, exchangeSel));
}

- (void)lg_presentViewController:(UIViewController *)present animated:(BOOL)flag coption:(void(^__nullable)(void))coption {
    present.modalPresentationStyle = UIModalPresentationFullScreen;
    [self lg_presentViewController:present animated:flag coption:coption];
}

@end
