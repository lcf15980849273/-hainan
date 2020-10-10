//
//  UIButton+Layout.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/19.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "UIButton+Layout.h"
#import <objc/runtime.h>

@implementation UIButton (Layout)

#pragma mark - ************* 通过运行时动态添加关联 ******************
//定义关联的Key
static const char * titleRectKey = "ny_titleRectKey";
- (CGRect)titleRect {
    
    return [objc_getAssociatedObject(self, titleRectKey) CGRectValue];
}

- (void)setTitleRect:(CGRect)rect {
    
    objc_setAssociatedObject(self, titleRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

//定义关联的Key
static const char * imageRectKey = "ny_imageRectKey";
- (CGRect)imageRect {
    
    NSValue * rectValue = objc_getAssociatedObject(self, imageRectKey);
    
    return [rectValue CGRectValue];
}

- (void)setImageRect:(CGRect)rect {
    
    objc_setAssociatedObject(self, imageRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - ************* 通过运行时动态替换方法 ******************
+ (void)load {
    
    MethodSwizzle(self,@selector(titleRectForContentRect:),@selector(override_titleRectForContentRect:));
    MethodSwizzle(self,@selector(imageRectForContentRect:),@selector(override_imageRectForContentRect:));
}

void MethodSwizzle(Class c,SEL origSEL,SEL overrideSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod= class_getInstanceMethod(c, overrideSEL);
    
    //运行时函数class_addMethod 如果发现方法已经存在，会失败返回，也可以用来做检查用:
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod)))
    {
        //如果添加成功(在父类中重写的方法)，再把目标类中的方法替换为旧有的实现:
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        //addMethod会让目标类的方法指向新的实现，使用replaceMethod再将新的方法指向原先的实现，这样就完成了交换操作。
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}

- (CGRect)override_titleRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [self override_titleRectForContentRect:contentRect];
    
}

- (CGRect)override_imageRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [self override_imageRectForContentRect:contentRect];
}

- (void)setIconInLeftWithSpacing:(CGFloat)Spacing {
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    = 0,
        .left   = Spacing / 2,
        .bottom = 0,
        .right  = -Spacing / 2,
    };
    self.imageEdgeInsets = (UIEdgeInsets) {
        .top    = 0,
        .left   = -Spacing / 2,
        .bottom = 0,
        .right  = Spacing / 2,
    };
}

- (void)setIconInRightWithSpacing:(CGFloat)Spacing {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    = 0,
        .left   = - (img_W + Spacing / 2),
        .bottom = 0,
        .right  =   (img_W + Spacing / 2),
    };
    self.imageEdgeInsets = (UIEdgeInsets) {
        .top    = 0,
        .left   =   (tit_W + Spacing / 2),
        .bottom = 0,
        .right  = - (tit_W + Spacing / 2),
    };
}


- (void)setIconInTopWithSpacing:(CGFloat)Spacing {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    =   (tit_H / 2 + Spacing / 2),
        .left   = - (img_W / 2),
        .bottom = - (tit_H / 2 + Spacing / 2),
        .right  =   (img_W / 2),
    };
    self.imageEdgeInsets = (UIEdgeInsets) {
        .top    = - (img_H / 2 + Spacing / 2),
        .left   =   (tit_W / 2),
        .bottom =   (img_H / 2 + Spacing / 2),
        .right  = - (tit_W / 2),
    };
}

- (void)setIconInBottomWithSpacing:(CGFloat)Spacing {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    self.titleEdgeInsets = (UIEdgeInsets) {
        .top    = - (tit_H / 2 + Spacing / 2),
        .left   = - (img_W / 2),
        .bottom =   (tit_H / 2 + Spacing / 2),
        .right  =   (img_W / 2),
    };
    self.imageEdgeInsets = (UIEdgeInsets) {
        .top    =   (img_H / 2 + Spacing / 2),
        .left   =   (tit_W / 2),
        .bottom = - (img_H / 2 + Spacing / 2),
        .right  = - (tit_W / 2),
    };
}
@end
