//
//  BEnergyMyCouponsViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"

typedef enum: NSInteger {
    /*我的优惠券*/
    MyCouponsStateValid = 0,//有效
    /*已失效的优惠券*/
    MyCouponsStateLose,//失效
}MyCouponsState;

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyMyCouponsViewController : BEnergyBaseViewController

@property (nonatomic, assign) MyCouponsState state;

@end

NS_ASSUME_NONNULL_END
