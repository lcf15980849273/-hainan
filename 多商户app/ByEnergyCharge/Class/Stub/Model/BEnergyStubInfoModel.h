//
//  BEnergyStubInfoModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyStubInfoModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *id; //桩编号
@property (nonatomic, copy) NSString *name; //名称
@property (nonatomic, copy) NSString *status; //状态:00：空闲，01：充电中，02:故障，03：车位占用，04：维护中，05：离线，                   06：在建中，07：升级中，09：储能中，99：删除
@property (nonatomic, copy) NSString *parkingNo; //车位编号
@property (nonatomic, assign) int parkingStatus; //车位状态:0无数据1空闲2使用
@property (nonatomic, assign) int existsGun; //是否带充电枪0：不带枪 1：带枪
@property (nonatomic, assign) int type; //电源类型：0：交流电 1：直流电 2：交直流
@property (nonatomic, assign) double ratedVoltage; //额定电压
@property (nonatomic, assign) double ratedCurrent; //额定电流
@property (nonatomic, assign) double kw; //额定功率
@property (nonatomic, copy) NSString *stubGroupId; //所属桩群id
@property (nonatomic, assign) int voltageUpperLimit; //电压上限
@property (nonatomic, assign) int voltageLowerLimit; //电压下限
@property (nonatomic, assign) int voltageAuxiliary; //辅助电压
@property (nonatomic, assign) int equipmentType;//充电设备类型：0：充电桩 1：储能车
@property (nonatomic, assign) int soc; //如果是储能车，则显示储能车电池的soc
@end

NS_ASSUME_NONNULL_END
