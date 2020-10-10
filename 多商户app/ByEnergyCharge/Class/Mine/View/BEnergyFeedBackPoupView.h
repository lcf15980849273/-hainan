//
//  BEnergyFeedBackPoupView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyFeedBackPoupView : UIView


- (void)viewShow;
- (void)viewHiden;
@property (weak, nonatomic) IBOutlet ByEnergyTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, copy) void(^commitAddtionalFeedBackBlock)(void);
@end

NS_ASSUME_NONNULL_END
