//
//  GuideFigureShowViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/31.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideFigureShowViewController : UIViewController
//images
@property (nonatomic,strong) NSArray *images;
//click
@property (nonatomic,strong) void (^clickLastPage) ();
/**
 *  pagecontrol的属性
 */
@property (nonatomic) float originY;
@property (nonatomic,strong) UIColor *currentPageColor;
@property (nonatomic,strong) UIColor *otherPageColor;

@end
