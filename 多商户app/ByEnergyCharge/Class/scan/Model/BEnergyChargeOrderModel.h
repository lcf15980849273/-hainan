//
//  BEnergyChargeOrderModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyChargeOrderModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *id;                 ///订单编号
@property (nonatomic, copy) NSString *stubId;             ///桩编号
@property (nonatomic, copy) NSString *stubGroupName;      ///桩群名称
@property (nonatomic, copy) NSString *userId;             ///第三方用户编号
@property (nonatomic, copy) NSString *outOrderId;         ///app订单编号
@property (nonatomic, copy) NSString *timeStart;          ///充电开始时间，格式：YYYY.MM.DD HH24:MI:SS
@property (nonatomic, copy) NSString *timeEnd;            ///充电结束时间（充电未结束时为空）
@property (nonatomic, copy) NSString *timeCharge;         ///充电时长（秒）
@property (nonatomic, assign) double feeTotal;              ///充电金额
@property (nonatomic, assign) double power;                 ///充电电量
@property (nonatomic, assign) double current;               ///充电电流
@property (nonatomic, assign) double voltage;               ///充电电压
@property (nonatomic, assign) int soc;                      ///电池百分比(整数0-100)
@property (nonatomic, assign) int status;                   ///状态【1:充电中,9:充电完成
@property (nonatomic, copy) NSString *endInfo;            ///充电结束原因
@property (nonatomic, copy) NSString *score;              ///评分(1-5)，0为未评分
@property (nonatomic) int chargeType;                       ///充电类型（0-交流，1-直流）
@property (nonatomic) double refund;                        ///退回金额
@property (nonatomic, copy) NSString *refundError;        ///退款失败原因
@property (nonatomic, copy) NSString *platformError;      ///平台错误信息
@property (nonatomic, assign) double electricFeePrePower;   ///当前订单每度电费费用
@property (nonatomic, assign) double serviceFeePrePower;    ///当前订单每度电服务费费用
@property (nonatomic, assign) double userAmount;            ///当前余额
@property (nonatomic, assign) double totalFee;              ///当前充电单价
@property (nonatomic, copy) NSString *chargeTypeDesc;      ///终端类型：直流快充/交流慢充
@property (nonatomic, copy) NSString *payDesc;            ///支付方式
@property (nonatomic,assign) CGFloat cellHeight;            ///标题高度
@property (nonatomic, copy) NSString *carNumber;            ///充电车牌

@property (nonatomic, assign) int startType;// 启动类型[14（即冲即退）,15（余额充电）,16（机构充电）]
@property (nonatomic, copy) NSString *organizationName;//机构充电描述
@end

NS_ASSUME_NONNULL_END
