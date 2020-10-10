
//
//  BEnergyAmountDetailViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyAmountDetailViewModel.h"
#import "BEnergyUserAmountDetailModel.h"
#import "BEnergyUserWalletBalanceModel.h"

@implementation BEnergyAmountDetailViewModel

- (RACCommand *)hnUserAmountDetailCommand {
    ByEnergyWeakSekf
    if (!_hnUserAmountDetailCommand) {
        _hnUserAmountDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnUserAmountDetailCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.pageIndex = self.page.PageIndex;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiUserAmountDetailUrl) parameters:params.api responseClass:[BEnergyUserAmountDetailModel class] netWorksModel:self.hnUserAmountDetailCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    NSArray *array = x;
                    if ([array count] > 0) {
                        [self.datasArray addObjectsFromArray:array];
                    }
                    self.value = self.datasArray;
                    self.page.SizeCount = [array count];
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.page.PageIndex --;
                self.result = NO;
            }];
            
            return requestSignal;
        }];
    }
    return _hnUserAmountDetailCommand;
}

- (RACCommand *)hnUserWalletBalanceCommand {
    ByEnergyWeakSekf
    if (!_hnUserWalletBalanceCommand) {
        _hnUserWalletBalanceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
//            self.hnUserWalletBalanceCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr([(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] account]) forKey:@"userAccount"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiUserWalletBalanceUrl) parameters:params.api responseClass:[BEnergyUserWalletBalanceModel class] netWorksModel:self.hnUserWalletBalanceCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
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
    return _hnUserWalletBalanceCommand;
}

@end
