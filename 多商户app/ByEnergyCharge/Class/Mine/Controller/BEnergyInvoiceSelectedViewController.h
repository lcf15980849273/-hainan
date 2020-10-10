//
//  BEnergyInvoiceSelectedViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyInvoiceSelectedViewController : BEnergyBaseViewController
@property (nonatomic, strong) RACSubject *selectSubject;
@property (nonatomic, strong) NSMutableArray *orderIdList;
@end

NS_ASSUME_NONNULL_END
