//
//  BEnergyWaitPayOrderView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BEnergyWaitPayOrderViewDelegate <NSObject>

@optional
- (void)submitPay;

- (void)closeView;

@end

@interface BEnergyWaitPayOrderView : BEnergyBaseView
@property (nonatomic, weak) id<BEnergyWaitPayOrderViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
