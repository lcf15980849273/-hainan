//
//  BEnergyAppStorage.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyAppStorage.h"
#import "SystemUtils.h"

#define SystemInfoKey @"systemInfo"
#define UserCityNameKey @"userCityName"
#define UserCityIdKey   @"userCityId"

static BEnergyAppStorage *sharedInstance = nil;

@implementation BEnergyAppStorage

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
}

+ (instancetype)sharedInstance {
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SystemInfoKey]!=nil) {
        ByEnergyWeakSekf
        @try {
            ByEnergyStrongSelf
            BEnergySystemInfoModel *systemInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:SystemInfoKey]];
            self.systemInfo = systemInfo;

            self.userCityName = [[NSUserDefaults standardUserDefaults] objectForKey:UserCityNameKey];
            self.userCityId = [[NSUserDefaults standardUserDefaults] objectForKey:UserCityIdKey];
        }
        @catch (NSException *exception) {
            NSLog(@"exception:%@",[exception description]);
        }
    }
    _locationTagInfo = [NSMutableDictionary dictionary];
}

- (RACSubject *)reachableSubject {
    if (_reachableSubject == nil) {
        _reachableSubject = [RACSubject subject];
    }
    return _reachableSubject;
}

- (void)setIsNoNetContent:(BOOL)isNoNetContent {
    _isNoNetContent = isNoNetContent;
    [self.reachableSubject sendNext:@(isNoNetContent)];
}


- (void)setSystemInfo:(BEnergySystemInfoModel *)systemInfo {
    _systemInfo = systemInfo;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:systemInfo];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:SystemInfoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUserCityName:(NSString *)userCityName {
    _userCityName = userCityName;
    [[NSUserDefaults standardUserDefaults] setObject:byEnergyClearNilStr(userCityName) forKey:UserCityNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUserCityId:(NSString *)userCityId {
    _userCityId = userCityId;
    [[NSUserDefaults standardUserDefaults] setObject:byEnergyClearNilStr(userCityId) forKey:UserCityIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (OptionModel *)cityWithName:(NSString *)cityName {
    OptionModel *city = nil;
    for (OptionModel *model in self.systemInfo.cityList) {
        if ([model.name isEqualToString:cityName]) {
            city = model;
            break;
        }
    }
    return city;
}

- (void)byEnergyUpdateUserLocation:(CLLocation *)newLocation {
    @synchronized(self) {
        [_locationTagInfo setObject:@(newLocation.coordinate.latitude) forKey:@"lat"];
        [_locationTagInfo setObject:@(newLocation.coordinate.longitude) forKey:@"lng"];
        [_locationTagInfo setObject:@(1) forKey:@"gisType"];
    }
}

- (void)byEnergyOpenNaviWithLat:(double)destinationLat
                      destinationLng:(double)destinationLng
                     destinationName:(NSString *)destinationName
                     destinationView:(UIView *)destinationView{
    _addressText = destinationName;
    _touchMapCoordinate = CLLocationCoordinate2DMake(destinationLat, destinationLng);
    [self doAcSheet:destinationView];
}

- (void)doAcSheet:(UIView *)destinationView{
    
    NSArray *appListArr = [SystemUtils checkHasOwnApp];
    NSString *sheetTitle = [NSString stringWithFormat:@"导航到 %@",_addressText];
    
    UIActionSheet *sheet;
    
    if ([appListArr count] == 2) {
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1], nil];
    }else if ([appListArr count] == 3){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2], nil];
    }else if ([appListArr count] == 4){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],appListArr[3], nil];
    }else if ([appListArr count] == 5){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0],appListArr[1],appListArr[2],appListArr[3],appListArr[4], nil];
    }else if ([appListArr count] == 1){
        sheet = [[UIActionSheet alloc] initWithTitle:sheetTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:appListArr[0], nil];
    }
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:destinationView];
}

#pragma mark -----UIActionSheetDelegate,UIAlertViewDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (buttonIndex == 0) {
        //这里调用的是苹果自带的map 并且是位置时调用
        
        CLLocationCoordinate2D endCoor = _touchMapCoordinate;
        
        // 直接调用ios自己带的apple map
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        
        
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
        toLocation.name = _addressText;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        
    }
    if ([btnTitle isEqualToString:@"高德地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"海控充电",@"com.xmnewyea.charge",_touchMapCoordinate.latitude, _touchMapCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
        
    }else if ([btnTitle isEqualToString:@"百度地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=%@&mode=driving&coord_type=gcj02",_touchMapCoordinate.latitude, _touchMapCoordinate.longitude,_addressText] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }else if ([btnTitle isEqualToString:@"腾讯地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",_touchMapCoordinate.latitude, _touchMapCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
