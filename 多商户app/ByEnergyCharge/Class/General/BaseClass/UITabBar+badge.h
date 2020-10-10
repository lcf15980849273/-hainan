//
//  UITabBar+badge.h
//  byCF
//
//  Created by 刘辰峰 on 2020/4/16.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (badge)
/**
 隐藏小红点
 */
- (void)hideBadgeOnItemIndex:(int)index;

/**
 显示或者隐藏badgeView yes:显示，no:隐藏 count 显示的数量
 */
- (void)showOrHidenBadgeViewWithIndex:(NSInteger)index Flag:(BOOL)flag Count:(long)count;
@end

NS_ASSUME_NONNULL_END
