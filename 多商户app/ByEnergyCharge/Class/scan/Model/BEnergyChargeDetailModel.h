//
//  BEnergyChargeDetailModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyChargeDetailModel : BEnergyBaseModel
/**/
@property (nonatomic, assign) NSInteger status;
/**/
@property (nonatomic, assign) float userAmount;
/*充电结束时间*/
@property (nonatomic, copy) NSString *timeEnd;
/**/
@property (nonatomic, copy) NSString *totalFeeInfo;
/**/
@property (nonatomic, assign) float voltage;
/**/
@property (nonatomic, copy) NSString *score;
/*充电开始时间*/
@property (nonatomic, copy) NSString *timeStart;
/*实付金额*/
@property (nonatomic, assign) float feeTotal;
/**/
@property (nonatomic, copy) NSString *city;

/*充电电费（元）*/
@property (nonatomic, assign) float feeElectric;
/**/
@property (nonatomic, copy) NSString *endsoc;
/**/
@property (nonatomic, copy) NSString *outOrderId;
/**/
@property (nonatomic, copy) NSString *stubId;
/**/
@property (nonatomic, copy) NSString *endInfo;
/**/
@property (nonatomic, copy) NSString *stubGroupId;
/*订单编号*/
@property (nonatomic, copy) NSString *id;
/**/
@property (nonatomic, assign) float current;
/*充电量（度）*/
@property (nonatomic, assign) float power;
/*充电服务费（元）*/
@property (nonatomic, assign) float feeService;
/*桩名称*/
@property (nonatomic, copy) NSString *stubName;
/*桩群名称*/
@property (nonatomic, copy) NSString *stubGroupName;
/**/
@property (nonatomic, assign) NSInteger timeCharge;
/**/
@property (nonatomic, assign) float serviceFeePrePower;
/**/
@property (nonatomic, assign) NSInteger soc;
/**/
@property (nonatomic, assign) float electricFeePrePower;
/**/
@property (nonatomic, assign) NSInteger chargeType;
/*终端编号*/
@property (nonatomic, copy) NSString *userId;
/*充电时长*/
@property (nonatomic, copy) NSString *timeDiff;
/**/
@property (nonatomic, copy) NSString *payDesc;
/**/
@property (nonatomic, copy) NSString *cStubGroupName;
/*终端类型：直流快充/交流慢充*/
@property (nonatomic, copy) NSString *chargeTypeDesc;
/*实际支付金额*/
@property (nonatomic, copy) NSString *couponFinalPrice;
/*优惠券折扣金额*/
@property (nonatomic, copy) NSString *couponDicountPrice;
/*原始支付金额*/
@property (nonatomic, copy) NSString *couponOrginalPrice;
/*优惠券名称*/
@property (nonatomic, copy) NSString *couponName;
/*是否使用优惠券（0.未使用，1.使用）*/
@property (nonatomic, assign) NSInteger couponIsUser;

@property (nonatomic, assign) double refundFee;//退还金额
@property (nonatomic, copy) NSString *rechargeFee;//预充金额

@property (nonatomic, assign) BOOL isRefund;//是否有预充金额

//[14（即冲即退）,15（余额充电）,16（机构充电）]
@property (nonatomic, assign) int startType;
@property (nonatomic, copy) NSString *organizationName;//机构充电描述
@end

NS_ASSUME_NONNULL_END
