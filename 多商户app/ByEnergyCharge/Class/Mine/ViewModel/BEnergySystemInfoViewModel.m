
//
//  BEnergySystemInfoViewModel.m
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergySystemInfoViewModel.h"

@implementation BEnergySystemInfoViewModel

- (RACCommand *)hnSystemInfoCommand {
    ByEnergyWeakSekf
    if (!_hnSystemInfoCommand) {
        _hnSystemInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            ByEnergyStrongSelf
            self.hnSystemInfoCommand.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(SystemInfoUrl) parameters:params.api responseClass:[BEnergySystemInfoModel class] netWorksModel:self.hnSystemInfoCommand.netWorksModel];
            [[requestSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    [[BEnergyAppStorage sharedInstance] setSystemInfo:x];
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
    return _hnSystemInfoCommand;
}

- (RACCommand *)hnGetTokenCommand {
    ByEnergyWeakSekf
    if (_hnGetTokenCommand == nil) {
        _hnGetTokenCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiGetTokenUrl) parameters:params.api responseClass:nil netWorksModel:self.hnGetTokenCommand.netWorksModel];
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
    return _hnGetTokenCommand;
}

- (RACCommand *)hnCheckAppStoreVersion {
    ByEnergyWeakSekf
    if (!_hnCheckAppStoreVersion) {
        _hnCheckAppStoreVersion = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            RACSignal *requestSignal = [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", ByEnergyECAppStoreId]];
                NSString * file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
                NSData *data = [file dataUsingEncoding:NSUTF8StringEncoding];
                if(data){
                    [subscriber sendNext:data];
                }else {
                    [subscriber sendError:[[NSError alloc] init]];
                }
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }] setNameWithFormat:@" %@", self.class];
            
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSDictionary *returnInfo = [NSJSONSerialization JSONObjectWithData:x options:0 error:nil];
                    NSArray *returnArray = [returnInfo objectForKey:@"results"];
                    if (returnArray.count<=0) {
                        self.result = NO;
                    }else {
                        self.value = returnInfo;
                        self.result = YES;
                    }
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnCheckAppStoreVersion;
}

@end
