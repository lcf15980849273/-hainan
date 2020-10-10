//
//  BEnergyUserCashViewModel.m
//  StarCharge
//
//  Created by newyea on 2020/8/22.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyUserCashViewModel.h"
#import "BEnergyCashInfoModel.h"

@implementation BEnergyUserCashViewModel

- (RACCommand *)userCashInfoCommand {
    ByEnergyWeakSekf
    if (!_userCashInfoCommand) {
        _userCashInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr([(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] account]) forKey:@"userAccount"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiUserCashInfoUrl) parameters:params.api responseClass:Nil netWorksModel:self.userCashInfoCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                if (!byEnergyIsNilOrNull(x)) {
                    NSError *err = nil;
                    NSDictionary *dic = (NSDictionary *)x;
                    BEnergyCashInfoModel *model = [[BEnergyCashInfoModel alloc] initWithDictionary:dic error:&err];
                    NSMutableArray *valueArray = [[NSMutableArray alloc] init];
                    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
                    NSArray *cashReasonArray = [model.cashReason.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
                        NSError *err = nil;
                       Cashreason *model = [[Cashreason alloc] initWithDictionary:value error:&err];
                        [valueArray addObject:model.value];
                        [indexArray addObject:model.id];
                        return model;
                    }].toArray;
                    model.cashReason = @[valueArray,indexArray];
                    NSArray *cashTipsArray = [model.cashTips.info.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
                        NSError *err = nil;
                        return [[Info alloc] initWithDictionary:value error:&err];
                    }].toArray;
                    model.cashTips.info = cashTipsArray;
                    self.result = YES;
                    self.value = model;
                }
                
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _userCashInfoCommand;
}

- (RACCommand *)userCashApplyCommand {
    ByEnergyWeakSekf
    if (!_userCashApplyCommand) {
        _userCashApplyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr([(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] account]) forKey:@"userAccount"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiUserCashApplyUrl) parameters:params.api responseClass:Nil netWorksModel:self.userCashApplyCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                if (!byEnergyIsNilOrNull(x)) {
                    self.userCashApplyCommand.result = YES;
                    self.userCashApplyCommand.value = x;
                }
                
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.userCashApplyCommand.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _userCashApplyCommand;
}

@end
