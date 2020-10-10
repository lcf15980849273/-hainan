//
//  ShareViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/23.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "ByEnergyShareViewModel.h"
#import "ByEnergyShareCouponModel.h"
@implementation ByEnergyShareViewModel

- (RACCommand *)ShareWithCouponInfo {
    ByEnergyWeakSekf
    if (!_ShareWithCouponInfo) {
        _ShareWithCouponInfo = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            self.ShareWithCouponInfo.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiShareCouponProjectUrl) parameters:params.api responseClass:[ByEnergyShareCouponModel class] netWorksModel:self.ShareWithCouponInfo.netWorksModel];
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
    return _ShareWithCouponInfo;
}

@end
