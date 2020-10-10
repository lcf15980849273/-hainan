//
//  UIView+Gesture.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIView+Gesture.h"
#import "NSObject+VDExtraData.h"

@implementation UIView (Gesture)
- (void)zm_performActionOnTap:(BDGestureActionBlock)action {
    [self zm_performActionOnTap:action backgroundOnly:NO];
}

- (void)zm_performActionOnTap:(BDGestureActionBlock)action backgroundOnly:(BOOL)isBackgroundOnly {
    self.zm_tapGestureElement.action = action;
    self.zm_tapGestureElement.backgroundOnly = isBackgroundOnly;
}

- (void)zm_performSelectorOnTapWithTarget:(id)target selector:(SEL)selector {
    [self zm_performSelectorOnTapWithTarget:target selector:selector backgroundOnly:NO];
}

- (void)zm_performSelectorOnTapWithTarget:(id)target selector:(SEL)selector backgroundOnly:(BOOL)isBackgroundOnly {
    self.zm_tapGestureElement.action = nil;
    self.zm_tapGestureElement.actionTarget = target;
    self.zm_tapGestureElement.actionSelector = selector;
    self.zm_tapGestureElement.backgroundOnly = isBackgroundOnly;
}

#pragma mark - Setter Getter

- (void)setZm_tapGestureElement:(BDGestureElement *)zm_tapGestureElement {
    [self vd_extraDataForSelector:@selector(zm_tapGestureElement)].data = zm_tapGestureElement;
}

- (BDGestureElement *)zm_tapGestureElement {
    BDGestureElement *element = [self vd_extraDataForSelector:@selector(zm_tapGestureElement)].data;
    if (!element) {
        element = [BDGestureElement new];
        element.target = self;
        self.zm_tapGestureElement = element;
    }
    
    return element;
}

@end

@implementation BDGestureElement

@synthesize gestureRecognizer = _gestureRecognizer;

#pragma mark - Protocol
#pragma mark <UIGestureRecognizerDelegate>


//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//        return NO;
//    }
//    return YES;
//}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) { //兼容下tableView的点击
        return NO;
    }
    if (self.isBackgroundOnly) {
        UIView *view = touch.view;
        if (view != self.target &&
            [view isDescendantOfView:self.target]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Actions

- (void)gestureRecognizerDidRecognize:(UIGestureRecognizer *)gestureRecognizer {
    if (self.action) {
        self.action(self.target);
    }
    else if (self.actionTarget && self.actionSelector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.actionTarget performSelector:self.actionSelector withObject:self.target];
#pragma clang diagnostic pop
    }
}

#pragma mark - Setter Getter

- (void)setTarget:(UIView *)target {
    if (_target == target) {
        return;
    }
    
    [_target removeGestureRecognizer:self.gestureRecognizer];
    
    _target = target;
    
    [target addGestureRecognizer:self.gestureRecognizer];
    target.userInteractionEnabled = YES;
}

#pragma mark - Lazy Load

- (UIGestureRecognizer *)gestureRecognizer {
    if (!_gestureRecognizer) {
        UIGestureRecognizer *object = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidRecognize:)];
        object.delegate = self;
        _gestureRecognizer = object;
    }
    
    return _gestureRecognizer;
}

@end
