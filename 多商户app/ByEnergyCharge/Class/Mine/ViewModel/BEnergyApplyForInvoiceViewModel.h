//
//  BEnergyApplyForInvoiceViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyApplyForInvoiceViewModel : ByEnergyBaseViewModel
@property (nonatomic, copy) NSString *status;// 发票状态：0待开票；1已开票；2已寄出;3已失效
@property (nonatomic, copy) NSString *invoiceNum;// 发票订单号
@property (nonatomic, strong) NSMutableArray *orderIdList;// 选中的订单编号
@property (nonatomic, strong) RACCommand *hnFetchInvoiceSumCommand;// 获取用户开票与未开票金额
@property (nonatomic, strong) RACCommand *hnInvoiceDetailCommand;// 发票详情
@property (nonatomic, strong) RACCommand *hnInvoiceSortCommand;// 发票分类
@property (nonatomic, strong) RACCommand *hnInvoiceSumChoiceCommand;// 用户开票金额选择
@property (nonatomic, strong) RACCommand *hnInvoiceApplyCommand;// 用户开票提交申请
@property (nonatomic, strong) RACCommand *hnInvoiceTipsCommand;// 开票提交申请温馨提示

@end

NS_ASSUME_NONNULL_END
