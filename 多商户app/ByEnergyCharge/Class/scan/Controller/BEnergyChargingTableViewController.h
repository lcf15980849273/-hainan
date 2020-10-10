//
//  BEnergyChargingTableViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyChargingTableViewController : BEnergyBaseTableViewController
@property (nonatomic, copy) NSString *orderId;//订单编号
@property (nonatomic, assign) NSInteger duration;//动画时间
@property (nonatomic, assign) BOOL isUserInitiative;//是否显示结束充电提示
@end

NS_ASSUME_NONNULL_END
