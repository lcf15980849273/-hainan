//
//  BEnergyStubGroupModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/20.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"
@class auxiliaryList;
@interface BEnergyStubGroupModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *id;     ///桩群id
@property (nonatomic, copy) NSString *name;   ///桩名
@property (nonatomic, copy) NSString *miniImgUrl;///缩略图
@property (nonatomic, assign) int stubAcCnt;            ///交流桩总数量
@property (nonatomic, assign) int stubAcUseCnt;         ///交流装使用中数量
@property (nonatomic, assign) int stubAcIdleCnt;        ///交流桩空闲数量(慢)
@property (nonatomic, assign) int stubAcErrorCnt;       ///交流桩故障数量
@property (nonatomic, assign) int stubDcCnt;            ///直流桩总数量
@property (nonatomic, assign) int stubDcUseCnt;         ///直流桩使用中数量
@property (nonatomic, assign) int stubDcIdleCnt;        ///直流桩空闲数量(快)
@property (nonatomic, assign) int stubDcErrorCnt;       ///直流桩故障数量
@property (nonatomic, assign) int stubBuildingCnt;      ///待建桩数量
@property (nonatomic, copy) NSString *serviceTime;    ///服务提供时间（文本描述）
@property (nonatomic, copy) NSString *address;        ///桩群地址
@property (nonatomic, assign) double gisBd09Lat;        ///百度09坐标系
@property (nonatomic, assign) double gisBd09Lng;        ///百度09坐标系
@property (nonatomic, assign) double gisGcj02Lat;       ///火星坐标系
@property (nonatomic, assign) double gisGcj02Lng;       ///火星坐标系
@property (nonatomic, assign) int isBuilded;            ///是否建设完成。0：未完成，1：已完成
@property (nonatomic, assign) int distance;             ///距离
@property (nonatomic, assign) float totalFee;           ///总费用。2位小数
@property (nonatomic, assign) int chargeMode;           ///充电方式，0-快充(直流)，1-慢充(交流)
@property (nonatomic, assign) CGSize nameSize;
@property (nonatomic, copy) NSString *parkingFeeInfo;    //停车费内容
@property (nonatomic, assign) BOOL isOpen;               //是否对外开放
@property (nonatomic, strong) NSArray<auxiliaryList *> *auxiliaryList;
@property (nonatomic, copy) NSString *city;

@end
