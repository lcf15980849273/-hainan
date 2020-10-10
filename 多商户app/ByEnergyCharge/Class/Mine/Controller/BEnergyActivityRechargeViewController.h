//
//  BEnergyActivityRechargeViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/12.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"
#import "BEnergyActiveChargeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyActivityRechargeViewController : BEnergyBaseViewController

@property (nonatomic, strong) NSArray <BEnergyActiveChargeModel *> *activeArray;
@end

NS_ASSUME_NONNULL_END
