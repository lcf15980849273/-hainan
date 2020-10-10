//
//  ByEnergyLoadViews.h
//  ByEnergyCharge
//
//  Created by newyea on 2017/12/12.
//  Copyright © 2017年 隔壁老王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ByEnergyLoadViews : NSObject
/**
 * @method loadViewWithViewClass:
 * @abstract 从与类名对应的XIB文件中加载View对象，View的owner为nil
 * @param viewClass View对象类名
 */
+ (id)loadViewWithViewClass:(Class)viewClass;

/**
 * @method loadViewWithViewClass:
 * @abstract 从与类名对应的XIB文件中加载指定索引的View对象，View的owner为nil
 * @param viewClass View对象类名
 * @param index View在XIB中的顺序索引
 */
+ (id)loadViewWithViewClass:(Class)viewClass atIndex:(NSUInteger)index;

/**
 * @method loadViewWithViewClass:
 * @abstract 从与类名对应的XIB文件中加载View对象，允许指定View的owner
 * @param viewClass View对象类名
 * @param owner View的owner
 */
+ (id)loadViewWithViewClass:(Class)viewClass owner:(id)owner;

/**
 * @method loadViewWithViewClass:
 * @abstract 从与类名对应的XIB文件中加载指定索引的View对象，允许指定View的owner
 * @param viewClass View对象类名
 * @param owner View的owner
 * @param index View在XIB中的顺序索引
 */
+ (id)loadViewWithViewClass:(Class)viewClass owner:(id)owner atIndex:(NSUInteger)index;

/**
 * @method loadViewFromNib:
 * @abstract 从XIB文件中加载View对象，View的owner为nil
 * @param nibName XIB文件名
 */
+ (id)loadViewFromNib:(NSString *)nibName;

/**
 * @method loadViewFromNib:
 * @abstract 从XIB文件中加载View对象，允许指定View的owner
 * @param nibName XIB文件名
 */
+ (id)loadViewFromNib:(NSString *)nibName owner:(id)owner;

/**
 * @method loadViewFromNib:
 * @abstract 从与类名对应的XIB文件中加载指定索引的View对象，允许指定View的owner
 * @param nibName XIB文件名
 * @param owner View的owner
 * @param index View在XIB中的顺序索引
 */
+ (id)loadViewFromNib:(NSString *)nibName owner:(id)owner atIndex:(NSUInteger)index;



/**
 * @method removeAllSubViews:
 * @abstract 删除View的所有sub view
 */
+ (void)removeAllSubViews:(UIView *)view;

/**
 * @method removeSubViews:fromIndex:
 * @abstract 删除View从指定索引开始的sub view
 */
+ (void)removeSubViews:(UIView *)view fromIndex:(NSUInteger)index;

/**
 * @method removeSubViews:fromIndex:
 * @abstract 删除View中指定索引的sub view
 */
+ (void)removeSubView:(UIView *)view atIndex:(NSUInteger)index;


#pragma mark-

/**
 * 以 X 坐标 居中
 */
+ (void)centralizeXInSuperView:(UIView *)superView subView:(UIView *)subView;

/**
 * 以 Y 坐标 居中
 */
+ (void)centralizeYInSuperView:(UIView *)superView subView:(UIView *)subView;

/**
 * 以 XY（中心点） 坐标 居中
 */
+ (void)centralizeXYInSuperView:(UIView *)superView subView:(UIView *)subView;


/**
 * 设置分段背景颜色
 */

+ (void)segmentBackgroundColor:(UIView *)view Colors:(NSArray *)colors Percent:(float)percent;

/**
 * 获取当前ViewController
 */
+ (UIViewController *)getCurrentViewController;

/**
 * 设置view的边框
 */
+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

@end
