//
//  BEnergyApiCloudStorage.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyApiCloudStorage.h"

static BEnergyApiCloudStorage *sharedInstance = nil;
#define StubGroupCityListKey @"stubGroupCityList"

@implementation BEnergyApiCloudStorage

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
    if ([[NSUserDefaults standardUserDefaults] objectForKey:StubGroupCityListKey]!=nil) {
        @try {
            NSArray *stubGroupCityList = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:StubGroupCityListKey]];
            self.stubGroupCityList = stubGroupCityList;
        }
        @catch (NSException *exception) {
            NSLog(@"exception:%@",[exception description]);
        }
    }
}

- (void)setStubGroupCityList:(NSArray *)stubGroupCityList {
    _stubGroupCityList = stubGroupCityList;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:stubGroupCityList];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:StubGroupCityListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BEnergyStubGroupCityModel *)cityWithName:(NSString *)cityName {
    BEnergyStubGroupCityModel *city = nil;
    if (byEnergyIsValidStr(cityName)) {
        for (BEnergyStubGroupCityModel *model in _stubGroupCityList) {
            if ([model.name isEqualToString:cityName]) {
                city = model;
                break;
            }
        }
    }
    
    return city;
}

@end
