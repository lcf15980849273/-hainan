//
//  UIView+frame.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (frame)
@property (nonatomic, assign) CGPoint zm_origin;
@property (nonatomic, assign) CGSize zm_size;
@property (nonatomic, assign) CGFloat zm_x;
@property (nonatomic, assign) CGFloat zm_y;
@property (nonatomic, assign) CGFloat zm_width;
@property (nonatomic, assign) CGFloat zm_height;

@property (nonatomic, assign) CGFloat zm_centerX;
@property (nonatomic, assign) CGFloat zm_centerY;

@property (nonatomic, assign) CGFloat zm_maxX;
@property (nonatomic, assign) CGFloat zm_maxY;

@property (nonatomic, assign) CGFloat zm_left;
@property (nonatomic, assign) CGFloat zm_top;
@property (nonatomic, assign) CGFloat zm_right;
@property (nonatomic, assign) CGFloat zm_bottom;

@property (nonatomic, assign) CGFloat zm_halfWidth;
@property (nonatomic, assign) CGFloat zm_halfHeight;

/**< 水平填充父视图 */
- (void)zm_layoutFillSuperviewHorizontal;
/**< 水平填充父视图，左边距为leftMargin */
- (void)zm_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin;
/**< 水平填充父视图，右边距为rightMargin */
- (void)zm_layoutFillSuperviewHorizontalWithRightMargin:(CGFloat)rightMargin;
/**< 水平填充父视图，左边距为leftMargin，右边距为rightMargin */
- (void)zm_layoutFillSuperviewHorizontalWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

/**< 竖直填充父视图 */
- (void)zm_layoutFillSuperviewVertical;
/**< 竖直填充父视图，顶部边距为topMargin */
- (void)zm_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin;
/**< 竖直填充父视图，底部边距为bottomMargin */
- (void)zm_layoutFillSuperviewVerticalWithBottomMargin:(CGFloat)bottomMargin;
/**< 竖直填充父视图，顶部边距为topMargin，底部边距为bottomMargin */
- (void)zm_layoutFillSuperviewVerticalWithTopMargin:(CGFloat)topMargin bottomMargin:(CGFloat)bottomMargin;

/**< 设置布局 |(left)->(right)| */
- (void)zm_layoutLeft:(CGFloat)left right:(CGFloat)right;
/**< 设置布局 |(left)->(left + width)| */
- (void)zm_layoutLeft:(CGFloat)left width:(CGFloat)width;
/**< 设置布局 |(right - width)->(right)| */
- (void)zm_layoutRight:(CGFloat)right width:(CGFloat)width;
/**< 设置布局 |(top)->(bottom)| */
- (void)zm_layoutTop:(CGFloat)top bottom:(CGFloat)bottom;
/**< 设置布局 |(top)->(top + height)| */
- (void)zm_layoutTop:(CGFloat)top height:(CGFloat)height;
/**< 设置布局 |(bottom - height)->(bottom)| */
- (void)zm_layoutBottom:(CGFloat)bottom height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
