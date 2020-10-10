//
//  BEnergyHomePagePopView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyHomePagePopView : UIView

@property (weak, nonatomic) IBOutlet SDCycleScrollView *advImageView;

- (void)viewShow;
- (void)viewHiden;
@end

NS_ASSUME_NONNULL_END
