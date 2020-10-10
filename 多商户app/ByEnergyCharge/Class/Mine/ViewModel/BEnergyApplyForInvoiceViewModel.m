

//
//  BEnergyApplyForInvoiceViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyApplyForInvoiceViewModel.h"
#import "BEnergyInvoiceSortModel.h"
#import "BEnergyInvoiceDetailsModel.h"
#import "BEnergyInvoiceSumChoiceModel.h"
#import "ArraysUtils.h"

@implementation BEnergyApplyForInvoiceViewModel

- (RACCommand *)hnFetchInvoiceSumCommand {
    ByEnergyWeakSekf
    if (!_hnFetchInvoiceSumCommand) {
        _hnFetchInvoiceSumCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiInvoiceSumUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnFetchInvoiceSumCommand.netWorksModel];
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
    return _hnFetchInvoiceSumCommand;
}

- (RACCommand *)hnInvoiceSumChoiceCommand {
    ByEnergyWeakSekf
    if (!_hnInvoiceSumChoiceCommand) {
        _hnInvoiceSumChoiceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [self.datasArray removeAllObjects];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiInvoiceSumChoiceUrl) parameters:params.api responseClass:[BEnergyInvoiceSumChoiceModel class] netWorksModel:self.hnInvoiceSumChoiceCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *dataList = x;
                    NSArray *datas = [dataList.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
                        BEnergyInvoiceSumChoiceModel *model = (BEnergyInvoiceSumChoiceModel *)value;
                        if ([self.orderIdList containsObject:model.orderId]) {
                            model.isSelected = YES;
                        }
                        return model;
                    }].toArray;
                    [self.datasArray addObjectsFromArray:[ArraysUtils groupAction:datas]];
                    self.result = YES;
                }
                self.value = self.datasArray;
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnInvoiceSumChoiceCommand;
}

- (RACCommand *)hnInvoiceDetailCommand {
    ByEnergyWeakSekf
    if (!_hnInvoiceDetailCommand) {
        _hnInvoiceDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr(self.invoiceNum) forKey:@"invoiceNum"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiInvoiceDetailUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnInvoiceDetailCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                if (!byEnergyIsNilOrNull(x)) {
                    BEnergyInvoiceDetailsModel *model = [[BEnergyInvoiceDetailsModel alloc] init];
                    NSDictionary *dic = (NSDictionary *)x;
                    NSError* err = nil;
                    model.baseInfo = [[BaseInfo alloc] initWithDictionary:[dic objectForKey:@"baseInfo"] error:&err];

                    NSArray *dataList = [dic objectForKey:@"consumInfo"];
                    NSArray *datas = [dataList.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
                        NSError* err = nil;
                        return  [[ConsumInfoItem alloc] initWithDictionary:value error:&err];
                    }].toArray;
                    model.consumInfo = datas;
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
    return _hnInvoiceDetailCommand;
}

- (RACCommand *)hnInvoiceSortCommand {
    ByEnergyWeakSekf
    if (!_hnInvoiceSortCommand) {
        _hnInvoiceSortCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnInvoiceSortCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.pageIndex = self.page.PageIndex;
            [params setObject:byEnergyClearNilStr(self.status) forKey:@"status"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiInvoiceSortUrl) parameters:params.api responseClass:[BEnergyInvoiceSortModel class] netWorksModel:self.hnInvoiceSortCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *array = x;
                    self.result = YES;
                    self.page.SizeCount = [array count];
                    if ([array count] > 0) {
                        [self.datasArray addObjectsFromArray:array];
                    }
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
    return _hnInvoiceSortCommand;
}

- (RACCommand *)hnInvoiceApplyCommand {
    ByEnergyWeakSekf
    if (!_hnInvoiceApplyCommand) {
        _hnInvoiceApplyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiInvoiceApplyUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnInvoiceApplyCommand.netWorksModel];
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
    return _hnInvoiceApplyCommand;
}

- (RACCommand *)hnInvoiceTipsCommand {
    ByEnergyWeakSekf
    if (!_hnInvoiceTipsCommand) {
        _hnInvoiceTipsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiInvoiceTipsUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnInvoiceTipsCommand.netWorksModel];
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
    return _hnInvoiceTipsCommand;
}

@end
