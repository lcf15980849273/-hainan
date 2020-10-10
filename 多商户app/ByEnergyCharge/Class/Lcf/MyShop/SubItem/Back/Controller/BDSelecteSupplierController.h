//
//  BDSelecteSupplierController.h
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//  选择供应商控制器

#import "BEnergyBaseViewController.h"
#import "BDSupplierModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDSelecteSupplierController : BEnergyBaseViewController

@property (nonatomic, copy) void(^selecteSuccessBlock)(BDSupplierModel *model);

@end

NS_ASSUME_NONNULL_END
