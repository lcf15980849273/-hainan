//
//  BEnergyUserInfoViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyUserInfoViewModel.h"

@implementation BEnergyUserInfoViewModel

- (RACCommand *)userInfo {
    ByEnergyWeakSekf
    if (!_userInfo) {
        _userInfo = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.userInfo.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiGetUserInfoUrl)
                                                               parameters:params.api
                                                            responseClass:[BEnergyUserInfoModel class]
                                                            netWorksModel:self.userInfo.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                [HUDManager hidenHud];
                if (!byEnergyIsNilOrNull(x)) {
                    [[BEnergySCUserStorage sharedInstance] saveUserInfo:x];
                    self.result = YES;
                    self.value = x;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                [HUDManager hidenHud];
                self.result = NO;
            }];
            [requestSignal subscribeError:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                [HUDManager hidenHud];
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _userInfo;
}

@end
