//
//  BEnergyAnnotationModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/6.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

@interface BEnergyAnnotationModel : BEnergyBaseModel

/**
 *标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *副标题
 */
@property (nonatomic, copy) NSString *subtitle;
/**
 *纬度
 */
@property (nonatomic, assign) double lat;
/**
 *经度
 */
@property (nonatomic, assign) double lng;
/**
 *充电方式，0-快充(直流)，1-慢充(交流)
 */
@property (nonatomic) int chargeMode;
/**
 *桩群地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *标记
 */
@property (nonatomic, assign) NSInteger tag;

@end
