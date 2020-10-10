//
//  BEnergyInvoiceDetailsItemChilderVC.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    InvoiceStatusTypeForChecking,       //  审核中
    InvoiceStatusTypeForAlready,        //  已开票
    InvoiceStatusTypeForSend,           //  已寄出
    InvoiceStatusTypeForLose,           //  已失效
}InvoiceStatusType;

@interface BEnergyInvoiceDetailsItemChilderVC : BEnergyBaseViewController
@property (nonatomic, assign) InvoiceStatusType statusType;
@end

NS_ASSUME_NONNULL_END
