//
//  BEnergySCUserStorage.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergySCUserStorage.h"
#import "ApplicationUtil.h"
#define SCUserAppVersionKey @"userAppVersion"
#define SCUserInfoKey       @"userinfo"

static BEnergySCUserStorage *sharedInstance = nil;
@interface BEnergySCUserStorage () {
    //用户信息
    id _userInfo;
}
@end

@implementation BEnergySCUserStorage

+ (BOOL)hasLogined {
    return [BEnergySCUserStorage sharedInstance].userInfo!=nil;
}

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
        [self setUpInitail];
    }
    return self;
}

- (void)setUpInitail {
    [self checkAppVersion];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SCUserInfoKey]!=nil) {
        @try {
            id userinfo = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:SCUserInfoKey]];
            _userInfo = userinfo;
        }
        @catch (NSException *exception) {
            NSLog(@"exception:%@",[exception description]);
        }
    }
}

//检查app版本，如果有最新的，删除老的
- (void)checkAppVersion {
    //当前app的版本号
    NSString *versionStrForNow = [ApplicationUtil nowAppVersion];
    
    //上一次本地存储的版本号
    NSString *versionStrForLast = [ApplicationUtil lastAppVersionForKey:SCUserAppVersionKey];
    
    if(versionStrForLast!=nil && [versionStrForNow isEqualToString:versionStrForLast]){
        //说明有本地版本记录，且和当前系统版本一致
    }
    else {
        //无本地版本记录或本地版本记录与当前系统版本不一致
//        [self clearUserInfo];
        [ApplicationUtil saveAppVersion:versionStrForNow forKey:SCUserAppVersionKey];
    }
}

- (void)saveUserInfo:(id)userInfo {
    if (userInfo) {
        _userInfo = userInfo;
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:SCUserInfoKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        [self clearUserInfo];
    }
}

- (id)userInfo {
    return _userInfo;
}

- (void)clearUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SCUserInfoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _userInfo = nil;
}

@end
