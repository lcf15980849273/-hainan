//
//  BEnergyApplyCashFooterView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/4.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyApplyCashFooterView : BEnergyBaseView
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) void(^submitButtonBlock)(void);
@end

NS_ASSUME_NONNULL_END
