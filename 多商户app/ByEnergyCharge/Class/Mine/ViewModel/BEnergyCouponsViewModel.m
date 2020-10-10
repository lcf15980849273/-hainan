//
//  BEnergyCouponsViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyCouponsViewModel.h"
#import "BEnergyCouponsModel.h"

@implementation BEnergyCouponsViewModel

- (RACCommand *)hnCouponCountCommand {
    ByEnergyWeakSekf
    if (!_hnCouponCountCommand) {
        _hnCouponCountCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiCouponCountUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnCouponCountCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    self.value = x;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnCouponCountCommand;
}

- (RACCommand *)hnCouponListCommand {
    ByEnergyWeakSekf
    if (!_hnCouponListCommand) {
        _hnCouponListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnCouponListCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.pageIndex = self.page.PageIndex;
            [params setObject:[(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] account] forKey:@"userAccount"];
            [params setObject:@(self.status) forKey:@"status"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiCouponListUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnCouponListCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = YES;
                if (!byEnergyIsNilOrNull(x)) {
                    NSError *err = nil;
                    NSMutableArray *dataList = [NSClassFromString(@"BEnergyCouponsModel") arrayOfModelsFromDictionaries:[x objectForKey:@"couponList"] error:&err];
                    if ([dataList count] > 0) {
                        [self.datasArray addObjectsFromArray:dataList];
                    }
                    self.page.SizeCount = [dataList count];
                    self.value = self.datasArray;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.page.PageIndex --;
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnCouponListCommand;
}


@end
