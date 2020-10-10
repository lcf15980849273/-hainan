//
//  BEnergyApiCloudStorage.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyStubGroupCityModel.h"

@interface BEnergyApiCloudStorage : NSObject

@property (strong, nonatomic) BEnergyStubGroupCityModel *selectedCity;
@property (strong, nonatomic) NSArray *stubGroupCityList;
///单例化
+ (instancetype)sharedInstance;
/**
 根据城市名称返回城市桩群信息
 
 @param cityName 城市名称-地级市
 @return BEnergyStubGroupCityModel
 */
- (BEnergyStubGroupCityModel *)cityWithName:(NSString *)cityName;

@end
