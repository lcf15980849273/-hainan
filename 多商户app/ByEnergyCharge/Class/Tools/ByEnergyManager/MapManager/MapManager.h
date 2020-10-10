//
//  MapManager.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/5.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyBasicMapAnnotation.h"
@class BEnergyStubGroupCityModel;
typedef void(^MapBlock)();
@interface MapManager : NSObject
@property (nonatomic,weak)UIViewController *controller;
//地图对象
@property(nonatomic,strong)MAMapView *mapView;
//当前定位
@property(nonatomic,strong)CLLocation *currentLocation;
// 定位当前位置
@property (nonatomic, strong) UIButton *locationBtn;
// 是否正在定位
@property (nonatomic, assign) BOOL isLocated;
// 坐标数据源
@property (nonatomic, strong) NSMutableArray *datasArray;
// 显示导航
@property (nonatomic, strong) RACSubject *showSubject;
// 隐藏导航
@property (nonatomic, strong) RACSubject *hideSubject;
// 选择城市
@property (nonatomic, strong) RACSubject *changeCitySubject;
// 当前选中城市
@property (nonatomic, strong) BEnergyStubGroupCityModel *selectedCity;
// 是否显示自定义中心点大头针，默认不显示
@property (nonatomic, assign) BOOL showCenterAnnotation;

//初始化单例管理员对象
+(instancetype)sharedManager;
//初始化地图
-(void)initMapView;
//带回调的地图初始化方法
-(void)initMapViewWithBlock:(MapBlock)block;
//添加标注
-(void)addAnomationWithArray:(NSMutableArray *)array;
- (void)locationToUser;
@end
