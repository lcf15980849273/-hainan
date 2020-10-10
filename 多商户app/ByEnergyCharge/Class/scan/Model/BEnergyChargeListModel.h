//
//  BEnergyChargeListModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyChargeListModel : BEnergyBaseModel

@property (nonatomic, copy) NSString *eleDiscount;

@property (nonatomic, copy) NSString *accountStatus;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *discountFee;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *integral;

@property (nonatomic, copy) NSString *accountId;

@property (nonatomic, copy) NSString *cityForExcel;

@property (nonatomic, assign) float electric;

@property (nonatomic, copy) NSString *serviceDiscount;

@property (nonatomic, assign) NSInteger giveMoney;

@property (nonatomic, copy) NSString *chargeEndTime;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, assign) NSInteger chargeTimes;

@property (nonatomic, copy) NSString *avgEle;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *rechargeId;

@property (nonatomic, copy) NSString *stubId;

@property (nonatomic, assign) float payAmount;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *totalFee;

@property (nonatomic, copy) NSString *monthEle;

@property (nonatomic, copy) NSString *stubGroupId;

@property (nonatomic, copy) NSString *totalEle;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) float rechargeMoney;

@property (nonatomic, copy) NSString *diffTime;

@property (nonatomic, copy) NSString *includeBeta;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) float fee;

@property (nonatomic, copy) NSString *cardId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *month;

@property (nonatomic, copy) NSString *chargeInterval;

@property (nonatomic, copy) NSString *stubGroupName;

@property (nonatomic, copy) NSString *refund;

@property (nonatomic, copy) NSString *chargeBeginTime;

@property (nonatomic, copy) NSString *stubName;

@property (nonatomic, copy) NSString *outOrderId;

@property (nonatomic, copy) NSString *soc;

@property (nonatomic, assign) NSInteger chargeListOrderType;//1、充电中 2、已完成 3、待支付

@property (nonatomic, assign) int startType;// 启动类型[14（即冲即退）,15（余额充电）,16（机构充电）]
@property (nonatomic, copy) NSString *organizationName;//机构充电描述

@end

NS_ASSUME_NONNULL_END
