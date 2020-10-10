//
//  ByEnergySlideMenuView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/4.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ByEnergySlideMenuModel.h"


typedef NS_ENUM(NSInteger,SlideMenuIndicatorType) {
    SlideMenuIndicatorTypeNormal = 0,
    SlideMenuIndicatorTypeStrech,
    SlideMenuIndicatorTypeStrechAndMove
};

typedef void(^SlideMenuViewBlock)(NSInteger index);

@interface ByEnergySlideMenuView : UIView
@property(nonatomic,assign)SlideMenuIndicatorType indicatorType;
@property(nonatomic,strong)ByEnergySlideMenuModel *slideMenuModel;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles childControllers:(NSArray <UIViewController *>*)controllers;

- (instancetype)initWithFrame:(CGRect)frame SlideMenuModel:(ByEnergySlideMenuModel *)slideMenuModel completion:(void (^)(NSInteger index))completion;
- (void)byEnergyslideSelectorItemDidClicked:(int)index;

- (void)byEnergyslideSelectorScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)byEnergyslideSelectorScrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end
