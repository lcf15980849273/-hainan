//
//  GuideFigure.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/31.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GuideFigureShowViewController;
@interface GuideFigure : NSObject

+ (instancetype)sharedFigure;

+ (void)figureWithImages:(NSArray *)images finashMainViewController:(UIViewController *)finashMainViewController;
/**
 *  pagecontrol的属性
 */
@property (nonatomic) float originY;
@property (nonatomic,strong) UIColor *currentPageColor;
@property (nonatomic,strong) UIColor *otherPageColor;

@end
