//
//  BEnergyStubGroupViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubGroupViewModel.h"
#import "BEnergyStubGroupCityModel.h"
#import "BEnergyStubGroupModel.h"
#import "BEnergyStubGroupDetailModel.h"
#import "RACCommand+NetWorks.h"


@implementation BEnergyStubGroupViewModel

- (RACCommand *)hnStubGroupCommand {
    ByEnergyWeakSekf
    if (!_hnStubGroupCommand) {
        _hnStubGroupCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:@(self.type) forKey:@"type"];
            ByEnergyStrongSelf
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(StubGroupAggregateUrl) parameters:params.api responseClass:[BEnergyStubGroupCityModel class] netWorksModel:self.hnStubGroupCommand.netWorksModel];
            [[requestSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = YES;
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnStubGroupCommand;
}

- (RACCommand *)hnHomeStubListCommand {
    ByEnergyWeakSekf
    if (!_hnHomeStubListCommand) {
        _hnHomeStubListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
             self.hnHomeStubListCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(StubGroupListUrl) parameters:params.api responseClass:[BEnergyStubGroupModel class] netWorksModel:self.hnHomeStubListCommand.netWorksModel];
            [[requestSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                [self.datasArray removeAllObjects];
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *array = x;
                    [self.datasArray addObjectsFromArray:array];
                    self.result = YES;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnHomeStubListCommand;
}

- (RACCommand *)hnStubListCommand {
    ByEnergyWeakSekf
    if (!_hnStubListCommand) {
        _hnStubListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnStubListCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.pageIndex = self.page.PageIndex;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(StubGroupListUrl) parameters:params.api responseClass:nil netWorksModel:self.hnStubListCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *array = x;
                    NSArray *dataArray = [BEnergyStubGroupModel mj_objectArrayWithKeyValuesArray:array];
                    self.result = YES;
                    if ([dataArray count] > 0) {
                        [self.datasArray addObjectsFromArray:dataArray];
                    }
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
    return _hnStubListCommand;
}

- (RACCommand *)hnStubDetailsCommand {
    ByEnergyWeakSekf
    if (!_hnStubDetailsCommand) {
        _hnStubDetailsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(StubGroupDetailsUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnStubDetailsCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSDictionary *dataDic = x;
                    NSError* err = nil;
                    BEnergyStubGroupDetailModel *stubGroupDetail = [[BEnergyStubGroupDetailModel alloc] initWithDictionary:dataDic error:&err];
                    NSMutableArray *datas = [NSClassFromString(@"Stublist") arrayOfModelsFromDictionaries:[dataDic objectForKey:@"stubList"] error:&err];
                    if (!err) {
                        stubGroupDetail.stubList = [datas copy];
                    }
                    NSMutableArray *priceArr = [NSClassFromString(@"Pricedetails") arrayOfModelsFromDictionaries:[dataDic objectForKey:@"priceDetails"] error:&err];
                    if (!err) {
                        stubGroupDetail.priceDetails = [priceArr copy];
                    }
                    
                    NSMutableArray *auxiliaryList = [NSClassFromString(@"auxiliaryList") arrayOfModelsFromDictionaries:[dataDic objectForKey:@"auxiliaryList"] error:&err];
                    if (!err) {
                        stubGroupDetail.auxiliaryList = [auxiliaryList copy];
                    }
                    if (err == nil) {
                        stubGroupDetail.info = byEnergyClearNilReturnStr(stubGroupDetail.info,@"暂无备注");
                        stubGroupDetail.parkingFeeInfo = byEnergyClearNilReturnStr(stubGroupDetail.parkingFeeInfo, @"暂无说明");
                        self.result = YES;
                        self.value = stubGroupDetail;
                }
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnStubDetailsCommand;
}

- (RACCommand *)hnStubChargingProgressCommand {
    ByEnergyWeakSekf
    if (!_hnStubChargingProgressCommand) {
        _hnStubChargingProgressCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnStubChargingProgressCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(StubListSocUrl) parameters:params.api responseClass:nil netWorksModel:self.hnStubChargingProgressCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
                
            }];
            return requestSignal;
        }];
    }
    return _hnStubChargingProgressCommand;
}
@end
