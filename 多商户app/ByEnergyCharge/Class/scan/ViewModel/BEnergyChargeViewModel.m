//
//  BEnergyChargeViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargeViewModel.h"
#import "BEnergyChargeOrderModel.h"
#import "BEnergyStubInfoModel.h"
#import "BEnergyChargeListModel.h"
#import "BEnergyChargeDetailModel.h"
#import "BEnergyStubChargeDetailsModel.h"
#import "BEnergyUnpaidDetailModel.h"
#import "BEnergyHomeChargeListModel.h"

@implementation BEnergyChargeViewModel

- (RACCommand *)hnStartChargeCommand {
    ByEnergyWeakSekf
    if (!_hnStartChargeCommand) {
        _hnStartChargeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            if (byEnergyIsValidStr(self.stubId)) {
                [params setObject:self.stubId forKey:@"stubId"];
            }
            [params setObject:NSStringFormat(@"%d",self.voltageType) forKey:@"voltageType"];
            [params setObject:byEnergyClearNilStr(self.carNumber) forKey:@"carNumber"];
            [params setObject:@"0" forKey:@"isBusiness"];
            
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiCarChargeStartUrl) parameters:params.api responseClass:[BEnergyChargeOrderModel class] netWorksModel:self.hnStartChargeCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.hnStartChargeCommand.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.hnStartChargeCommand.result = YES;
                    self.hnStartChargeCommand.value = x;
                }
                
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.hnStartChargeCommand.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnStartChargeCommand;
}

- (RACCommand *)hnEndChargeCommand {
    ByEnergyWeakSekf
    if (!_hnEndChargeCommand) {
        _hnEndChargeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            if (byEnergyIsValidStr(self.chargeId)) {
                [params setObject:byEnergyClearNilStr(self.chargeId) forKey:@"chargeId"];
                
            }
            self.hnEndChargeCommand.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiCarChargeEndUrl) parameters:params.api responseClass:[BEnergyChargeOrderModel class] netWorksModel:self.hnEndChargeCommand.netWorksModel];
            [HUDManager showLoadingHud:@"停止充电中..."];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    self.value = x;
                    ByEnergySendNotification(kByEnergyUpdateBadge, nil);
                }
                
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnEndChargeCommand;
}

- (RACCommand *)hnCheckStubInfoCommand {
    ByEnergyWeakSekf
    if (!_hnCheckStubInfoCommand) {
        _hnCheckStubInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            if (byEnergyIsValidStr(self.stubId)) {
                [params setObject:self.stubId forKey:@"stubId"];
            }
            self.hnCheckStubInfoCommand.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiStubInfoUrl) parameters:params.api responseClass:[BEnergyStubInfoModel class] netWorksModel:self.hnCheckStubInfoCommand.netWorksModel];
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
    return _hnCheckStubInfoCommand;
}

- (RACCommand *)hnCheckGusStausCommand {
    ByEnergyWeakSekf
    if (!_hnCheckGusStausCommand) {
        _hnCheckGusStausCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            if (byEnergyIsValidStr(self.stubId)) {
                [params setObject:self.stubId forKey:@"stubId"];
            }
            self.hnCheckGusStausCommand.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiStubCheckUrl) parameters:params.api responseClass:nil netWorksModel:self.hnCheckGusStausCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = YES;
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnCheckGusStausCommand;
}

- (RACCommand *)hnchargeListCommand {
    ByEnergyWeakSekf
    if (!_hnchargeListCommand) {
        _hnchargeListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.pageIndex = self.page.PageIndex;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiChargeListUrl) parameters:params.api responseClass:[BEnergyChargeListModel class] netWorksModel:self.hnchargeListCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    NSArray *array = x;
                    if ([array count] > 0) {
                        [self.datasArray addObjectsFromArray:array];
                    }
                }
                self.value = self.datasArray;
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnchargeListCommand;
}

- (RACCommand *)hnchargingDetailCommand {
    ByEnergyWeakSekf
    if (!_hnchargingDetailCommand) {
        _hnchargingDetailCommand =  [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr(self.orderId) forKey:@"orderId"];
            [params setObject:byEnergyClearNilStr([(BEnergyUserInfoModel *)[[BEnergySCUserStorage sharedInstance]userInfo] account]) forKey:@"userAccount"];
            self.hnchargingDetailCommand.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiChargeDetailUrl) parameters:params.api responseClass:[BEnergyChargeOrderModel class] netWorksModel:self.hnchargingDetailCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    NSArray *array = x;
                    if ([array count] > 0) {
                        self.value = [array objectAtIndex:0];
                    }
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnchargingDetailCommand;
}

- (RACCommand *)hnNewChargeLogListCommand {
    ByEnergyWeakSekf
    if (!_hnNewChargeLogListCommand) {
        _hnNewChargeLogListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.pageIndex = self.page.PageIndex;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiNewChargeLogListUrl) parameters:params.api responseClass:[BEnergyChargeListModel class] netWorksModel:self.hnNewChargeLogListCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    NSArray *array = x;
                    self.result = YES;
                    self.page.SizeCount = [array count];
                    if ([array count] > 0) {
                        [self.datasArray addObjectsFromArray:array];
                    }
                }
                self.value = self.datasArray;
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.page.PageIndex --;
                self.result = NO;
            }];
            return requestSignal;
        }];
        
    }
    return _hnNewChargeLogListCommand;
}

- (RACCommand *)hnOrderFinshDetailCommand {
    ByEnergyWeakSekf
    if (!_hnOrderFinshDetailCommand) {
        _hnOrderFinshDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr(self.orderId) forKey:@"orderId"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiChargeLogDetailUrl) parameters:params.api responseClass:[BEnergyChargeDetailModel class] netWorksModel:self.hnOrderFinshDetailCommand.netWorksModel];
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
    return _hnOrderFinshDetailCommand;
}

- (RACCommand *)hnFetchChargesCommand {
    ByEnergyWeakSekf
    if (!_hnFetchChargesCommand) {
        _hnFetchChargesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            if (byEnergyIsValidStr(self.stubId)) {
                [params setObject:self.stubId forKey:@"stubId"];
            }
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiStubChargeDetailsUrl) parameters:params.api responseClass:[BEnergyStubChargeDetailsModel class] netWorksModel:self.hnFetchChargesCommand.netWorksModel];
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
    return _hnFetchChargesCommand;
}

- (RACCommand *)homeChargeList {
    ByEnergyWeakSekf
    if (!_homeChargeList) {
        _homeChargeList = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            self.homeChargeList.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiNewHomeChargeListUrl) parameters:params.api responseClass:Nil netWorksModel:self.homeChargeList.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSDictionary *dic = (NSDictionary *)x;
                    self.result = YES;
                    NSError *err = nil;
                    BEnergyHomeChargeListModel *ListModel = [[BEnergyHomeChargeListModel alloc] initWithDictionary:dic error:&err];
                    NSMutableArray *list = [NSClassFromString(@"BEnergyChargeListModel") arrayOfModelsFromDictionaries:[dic objectForKey:@"chargelist"] error:&err];
                    if (!err) {
                        ListModel.chargelist = [list copy];
                    }
                    BEnergyChargeListModel *unpaid = [[BEnergyChargeListModel alloc] initWithDictionary:[dic objectForKey:@"unpaid"] error:&err];
                    if (!err) {
                        ListModel.unpaid = unpaid;
                    }
                    self.value = ListModel;
                }
                
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _homeChargeList;
}

/**
 充电订单列表（包含充电中、已完成、待支付）
 */
- (RACCommand *)hnOdderListCommand {
    ByEnergyWeakSekf
    if (!_hnOdderListCommand) {
        _hnOdderListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnOdderListCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.pageIndex = self.page.PageIndex;
            [params setObject:@(self.type) forKey:@"type"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiChargeOrderListUrl) parameters:params.api responseClass:[BEnergyChargeListModel class] netWorksModel:self.hnOdderListCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    NSArray *array = x;
                    if ([array count] > 0) {
                        [self.datasArray addObjectsFromArray:array];
                    }
                     self.page.SizeCount = [array count];
                }
                self.value = self.datasArray;
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnOdderListCommand;
}

/**
 待支付订单结算
 */
- (RACCommand *)hnsettleUnpaidOrder {
    ByEnergyWeakSekf
    if (!_hnsettleUnpaidOrder) {
        _hnsettleUnpaidOrder = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr(self.orderId) forKey:@"orderId"];
            [params setObject:@(self.payType) forKey:@"payType"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiSettleUnpaidOrderUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnsettleUnpaidOrder.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.hnsettleUnpaidOrder.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.hnsettleUnpaidOrder.result = YES;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnsettleUnpaidOrder;
}
/**
 待支付详情
 */
- (RACCommand *)hnUnpaidDetailCommand {
    ByEnergyWeakSekf
    if (!_hnUnpaidDetailCommand) {
        _hnUnpaidDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:byEnergyClearNilStr(self.orderId) forKey:@"orderId"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiUnpaidDetailUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnUnpaidDetailCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    BEnergyUnpaidDetailModel *model = [[BEnergyUnpaidDetailModel alloc] init];
                    NSDictionary *dic = (NSDictionary *)x;
                    NSError *err = nil;
                    BEnergyChargeDetailModel *orderModel = [[BEnergyChargeDetailModel alloc] initWithDictionary:[dic objectForKey:@"unpaidDetail"] error:&err];
                    if (!err) {
                        model.unpaidDetail = orderModel;
                    }
                    NSMutableArray *list = [NSClassFromString(@"Unpaidtype") arrayOfModelsFromDictionaries:[dic objectForKey:@"unpaidType"] error:&err];
                    NSArray *dataList = [list.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
                        Unpaidtype *typeModel = value;
                        BEnergyStartChargeCellModel *model = [[BEnergyStartChargeCellModel alloc] init];
                        model.title = typeModel.name;
                        model.value = typeModel.id;
                        model.displayValue = typeModel.remark;
                        model.cellType = ByEnergyChargeCellType_CHECK;
                        if ([model.title isEqualToString:@"余额支付"]) {
                            model.key = @"balance";
                            model.imageName = @"icon_balance_WaitPay";
                        }else if ([model.title isEqualToString:@"银联支付"]) {
                            model.key = @"HCE";
                            model.imageName = @"icon_HCE_WaitPay";
                            model.width = [model.displayValue sizeWithFont:ByEnergyRegularFont(12) maxSize:CGSizeMake(CGFLOAT_MAX, 19)].width+20;
                        }else {
                            model.key = @"balance";
                            model.imageName = @"icon_balance_WaitPay";
                        }
                        return model;
                    }].toArray;
                    if (!err) {
                        model.unpaidType = [dataList copy];
                    }
                    self.value = orderModel;
                    self.hnUnpaidDetailCommand.value = model.unpaidType;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnUnpaidDetailCommand;
}

- (RACCommand *)hnChargeTypeCommand {
    ByEnergyWeakSekf
    if (!_hnChargeTypeCommand) {
        _hnChargeTypeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnChargeTypeCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:@"1" forKey:@"newyeaAppType"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiChargeTypeUrl) parameters:params.api responseClass:nil netWorksModel:self.hnChargeTypeCommand.netWorksModel];
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
    return _hnChargeTypeCommand;
}
@end
