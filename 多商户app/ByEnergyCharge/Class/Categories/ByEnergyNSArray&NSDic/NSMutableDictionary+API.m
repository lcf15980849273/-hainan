//
//  NSMutableDictionary+API.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "NSMutableDictionary+API.h"
#import "SystemUtils.h"
#import "ApplicationUtil.h"
#import "NSDate+date.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (API)
- (NSMutableDictionary *)api {
    if (byEnergyIsValidStr([(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] id])) {
        [self setObject:[(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] id] forKey:@"userId"];
    }
    
    if (byEnergyIsValidStr([(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] id])) {
        [self setObject:[(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] id] forKey:@"accountId"];
    }
    
    if (byEnergyIsValidStr([[[BEnergySCUserStorage sharedInstance] userInfo] account])) {
        [self setObject:[(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] account] forKey:@"mobile"];
    }
    
    if (byEnergyIsValidStr([(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] verify])) {
        [self setObject:[(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] verify] forKey:@"verify"];
    }
    if (byEnergyIsValidStr([SystemUtils getDeviceId])) {
        [self setObject:[SystemUtils getDeviceId] forKey:@"deviceId"];
    }
    if (byEnergyIsValidStr([USER_DEFAULT objectForKey:@"token"])) {
        [self setObject:[USER_DEFAULT objectForKey:@"token"] forKey:@"token"];
    }
    [self setObject:[NSDate getNowTimeTimestamp] forKey:@"timestamp"];
    [self setObject:@"1" forKey:@"newyeaAppType"];
    [self setObject:[ApplicationUtil nowAppVersion] forKey:@"newyeaAppVersion"];
//    [self setObject:@"6Li280Oxr939x1l837" forKey:@"appkey"];
    [self setObject:@"wxcd8b4156f432f8ea" forKey:@"appid"];
    return self;
}

#pragma mark - ************* 通过运行时动态添加关联 ******************

- (NSInteger)pageIndex {
    NSInteger index = [objc_getAssociatedObject(self, _cmd) integerValue];
    return index;
}

- (void)setPageIndex:(NSInteger)pageIndex {
    SEL key = @selector(pageIndex);
    [self setObject:NSStringFormat(@"%zd",pageIndex) forKey:@"pageIndex"];
    [self setObject:NSStringFormat(@"%d",PageSize) forKey:@"pageSize"];
    objc_setAssociatedObject(self, key, [NSNumber numberWithInteger:pageIndex], OBJC_ASSOCIATION_RETAIN);
}

//新加的
- (NSInteger)page {
    NSInteger index = [objc_getAssociatedObject(self, _cmd) integerValue];
    return index;
}

- (void)setPage:(NSInteger)page {
    SEL key = @selector(page);
    [self setObject:NSStringFormat(@"%zd",page) forKey:@"page"];
    [self setObject:NSStringFormat(@"%d",PageSize) forKey:@"pagecount"];
    objc_setAssociatedObject(self, key, [NSNumber numberWithInteger:page], OBJC_ASSOCIATION_RETAIN);
}


@end
