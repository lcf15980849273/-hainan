//
//  BEnergyChargePayInfoModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ChargeTypeModel,ChargeMoneyModel;
@interface BEnergyChargePayInfoModel : NSObject

@property(nonatomic, assign)double userAmount;//金额
@property (nonatomic, copy) NSString *tips;
@property(nonatomic, assign)long appTypeSelected;
@property(nonatomic, assign)long appType;//0.即充即退和余额，1.即充即退，2.余额
@property(nonatomic, strong)NSArray <ChargeTypeModel *>*chargeType;
@property(nonatomic, strong)NSArray <ChargeMoneyModel *>*chargeMoney;
@end

@interface ChargeTypeModel : NSObject //充值方式

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property(nonatomic, assign)BOOL isSelcet;
@end

@interface ChargeMoneyModel : NSObject //金额选择

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;//0.02元
@property (nonatomic, copy) NSString *value;//0.02
@property(nonatomic, assign)BOOL isSelcet;
@end
NS_ASSUME_NONNULL_END
