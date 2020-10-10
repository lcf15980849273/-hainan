
//
//  ByEnergyUserLoaction.m
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/24.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyUserLoaction.h"
#import <AMapSearchKit/AMapSearchKit.h>


@interface ByEnergyUserLoaction ()<CLLocationManagerDelegate,AMapSearchDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;//位置管理器
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, assign) BOOL isSearchFromDragging;

@end

@implementation ByEnergyUserLoaction

SINGLETON_FOR_CLASS(ByEnergyUserLoaction)

- (instancetype) init {
    if (self == [super init]) {
        kWeakSelf(self);
        [self search];
        [self setupLocationManager];
        ByEnergyReceivedNotification(UIApplicationDidBecomeActiveNotification, ^{
            [weakself willStartLocation];
        }());
    }
    return self;
}

- (AMapSearchAPI *)search {
    if (_search == nil) {
        _search =[[AMapSearchAPI alloc] init];
        _search.delegate=self;
    }
    return _search;
}

- (void)setupLocationManager {
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

#pragma mark - CLLocationManagerDelegate
- (void)willStartLocation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(willStartLocation) object:nil];
    NSLog(@"authorizationStatus:%d",[CLLocationManager authorizationStatus]);
    //地图开启定位获取用户位置信息
    if ([CLLocationManager locationServicesEnabled]==NO
        || [CLLocationManager authorizationStatus]<3){
        if (NLSystemVersionGreaterOrEqualThan(8)) {
            [_locationManager requestWhenInUseAuthorization];
        }
        else {
            [self startLocation];
        }
    }
    else {
        [self startLocation];
    }
}

- (void)startLocation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startLocation) object:nil];
    [_locationManager stopUpdatingLocation];
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"status:%d",status);
    if (status>2) {
        [self startLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if ([locations count]==0) {
        return;
    }
    CLLocation *newLocation = [locations lastObject];
    NSTimeInterval howRecent = [newLocation.timestamp timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        @try {
            if ([ByEnergyUserLoaction isValidLocationWithLat:newLocation.coordinate.latitude lng:newLocation.coordinate.longitude]) {
                [[BEnergyAppStorage sharedInstance] byEnergyUpdateUserLocation:newLocation];
                [self searchReGeocodeWithCoordinate:newLocation];
                // 强制 成 简体中文
                [[NSUserDefaults
                  standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",
                                                   nil] forKey:@"AppleLanguages"];
                [self reverseGeocoder:newLocation];
            }
        }
        @catch (NSException *exception) {
            
        }
        [manager stopUpdatingLocation];
    }
}

/**
 地理反编码
 */
- (void)reverseGeocoder:(CLLocation *)currentLocation{
    if (_isSearchFromDragging) {
        return;
    }
    //系统语言为英文时返回中文编码
    NSMutableArray *defaultLanguages = [USER_DEFAULT objectForKey:@"AppleLanguages"];
    [USER_DEFAULT setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error && [placemarks count] > 0) {
            if ([placemarks firstObject]!=[NSNull null]&&[[placemarks firstObject] isKindOfClass:[CLPlacemark class]]) {
                CLPlacemark *mark = (CLPlacemark *)[placemarks firstObject];
                NSDictionary *dict =[mark addressDictionary];
                NSString *cityStr = [dict objectForKey:@"City"];
                if (byEnergyIsValidStr(cityStr)) {
                    NSString *validCityName = [StringUtils filterString:@"市" fromString:cityStr];
                    BOOL needRefreshFocus = NO;
                    NSString *lastCityName = [BEnergyAppStorage sharedInstance].userCityName;
                    if (byEnergyIsValidStr(validCityName)) {
                        if ((byEnergyIsValidStr(lastCityName)==NO)    //原来没有，现在有
                            || (byEnergyIsValidStr(lastCityName) && [lastCityName isEqualToString:validCityName]==NO) //原来有，现在有，且不同
                            ) {
                            needRefreshFocus = YES;
                        }
                        [[BEnergyAppStorage sharedInstance] setUserCityName:validCityName];
                    }
                    if (needRefreshFocus) {
                        ByEnergySendNotification(@"refreshFocusList", nil);
                    }
                }
                //还原系统语言
                [USER_DEFAULT setObject:defaultLanguages forKey:@"AppleLanguages"];
            }
        }
    }];
    
}


- (void)searchReGeocodeWithCoordinate:(CLLocation *)location
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    regeo.requireExtension            = YES;
    [_search AMapReGoecodeSearch:regeo];
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"逆地理编码失败！");
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil && _isSearchFromDragging == NO)
    {
        AMapDistrictSearchRequest *dist = [[AMapDistrictSearchRequest alloc] init];
        dist.keywords = response.regeocode.addressComponent.city;
        dist.requireExtension = YES;
        [_search AMapDistrictSearch:dist];
    }
    
}

- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response
{
    
    if (response != nil)
    {
        NSString *cityCode = [[response.districts objectAtIndex:0] adcode];
        if (byEnergyIsValidStr(cityCode)) {
            _isSearchFromDragging = YES;
        }
        [[BEnergyAppStorage sharedInstance] setUserCityId:cityCode];
        ByEnergySendNotification(ByEnergySearchIdleStub, nil);
    }
    
    //解析response获取行政区划，具体解析见 Demo
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSString *errorString;
    switch([error code]) {
        case kCLErrorLocationUnknown:
            errorString = @"定位数据不可用，请检查网络";
            break;
        default:
            errorString = @"";
            break;
    }
    if (byEnergyIsValidStr(errorString)) {
        [HUDManager showTextHud:errorString];
    }
}

+ (BOOL)isValidLocationWithLat:(double)lat lng:(double)lng {
    BOOL isValid = YES;
    if (lat>90 || lat<-90 || lng>180 || lng<-180 || (lat==0 && lng==0))
        isValid = NO;
    return isValid;
}

@end
