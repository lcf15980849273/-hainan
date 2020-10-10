//
//  BEnergyBaseView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEnergyViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyBaseView : UIView<BEnergyViewProtocol>

- (void)byEnergyInitSubView;
@end

NS_ASSUME_NONNULL_END
