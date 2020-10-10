//
//  BEnergyAdsPageViewModel.m
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyAdsPageViewModel.h"
#import "BEnergyFocusModel.h"

@implementation BEnergyAdsPageViewModel

- (RACCommand *)hnAdsPageCommand {
    ByEnergyWeakSekf
    if (!_hnAdsPageCommand) {
        _hnAdsPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiAdsPageDetailUrl) parameters:params.api responseClass:[BEnergyFocusModel class] netWorksModel:self.hnAdsPageCommand.netWorksModel];
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
    return _hnAdsPageCommand;
}

@end
