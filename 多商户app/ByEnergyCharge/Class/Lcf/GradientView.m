//
//  GradientView.m
//  xinyanxiaodai
//
//  Created by mac on 2020/5/20.
//  Copyright © 2020 byl. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView
@synthesize bgEndColor = _bgEndColor, bgStartColor = _bgStartColor;

- (UIColor *)bgEndColor{
    if (!_bgEndColor) {
        _bgEndColor = kNavigationBarSubBGColor;
    }
    return _bgEndColor;
}

- (UIColor *)bgStartColor{
    if (!_bgStartColor) {
        _bgStartColor = kNavigationBarBGColor;
    }
    return _bgStartColor;
}

- (void)setBgEndColor:(UIColor *)bgEndColor{
    _bgEndColor = bgEndColor;
    [self drawRect:self.bounds];
}

- (void)setBgStartColor:(UIColor *)bgStartColor{
    _bgStartColor = bgStartColor;
    [self drawRect:self.bounds];
}

- (CGFloat)startValueY{
    if (!_startValueY) {
        _startValueY = 0;
    }
    return _startValueY;
}

- (CGFloat)startValueX{
    if (!_startValueX) {
        _startValueX = 0;
    }
    return _startValueX;
}

- (CGFloat)endValueX{
    if (!_endValueX) {
        _endValueX = 0.3;
    }
    return _endValueX;
}

- (CGFloat)endValueY{
    if (!_endValueY) {
        _endValueY = 0;
    }
    return _endValueY;
}


- (void)drawRect:(CGRect)rect {
    
    //实现背景渐变
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    
    if ([self.layer.sublayers.firstObject isKindOfClass:[CAGradientLayer class]]) {
        [self.layer.sublayers.firstObject removeFromSuperlayer];
    }
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(self.startValueX, self.startValueY);
    gradientLayer.endPoint = CGPointMake(self.endValueX, self.endValueY);
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)self.bgStartColor.CGColor,
                             (__bridge id)self.bgEndColor.CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
    
    [super drawRect:rect];
}

@end
