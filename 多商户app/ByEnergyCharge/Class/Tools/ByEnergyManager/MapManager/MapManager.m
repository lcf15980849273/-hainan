
//
//  MapManager.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/5.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "MapManager.h"
#import "BEnergyStubGroupModel.h"
#import "BEnergyLocationAnnotationView.h"
#import "BEnergyAnnotationModel.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "BEnergyMapCenterAnnotationView.h"
#import "BEnergyStubGroupCityModel.h"
#import "SCPermission.h"
#import "BEnergyLocationView.h"

@interface MapManager()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic,strong)NSMutableArray *searchResultArr;
@property (nonatomic,strong) NSMutableArray *stubGroupList;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, assign) BOOL isSearchFromDragging;
@property (nonatomic, assign) BOOL hasLoad;
@property (nonatomic,strong) BEnergyMapCenterAnnotationView *mapCenterAnnotationView;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@end
@implementation MapManager
#pragma mark --创建一个单例类对象
+ (instancetype)sharedManager {
    static MapManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //初始化单例对象
        instance = [[MapManager alloc]init];
    });
    return instance;
}
#pragma mark --初始化地图对象
- (void)initMapView {
    [SCPermission authorizedWithType:SCPermissionType_Location WithResult:^(BOOL granted) {}];
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    ///把地图添加至view
    [self.controller.view addSubview:_mapView];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //设置标尺是否显示
    _mapView.showsScale = NO;
    //设置隐藏罗盘
    _mapView.showsCompass = NO;
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    //设置地图缩放比例，即显示区域
    [_mapView setZoomLevel:13.1 animated:YES];
    _mapView.delegate = self;
    //设置定位精度
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    
    //设置定位距离
    _mapView.distanceFilter = 5.0f;
    //把中心点设成自己的坐标
    _mapView.centerCoordinate = self.currentLocation.coordinate;
    if (self.showCenterAnnotation) {
        [self initCenterView];
    }
    [self setViewLayout];
    [self bindViewModel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.datasArray.count > 0) {
            [self addAnomationWithArray:self.datasArray];
        }
    });
    [self search];
}

#pragma mark --带block的地图初始化方法
-(void)initMapViewWithBlock:(MapBlock)block{
    [SCPermission authorizedWithType:SCPermissionType_Location WithResult:^(BOOL granted) {
        
    }];
    ///初始化地图
    _mapView = [[MAMapView alloc] init];
    ///把地图添加至view
    [self.controller.view addSubview:_mapView];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //设置标尺是否显示
    _mapView.showsScale = NO;
    //设置隐藏罗盘
    _mapView.showsCompass = NO;
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    //设置地图缩放比例，即显示区域
    [_mapView setZoomLevel:13.1 animated:YES];
    _mapView.delegate = self;
    //设置定位精度
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    
    //设置定位距离
    _mapView.distanceFilter = 5.0f;
    if (self.showCenterAnnotation) {
        [self initCenterView];
    }
    [self setViewLayout];
    [self bindViewModel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.datasArray.count > 0) {
            [self addAnomationWithArray:self.datasArray];
        }
        block();
    });
    [self search];
}

// 自定义当定位没有数据时的提示框
- (void)initCenterView {
    [self.mapView addSubview:self.mapCenterAnnotationView];
}

- (void)setViewLayout {
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.mapCenterAnnotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mapView.mas_top).mas_offset(200);
        make.centerX.equalTo(self.mapView.mas_centerX).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(260, 45));
    }];
}

- (void)bindViewModel {
    
}

- (void)locationToUser {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        CLLocation* userLocation = self.mapView.userLocation.location;
        if (userLocation) {
            float zoomLevel = 0.09;
            MACoordinateRegion region = MACoordinateRegionMake(userLocation.coordinate, MACoordinateSpanMake(zoomLevel, zoomLevel));
            [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
            [[BEnergyAppStorage sharedInstance] byEnergyUpdateUserLocation:userLocation];
        }
        [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    });
}


#pragma mark --添加标注
-(void)addAnomationWithArray:(NSMutableArray *)array{
    self.hasLoad = YES;
    NSArray* oldArray = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:oldArray];
    if (self.stubGroupList.count > 0) {
        [self.stubGroupList removeAllObjects];
    }
    [self.stubGroupList addObjectsFromArray:array];
    for (int i = 0; i < array.count; i++) {
        double lat = 0.0;
        double lng = 0.0;
        int totalCnt = 0;
        if ([array[i] isKindOfClass:[BEnergyStubGroupCityModel class]]) {
            BEnergyStubGroupCityModel* stubGroup = array[i];
            lat = stubGroup.gisGcj02Lat;
            lng = stubGroup.gisGcj02Lng;
            totalCnt = stubGroup.stubCnt;
            
        }
        else if ([array[i] isKindOfClass:[BEnergyStubGroupModel class]]) {
            BEnergyStubGroupModel* stubGroup = array[i];
            lat = stubGroup.gisGcj02Lat;
            lng = stubGroup.gisGcj02Lng;
            totalCnt = stubGroup.stubAcCnt + stubGroup.stubDcCnt;
        }
        if ([self isValidLocationWithLat:lat lng:lng]) {
            BEnergyBasicMapAnnotation *annotation= [[BEnergyBasicMapAnnotation alloc] initWithLatitude:lat andLongitude:lng];
            BEnergyAnnotationModel *model = [[BEnergyAnnotationModel alloc] init];
            model.title = NSStringFormat(@"%d",totalCnt);
            model.tag = i;
            annotation.model = model;
            [self.mapView addAnnotation:annotation];
        }
    }
    if (!byEnergyIsNilOrNull(self.selectedCity.name)) {
        if (![self.selectedCity.name isEqualToString:[BEnergyAppStorage sharedInstance].userCityName]) {
            CLLocationCoordinate2D centerPoint;
            if ([self.selectedCity.name isEqualToString:@"全国"]) { //如果是全国则用太原的经纬度，可以展示全国的地图
                centerPoint = CLLocationCoordinate2DMake(37.877200000000002, 112.557);
            }else {
                centerPoint = CLLocationCoordinate2DMake(self.selectedCity.gisGcj02Lat, self.selectedCity.gisGcj02Lng);
            }
            CLLocation *location = [[CLLocation alloc] initWithLatitude:centerPoint.latitude longitude:centerPoint.longitude];
            [self.mapView setRegion:MACoordinateRegionMakeWithDistance(location.coordinate, 10000, 10000) animated:YES];
            self.mapView.zoomLevel = [self.selectedCity.name isEqualToString:@"全国"] ? 3 : 7;
        }else {
            self.mapView.centerCoordinate = self.currentLocation.coordinate;
        }
    }
}


- (BOOL)isValidLocationWithLat:(double)lat lng:(double)lng {
    BOOL isValid = YES;
    if (lat>90 || lat<-90 || lng>180 || lng<-180 || (lat==0 && lng==0))
        isValid = NO;
    return isValid;
}

#pragma mark 定位更新回调
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if(updatingLocation) {
        // 强制 成 简体中文
        [[NSUserDefaults
          standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",
                                           nil] forKey:@"AppleLanguages"];
        self.currentLocation = [userLocation.location copy];
        [[BEnergyAppStorage sharedInstance] byEnergyUpdateUserLocation:userLocation.location];
        [self centerAnnotationAnimimate];
        //        [self searchReGeocodeWithCoordinate:self.currentLocation];
        //        [self reverseGeocoder];
    }
}

/**
 地理反编码
 */
- (void)reverseGeocoder {
    
    if (_isSearchFromDragging) {
        return;
    }
    kWeakSelf(self);
    //系统语言为英文时返回中文编码
    NSMutableArray *defaultLanguages = [USER_DEFAULT objectForKey:@"AppleLanguages"];
    [USER_DEFAULT setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];
    _isSearchFromDragging = YES;
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:weakself.currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error && [placemarks count] > 0) {
            if ([placemarks firstObject]!=[NSNull null]&&[[placemarks firstObject] isKindOfClass:[CLPlacemark class]]) {
                CLPlacemark *mark = (CLPlacemark *)[placemarks firstObject];
                NSDictionary *dict =[mark addressDictionary];
                NSString *cityStr = [dict objectForKey:@"City"];
                if (byEnergyIsValidStr(cityStr)) {
                    NSString *validCityName = [StringUtils filterString:@"市" fromString:cityStr];
                    [weakself updateLocationCityInfoWithCityName:validCityName];
                }
                //还原系统语言
                [USER_DEFAULT setObject:defaultLanguages forKey:@"AppleLanguages"];
            }
        }
        weakself.isSearchFromDragging = NO;
    }];
    
}

//更新城市信息
- (void)updateLocationCityInfoWithCityName:(NSString *)cityName {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateLocationCityInfoWithCityName:) object:[BEnergyAppStorage sharedInstance].userCityName];
    if ([BEnergyAppStorage sharedInstance].systemInfo) {
        NSString *newCity = cityName;
        if (![newCity hasSuffix:@"市"]) {
            newCity = [newCity stringByAppendingFormat:@"市"];
        }
        if ([BEnergyAppStorage sharedInstance].systemInfo.cityList.count >0) {
            NSArray *array = [BEnergyAppStorage sharedInstance].systemInfo.cityList;
            for (OptionModel *model in array) {
                if ([model.name isEqualToString:newCity]) {
                    [[BEnergyAppStorage sharedInstance] setUserCityId:model.code];
                }
            }
        }
    }
    BOOL needRefreshFocus = NO;
    NSString *lastCityName = [BEnergyAppStorage sharedInstance].userCityName;
    if (byEnergyIsValidStr(cityName)) {
        if ((byEnergyIsValidStr(lastCityName)==NO)    //原来没有，现在有
            || (byEnergyIsValidStr(lastCityName) && [lastCityName isEqualToString:cityName] == NO) //原来有，现在有，且不同
            ) {
            needRefreshFocus = YES;
        }
        [[BEnergyAppStorage sharedInstance] setUserCityName:cityName];
    }
    if (needRefreshFocus) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFocusList" object:nil];
    }
}

//坐标定位失败
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"===定位错误%@",error);
    NSString *errorString;
    switch([error code]) {
        case kCLErrorDenied:
            errorString = @"定位服务未开启，请到设置中打开";
            break;
        case kCLErrorLocationUnknown:
            errorString = @"定位数据不可用，请检查网络";
            break;
        default:
            errorString = @"定位过程中发生未知错误，请重试";
            break;
    }
}

- (void)setCurrentLocation:(CLLocation *)currentLocation {
    
    if (!_currentLocation) {
        _currentLocation = currentLocation;
        _mapView.centerCoordinate = currentLocation.coordinate;
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    // 自定义坐标
    if ([annotation isKindOfClass:[MAUserLocation class]]) { //绘制自定义小蓝点
        
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        BEnergyLocationView *annotationView = (BEnergyLocationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[BEnergyLocationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"icon_tracking_userLocation"];
        self.userLocationAnnotationView = annotationView;
        //为了让位置点永远在图层最上面，设置选定图标。
        //高德SDK5.4.0必须在主线程选定图标，否则会导致界面进入地图加载卡死，暂时不懂为何
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView selectAnnotation:annotation animated:YES];
        });
        return annotationView;
  
    }else if ([annotation isKindOfClass:[BEnergyBasicMapAnnotation class]]){ //绘制桩群图标
        static NSString *reuseIndetifier = @"CustomAnnotationView";
        BEnergyLocationAnnotationView *annotationView = (BEnergyLocationAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (!annotationView ){
            annotationView = [BEnergyLocationAnnotationView annotationViewWithMapView:mapView];
        }
        BEnergyBasicMapAnnotation *annotation1 = (BEnergyBasicMapAnnotation *)annotation;
        int index = (int)annotation1.model.tag;
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        annotationView.stubGroupModel = _stubGroupList[index];
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, 10);
        return annotationView;
        
    }
    return nil;
}

#pragma mark --选中后回调的方法
//选中锚点
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if ([view.annotation isKindOfClass:[BEnergyBasicMapAnnotation class]]) {
        BEnergyBasicMapAnnotation *anno = (BEnergyBasicMapAnnotation *)view.annotation;
        [self.showSubject sendNext:@(anno.model.tag)];
    }else {
        [self.showSubject sendNext:[NSNumber numberWithInt:-1]];
    }
}

//取消选中锚点
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    
   
    if ([view.annotation isKindOfClass:[BEnergyBasicMapAnnotation class]]) {
        BEnergyBasicMapAnnotation *anno = (BEnergyBasicMapAnnotation *)view.annotation;
        [self.hideSubject sendNext:@(anno.model.tag)];
    }else {
        [self.hideSubject sendNext:[NSNumber numberWithInt:-1]];
    }
}

//区域改变
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
}

//区域改变完成
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self centerAnnotationAnimimate];
}

- (void)searchReGeocodeWithCoordinate:(CLLocation *)location {
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    regeo.requireExtension = YES;
    [_search AMapReGoecodeSearch:regeo];
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"逆地理编码失败！");
}

//逆地理编码回调
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil && _isSearchFromDragging == NO) {
        _isSearchFromDragging = YES;
        AMapDistrictSearchRequest *dist = [[AMapDistrictSearchRequest alloc] init];
        dist.keywords = response.regeocode.addressComponent.city;
        dist.requireExtension = YES;
        [_search AMapDistrictSearch:dist];
    }
}

- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response {
    if (response != nil) {
        [[BEnergyAppStorage sharedInstance] setUserCityId:[[response.districts objectAtIndex:0] adcode]];
        ByEnergySendNotification(ByEnergySearchIdleStub, nil);
    }
}

//移动窗口弹一下的动画
- (void)centerAnnotationAnimimate {
    self.mapCenterAnnotationView.hidden = YES;
    self.mapCenterAnnotationView.alpha = 0;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        CGPoint center = self.mapView.center;
        center.y -= 20;
        if (self.hasLoad) {
            self.mapCenterAnnotationView.hidden = self.mapView.annotations.count == 1 ? NO : YES;
        }
    }
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        self.mapCenterAnnotationView.alpha = 1;
        CGPoint center = self.mapView.center;
        center.y += 20;
    }
                     completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideMapCenterAnnotationView];
        });
    }];
}

- (void)hideMapCenterAnnotationView {
    [UIView animateWithDuration:0.45 animations:^{
        self.mapCenterAnnotationView.alpha = 0;
    } completion:^(BOOL finished) {
        self.mapCenterAnnotationView.hidden = YES;
    }];
}

#pragma mark ----- LazyLoad
- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}


- (RACSubject *)showSubject {
    if (!_showSubject) {
        _showSubject = [RACSubject subject];
    }
    return _showSubject;
}

- (RACSubject *)hideSubject {
    if (!_hideSubject) {
        _hideSubject = [RACSubject subject];
    }
    return _hideSubject;
}

- (RACSubject *)changeCitySubject {
    if (!_changeCitySubject) {
        _changeCitySubject = [RACSubject subject];
    }
    return _changeCitySubject;
}

- (NSMutableArray *)stubGroupList {
    if (!_stubGroupList) {
        _stubGroupList = [[NSMutableArray alloc] init];
    }
    return _stubGroupList;
}

- (AMapSearchAPI *)search {
    if (_search == nil) {
        _search =[[AMapSearchAPI alloc] init];
        _search.delegate=self;
    }
    return _search;
}

- (BEnergyMapCenterAnnotationView *)mapCenterAnnotationView {
    if (_mapCenterAnnotationView == nil) {
        _mapCenterAnnotationView = [[BEnergyMapCenterAnnotationView alloc] init];
        _mapCenterAnnotationView.hidden = YES;
        [_mapCenterAnnotationView.hintBtn setTitle:@"当前地区似乎还没有哦，换个城市试试？" forState:UIControlStateNormal];
        ByEnergyWeakSekf
        [[_mapCenterAnnotationView.hintBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            [self.changeCitySubject sendNext:nil];
        }];
        
    }
    return _mapCenterAnnotationView;
}

@end
