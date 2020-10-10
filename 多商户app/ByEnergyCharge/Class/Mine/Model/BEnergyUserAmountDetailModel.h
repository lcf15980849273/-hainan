//
//  BEnergyUserAmountDetailModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyUserAmountDetailModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *bank_description;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) float money;
@property (nonatomic, assign) float amount;
@property (nonatomic, copy) NSString *reChargeNote;
@property (nonatomic, copy) NSString *freezingTime;
@property (nonatomic, copy) NSString *reachAmount;
@property (nonatomic, copy) NSString *payType;
@property (nonatomic, copy) NSString *invoiceRecordId;
@property (nonatomic, copy) NSString *typeNote;
@property (nonatomic, copy) NSString *payFinishQueryId;
@property (nonatomic, copy) NSString *logId;
@property (nonatomic, copy) NSString *reChargeType;
@property (nonatomic, copy) NSString *currentBalance;
@property (nonatomic, copy) NSString *info;
/*资金状态（0:消费,1:充值,3：冻结，4.提现成功，5.提现失败）*/
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *useType;
@property (nonatomic, assign) NSInteger srcPlatform;
@property (nonatomic, copy) NSString *createAccount;
@property (nonatomic, copy) NSString *notifyTime;
@property (nonatomic, copy) NSString *payAccount;
@property (nonatomic, copy) NSString *payQueryId;
@property (nonatomic, copy) NSString *refundStatus;
@property (nonatomic, copy) NSString *refund;
@property (nonatomic, copy) NSString *refundType;
@property (nonatomic, copy) NSString *payTradeNo;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *advanceInfo;
@property (nonatomic, copy) NSString *unfreezingTime;
@property (nonatomic, copy) NSString *accountId;
@property (nonatomic, copy) NSString *orderId;

@end

NS_ASSUME_NONNULL_END
