//
//  BEnergyInvoiceDetailsModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BaseInfo,ConsumInfoItem;
@interface BEnergyInvoiceDetailsModel : BEnergyBaseModel
@property (nonatomic, strong) BaseInfo *baseInfo;
@property (nonatomic, strong) NSArray<ConsumInfoItem *> * consumInfo;
@end

@interface ConsumInfoItem : BEnergyBaseModel
@property (nonatomic, copy) NSString *buyerAddress;

@property (nonatomic, copy) NSString *orderIdList;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *invoiceType;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *expressName;

@property (nonatomic, copy) NSString *accountId;

@property (nonatomic, copy) NSString *expressNum;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *invoiceUpdateTime;

@property (nonatomic, copy) NSString *orderCreateTime;

@property (nonatomic, copy) NSString *stubId;

@property (nonatomic, copy) NSString *tariff;

@property (nonatomic, copy) NSString *corporationNum;

@property (nonatomic, copy) NSString *expressPayer;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *buyerPhone;

@property (nonatomic, copy) NSString *accountNum;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *orderPayAmount;

@property (nonatomic, copy) NSString *invoiceCreateTime;

@property (nonatomic, copy) NSString *failReason;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *expressMoney;

@property (nonatomic, copy) NSString *postalcode;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *invoiceNum;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *modifyAccount;

@property (nonatomic, copy) NSString *createAccount;

@property (nonatomic, copy) NSString *stubGroupName;

@property (nonatomic, copy) NSString *stubName;
@end

@interface BaseInfo : BEnergyBaseModel

@property (nonatomic, copy) NSString *buyerAddress;

@property (nonatomic, copy) NSString *orderIdList;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *invoiceType;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *expressName;

@property (nonatomic, copy) NSString *accountId;

@property (nonatomic, copy) NSString *expressNum;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *invoiceUpdateTime;

@property (nonatomic, copy) NSString *orderCreateTime;

@property (nonatomic, copy) NSString *stubId;

@property (nonatomic, copy) NSString *tariff;

@property (nonatomic, copy) NSString *corporationNum;

@property (nonatomic, copy) NSString *expressPayer;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *buyerPhone;

@property (nonatomic, copy) NSString *accountNum;

@property (nonatomic, assign) int status;

@property (nonatomic, copy) NSString *orderPayAmount;

@property (nonatomic, copy) NSString *invoiceCreateTime;

@property (nonatomic, copy) NSString *failReason;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *expressMoney;

@property (nonatomic, copy) NSString *postalcode;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *invoiceNum;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) float money;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *modifyAccount;

@property (nonatomic, copy) NSString *createAccount;

@property (nonatomic, copy) NSString *stubGroupName;

@property (nonatomic, copy) NSString *stubName;

@property (nonatomic, assign) CGFloat nameHeight;

@property (nonatomic, assign) CGFloat addressHeight;

@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, assign) CGFloat corporationNumHeight;

@end


NS_ASSUME_NONNULL_END
