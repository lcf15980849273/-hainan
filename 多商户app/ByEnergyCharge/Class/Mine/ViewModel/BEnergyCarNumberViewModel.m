//
//  BEnergyCarNumberViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyCarNumberViewModel.h"
#import "BEnergyCarListModel.h"
@implementation BEnergyCarNumberViewModel

/**
 获得车牌信息
 */
- (RACCommand *)hnFetchCarNumberCommand {
    ByEnergyWeakSekf
    if (!_hnFetchCarNumberCommand) {
        _hnFetchCarNumberCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnFetchCarNumberCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiGetCarNumberNewUrl) parameters:params.api responseClass:[BEnergyCarListModel class] netWorksModel:self.hnFetchCarNumberCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                [HUDManager hidenHud];
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    NSArray *array = x;
                    [self.datasArray removeAllObjects];
                    [self.datasArray addObjectsFromArray:array];
                    self.value = x;
                }
                
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
                [HUDManager hidenHud];
            }];
            return requestSignal;
        }];
    }
    return _hnFetchCarNumberCommand;
}

/**
 添加车牌信息
 */
- (RACCommand *)hnAddCarNumberCommand {
    ByEnergyWeakSekf
    if (!_hnAddCarNumberCommand) {
        _hnAddCarNumberCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiAddCarNumberUrl) parameters:params.api responseClass:[NSDictionary class] netWorksModel:self.hnAddCarNumberCommand.netWorksModel];
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
    return _hnAddCarNumberCommand;
}

/**
 删除车牌信息
 */
- (RACCommand *)hnDelCarNumberCommand {
    ByEnergyWeakSekf
    if (!_hnDelCarNumberCommand) {
        _hnDelCarNumberCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr(self.carNumber) forKey:@"carNumber"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiDelCarNumberUrl) parameters:params.api responseClass:[NSDictionary class] netWorksModel:self.hnDelCarNumberCommand.netWorksModel];
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
    return _hnDelCarNumberCommand;
}

/**
 编辑车牌信息
 */
- (RACCommand *)hnUpdateCarNumberCommand {
    ByEnergyWeakSekf
    if (!_hnUpdateCarNumberCommand) {
        _hnUpdateCarNumberCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
           
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiUpdateCarNumberUrl) parameters:params.api responseClass:[NSDictionary class] netWorksModel:self.hnUpdateCarNumberCommand.netWorksModel];
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
    return _hnUpdateCarNumberCommand;
}

@end
