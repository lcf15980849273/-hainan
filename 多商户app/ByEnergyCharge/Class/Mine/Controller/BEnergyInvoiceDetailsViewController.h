//
//  BEnergyInvoiceDetailsViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyInvoiceDetailsViewController : BEnergyBaseViewController
/**
 发票订单号
 */
@property (nonatomic, copy) NSString *invoiceNum;

/**
 开票状态
 */
@property (nonatomic, assign) int status;

@end

NS_ASSUME_NONNULL_END
