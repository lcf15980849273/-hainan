//
//  UIView+frame.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)


#pragma mark - Setter Getter

- (void)zm_layoutFillSuperviewHorizontal {
    [self zm_layoutFillSuperviewHorizontalWithLeftMargin:0.0f
                                             rightMargin:0.0f];
}

- (void)zm_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin {
    [self zm_layoutFillSuperviewHorizontalWithLeftMargin:leftMargin
                                             rightMargin:0.0f];
}

- (void)zm_layoutFillSuperviewHorizontalWithRightMargin:(CGFloat)rightMargin {
    [self zm_layoutFillSuperviewHorizontalWithLeftMargin:0.0f
                                             rightMargin:rightMargin];
}

- (void)zm_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    self.zm_left = leftMargin;
    self.zm_width = self.superview.zm_width - (leftMargin + rightMargin);
}

- (void)zm_layoutFillSuperviewVertical {
    [self zm_layoutFillSuperviewVerticalWithTopMargin:0.0f
                                         bottomMargin:0.0f];
}

- (void)zm_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin {
    [self zm_layoutFillSuperviewVerticalWithTopMargin:topMargin
                                         bottomMargin:0.0f];
}

- (void)zm_layoutFillSuperviewVerticalWithBottomMargin:(CGFloat)bottomMargin {
    [self zm_layoutFillSuperviewVerticalWithTopMargin:0.0f
                                         bottomMargin:bottomMargin];
}

- (void)zm_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin {
    self.zm_top = topMargin;
    self.zm_height = self.superview.zm_height - (topMargin + bottomMargin);
}

- (void)zm_layoutLeft:(CGFloat)left right:(CGFloat)right {
    self.zm_left = left;
    self.zm_width = right - left;
}

- (void)zm_layoutLeft:(CGFloat)left width:(CGFloat)width {
    self.zm_left = left;
    self.zm_width = width;
}

- (void)zm_layoutRight:(CGFloat)right width:(CGFloat)width {
    self.zm_left = right - width;
    self.zm_width = width;
}

- (void)zm_layoutTop:(CGFloat)top bottom:(CGFloat)bottom {
    self.zm_top = top;
    self.zm_height = bottom - top;
}

- (void)zm_layoutTop:(CGFloat)top height:(CGFloat)height {
    self.zm_top = top;
    self.zm_height = height;
}

- (void)zm_layoutBottom:(CGFloat)bottom height:(CGFloat)height {
    self.zm_top = bottom - height;
    self.zm_height = height;
}


- (void)setZm_origin:(CGPoint)zm_origin {
    CGRect frame = self.frame;
    frame.origin = zm_origin;
    self.frame = frame;
}

- (CGPoint)zm_origin {
    return self.frame.origin;
}

- (void)setZm_size:(CGSize)zm_size {
    CGRect frame = self.frame;
    frame.size = zm_size;
    self.frame = frame;
}

- (CGSize)zm_size {
    return self.frame.size;
}

- (void)setZm_x:(CGFloat)zm_x {
    CGRect frame = self.frame;
    frame.origin.x = zm_x;
    self.frame = frame;
}

- (CGFloat)zm_x {
    return CGRectGetMinX(self.frame);
}

- (void)setZm_y:(CGFloat)zm_y {
    CGRect frame = self.frame;
    frame.origin.y = zm_y;
    self.frame = frame;
}

- (CGFloat)zm_y {
    return CGRectGetMinY(self.frame);
}

- (void)setZm_width:(CGFloat)zm_width {
    CGRect frame = self.frame;
    frame.size.width = zm_width;
    self.frame = frame;
}

- (CGFloat)zm_width {
    return CGRectGetWidth(self.frame);
}

- (void)setZm_height:(CGFloat)zm_height {
    CGRect frame = self.frame;
    frame.size.height = zm_height;
    self.frame = frame;
}

- (CGFloat)zm_height {
    return CGRectGetHeight(self.frame);
}

- (void)setZm_centerX:(CGFloat)zm_centerX {
    CGPoint center = self.center;
    center.x = zm_centerX;
    self.center = center;
}

- (CGFloat)zm_centerX {
    return self.center.x;
}

- (void)setZm_centerY:(CGFloat)zm_centerY {
    CGPoint center = self.center;
    center.y = zm_centerY;
    self.center = center;
}

- (CGFloat)zm_centerY {
    return self.center.y;
}

- (void)setZm_maxX:(CGFloat)zm_maxX {
    self.zm_x = zm_maxX - self.zm_width;
}

- (CGFloat)zm_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setZm_maxY:(CGFloat)zm_maxY {
    self.zm_y = zm_maxY - self.zm_height;
}

- (CGFloat)zm_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setZm_left:(CGFloat)zm_left {
    self.zm_x = zm_left;
}

- (CGFloat)zm_left {
    return self.zm_x;
}

- (void)setZm_top:(CGFloat)zm_top {
    self.zm_y = zm_top;
}

- (CGFloat)zm_top {
    return self.zm_y;
}

- (void)setZm_right:(CGFloat)zm_right {
    self.zm_maxX = zm_right;
}

- (CGFloat)zm_right {
    return self.zm_maxX;
}

- (void)setZm_bottom:(CGFloat)zm_bottom {
    self.zm_maxY = zm_bottom;
}

- (CGFloat)zm_bottom {
    return self.zm_maxY;
}

- (void)setZm_halfWidth:(CGFloat)zm_halfWidth {
    self.zm_width = zm_halfWidth * 2.0f;
}

- (CGFloat)zm_halfWidth {
    return self.zm_width / 2.0f;
}

- (void)setZm_halfHeight:(CGFloat)zm_halfHeight {
    self.zm_height = zm_halfHeight * 2.0f;
}

- (CGFloat)zm_halfHeight {
    return self.zm_height / 2.0f;
}

@end
