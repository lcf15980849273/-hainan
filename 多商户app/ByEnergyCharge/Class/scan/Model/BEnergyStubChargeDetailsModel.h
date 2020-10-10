//
//  BEnergyStubChargeDetailsModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyStubChargeDetailsModel : BEnergyBaseModel
//电费
@property (nonatomic, copy) NSString *electricFee;
//当前时段
@property (nonatomic, copy) NSString *currentTime;
//充电费用
@property (nonatomic, copy) NSString *serviceFee;
//充电桩名称
@property (nonatomic, copy) NSString *name;
//桩编号
@property (nonatomic, copy) NSString *stuId;

@property (nonatomic, assign) int isNeedCarNumber;//(0.不需要引导用户绑定车牌，1.强制引导用户绑定车牌)
//桩 类型 '0：交流电(ac)，1：直流电(dc)，2：交直流',
@property (nonatomic, copy) NSString *type;
//总单价
@property (nonatomic, assign) float totalFee;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSArray *carNumberList;

//企业充电判断（0.不是企业充电，1.是企业充电[只展示企业充电选项]，2.是企业充电[在基础充电类型基础上加上企业充电选项]）
@property (nonatomic, assign) int organizationStatus;
@property (nonatomic, copy) NSString *organizationChargeInfo;//机构充电描述

@end

NS_ASSUME_NONNULL_END
