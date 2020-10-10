//
//  UITabBar+badge.m
//  byCF
//
//  Created by 刘辰峰 on 2020/4/16.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import "UITabBar+badge.h"

//tabbar的数量
static const NSInteger TabbarItemNums = 5;


@implementation UITabBar (badge)


- (void)showOrHidenBadgeViewWithIndex:(NSInteger)index Flag:(BOOL)flag Count:(long)count {
    UIView *badgeView = [self hasBadgeView:index];
//    if (!badgeView) {
//        badgeView = [self createBadgeViewWithIndex:index withCount:count];
//    }
    
    if (badgeView) {
        [badgeView removeAllSubviews];
    }
    badgeView = [self createBadgeViewWithIndex:index withCount:count];
    badgeView.hidden = !flag;
    [self bringSubviewToFront:badgeView];
}

- (UIView *)createBadgeViewWithIndex:(NSInteger)index withCount:(long)count {
    //新建小红点
    UIView *badgeView = [[UIView alloc] init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = badgeView.frame.size.width / 2;
    badgeView.backgroundColor = [UIColor clearColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index + 0.57f) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.10f * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 12.0f, 12.0f);
    [self addSubview:badgeView];
    
    CGRect frame = CGRectMake(0.0f, 0.0f, 13.0f, 13.0f);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text =[NSString stringWithFormat:@"%ld",count];
    label.textColor = [UIColor whiteColor];

    label.font = ByEnergyRegularFont(10);
    label.backgroundColor = [UIColor redColor];
    label.layer.cornerRadius = label.frame.size.width / 2.0f;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(badgeView.frame.size.width / 2.0f, badgeView.frame.size.height / 2.0f);
    [badgeView addSubview:label];
    
    return badgeView;
}

- (void)hideBadgeOnItemIndex:(int)index {
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (UIView *)hasBadgeView:(NSInteger)index {
    //按照tag值获取badgeView
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888 + index) {
            return subView;
        }
    }
    return nil;
}

- (void)removeBadgeOnItemIndex:(int)index {
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888 + index) {
            [subView removeFromSuperview];
        }
    }
}
@end
