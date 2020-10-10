//
//  BEnergyStubGroupCityModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

@interface BEnergyStubGroupCityModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *city;       ///城市id
@property (nonatomic, copy) NSString *name;       ///城市名称
@property (nonatomic) int stubCnt;                  ///桩的总数量
@property (nonatomic) int stubBuildedCnt;           ///运营中桩的数量
@property (nonatomic) int stubBuildingCnt;          ///在建中桩的数量
@property (nonatomic) int stubGroupCnt;             ///运营中桩群的数量
@property (nonatomic) int stubIdleCnt;              ///空闲中桩的数量
@property (nonatomic) int stubErrorCnt;             ///故障中桩的数量
@property (nonatomic) int stubUseCnt;               ///使用中桩的数量（升级、车位占用等都算使用中）
@property (nonatomic) double gisBd09Lat;            ///百度09坐标系
@property (nonatomic) double gisBd09Lng;            ///百度09坐标系
@property (nonatomic) double gisGcj02Lat;           ///火星坐标系
@property (nonatomic) double gisGcj02Lng;           ///火星坐标系
@end
