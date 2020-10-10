//
//  BEnergyNoticeCenterViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyNoticeCenterViewModel.h"
#import "BEnergyNoticeCenterModel.h"
@implementation BEnergyNoticeCenterViewModel

- (RACCommand *)hnNoticeCenterCommand {
    ByEnergyWeakSekf
    if (!_hnNoticeCenterCommand) {
        _hnNoticeCenterCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            
            //修改。。。。。。。。
            self.hnNoticeCenterCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiAdsPagingDetailUrl) parameters:params.api responseClass:[BEnergyNoticeCenterModel class] netWorksModel:self.hnNoticeCenterCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *array = x;
                    self.result = YES;
                    if ([array count] > 0) {
                        [self.datasArray addObjectsFromArray:array];
                    }
                    self.page.SizeCount = [array count];
                }
                
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnNoticeCenterCommand;
}

- (RACCommand *)hnSystemNoticeCommand {
    ByEnergyWeakSekf
    if (!_hnSystemNoticeCommand) {
        _hnSystemNoticeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnSystemNoticeCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.page = self.page.PageIndex;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiAdsPagingDetailUrl) parameters:params.api responseClass:[BEnergyNoticeCenterModel class] netWorksModel:self.hnSystemNoticeCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *array = x;
                    self.result = YES;
                    if ([array count] > 0) {
                        [self.datasArray addObjectsFromArray:array];
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
    return _hnSystemNoticeCommand;
}

- (RACCommand *)hnActivityCommand {
    ByEnergyWeakSekf
    if (!_hnActivityCommand) {
        _hnActivityCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnActivityCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.page = self.page.PageIndex;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiAdsPagingDetailUrl) parameters:params.api responseClass:[BEnergyNoticeCenterModel class] netWorksModel:self.hnActivityCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *array = x;
                    self.result = YES;
                    if ([array count] > 0) {
                        if (self.datasArray.count > 0) {
                            [self.datasArray removeAllObjects];
                        }
                        [self.datasArray addObjectsFromArray:array];
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
    return _hnActivityCommand;
}


@end


