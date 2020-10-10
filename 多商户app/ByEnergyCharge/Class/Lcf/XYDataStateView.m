//
//  XYDataStateView.m
//  XinYongXingQiu
//
//  Created by 刘辰峰 on 2020/3/21.
//  Copyright © 2020 夏立群. All rights reserved.
//

#import "XYDataStateView.h"
@interface XYDataStateView ()

@property (nonatomic, weak) UIScrollView *superScrollView;
@end
@implementation XYDataStateView

#pragma mark - Overrides

- (void)byEnergyInitSubView {
    [super byEnergyInitSubView];
    
    [self addSubview:self.wrapperView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.superview bringSubviewToFront:self];
    self.zm_size = self.superview.zm_size;
    
    UIView *attachedRootView = [self attachedRootView];
    
    CGFloat statusBarOffset = 20.0f - [self convertPoint:CGPointZero toView:attachedRootView].y;
    statusBarOffset = MAX(statusBarOffset,
                          0.0f);
    
    CGFloat topEdge = MAX(statusBarOffset,
                          self.edgeInsets.top);
    
    [self.wrapperView zm_layoutFillSuperviewHorizontalWithLeftMargin:self.edgeInsets.left
                                                         rightMargin:self.edgeInsets.right];
    [self.wrapperView zm_layoutFillSuperviewVerticalWithTopMargin:topEdge
                                                     bottomMargin:self.edgeInsets.bottom];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.superScrollView = nil;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    UIView *superView = self.superview;
    while (superView) {
        if ([superView isKindOfClass:[UIScrollView class]]) {
            self.superScrollView = (UIScrollView *) superView;
            break;
        }
        
        superView = superView.superview;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Public Method

- (CGPoint)centerForSubviewInWrapperView {
    UIView *attachedRootView = [self attachedRootView];
    
    CGPoint point = CGPointMake(attachedRootView.zm_halfWidth,
                                attachedRootView.zm_halfHeight);
    point = [self.wrapperView convertPoint:point
                                  fromView:attachedRootView];
    
    point.x = self.wrapperView.zm_halfWidth;
    point.y -= self.superScrollView.contentOffset.y;
    point.y = MAX(point.y,
                  0.0f);
    
    return point;
}

- (UIView *)attachedRootView {
    UIView *rootView= self;
    while (rootView.superview) {
        rootView = rootView.superview;
        rootView.backgroundColor = [UIColor whiteColor];
    }
    return rootView;
}

#pragma mark - Setter Getter
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
}

#pragma mark - Lazy Load

- (UIView *)wrapperView {
    if (!_wrapperView) {
        UIView *obj = [[UIView alloc] initWithFrame:ScreenBounds];
        obj.backgroundColor = [UIColor whiteColor];
        
        _wrapperView = obj;
    }
    
    return _wrapperView;
}

@end
