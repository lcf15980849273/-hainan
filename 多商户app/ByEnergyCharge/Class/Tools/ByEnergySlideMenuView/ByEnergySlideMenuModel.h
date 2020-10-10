//
//  ByEnergySlideMenuModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/4.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ByEnergySlideMenuModel : NSObject
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) NSArray *controllers;
@property(nonatomic,assign) int itemSelectedIndex;
@property(nonatomic,assign) CGFloat itemMargin;
@property(nonatomic,assign) int leftIndex;
@property(nonatomic,assign) int rightIndex;
@property(nonatomic,assign) CGFloat indicatorAnimatePadding;
@property(nonatomic,strong) UIFont *itemFont;
@property(nonatomic,strong) UIColor *itemSelectedColor;
@property(nonatomic,strong) UIColor *itemUnselectedColor;
@property(nonatomic,assign) CGFloat bottomPadding;
@property(nonatomic,assign) CGFloat indicatorHeight;
@property(nonatomic,strong) UIImage *indicatorImg;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSArray *points;
@property(nonatomic,assign) BOOL showsHorizontalScrollIndicator;
@property(nonatomic,assign) BOOL showsVerticalScrollIndicator;
@property(nonatomic,assign) BOOL bounces;
@end
