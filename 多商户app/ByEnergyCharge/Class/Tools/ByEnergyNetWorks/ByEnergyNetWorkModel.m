//
//  ByEnergyNetWorkModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyNetWorkModel.h"

@implementation ByEnergyNetWorkModel

- (instancetype) init {
    if (self = [super init]) {
        _isEncryption = YES;
        _isHidenHUD = NO;
        _isShowError = YES;
        _isHttpsRequest = NO;
        _cachePolicy = MCachePolicyIgnoreCache;
        _isRefresh = YES;
        _isReadCash = NO;
        _cashTime = 0;
        _requestStytle = MRequestMethodGET;
        _loadingString = @"海控充电";
    }
    return self;
}

@end
