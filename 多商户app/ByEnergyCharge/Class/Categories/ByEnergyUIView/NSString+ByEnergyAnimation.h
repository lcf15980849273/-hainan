//
//  NSString+ByEnergyAnimation.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/27.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ByEnergyAnimation)
- (void)byEnergyViewWithAnimation:(UIView *)view;
- (void)byEnergyViewWithAnimationtoNarrow:(UIView *)view sate:(BOOL)state;
@end

NS_ASSUME_NONNULL_END
