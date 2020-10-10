//
//  BEnergyAppStorage.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergySystemInfoModel.h"

@interface BEnergyAppStorage : NSObject<UIActionSheetDelegate>

@property (strong, nonatomic) BEnergySystemInfoModel *systemInfo;          ///系统信息
@property (strong, nonatomic) NSString *userCityName;               ///当前用户所在城市名称
@property (strong, nonatomic) NSString *userCityId;                 ///当前用户所在城市id
@property (nonatomic, strong) NSMutableDictionary *locationTagInfo; ///位置信息
@property (nonatomic, copy) NSString *chargeOrderId;              ///当前充电订单id
@property (nonatomic, copy) NSString *addressText;                  ///导航地址
@property (nonatomic,assign) CLLocationCoordinate2D      touchMapCoordinate;///导航坐标
@property (nonatomic, assign) BOOL isNoNetContent;
@property(nonatomic, strong) RACSubject *reachableSubject;
@property (nonatomic, assign) BOOL hasShowNoNetHint; ///是否已经显示无网络提示
///单例化
+ (instancetype)sharedInstance;
///返回city
- (OptionModel *)cityWithName:(NSString *)cityName;
///更新用户位置信息
- (void)byEnergyUpdateUserLocation:(CLLocation *)newLocation;

//导航
- (void)byEnergyOpenNaviWithLat:(double)destinationLat
                      destinationLng:(double)destinationLng
                     destinationName:(NSString *)destinationName
                     destinationView:(UIView *)destinationView;

@end
