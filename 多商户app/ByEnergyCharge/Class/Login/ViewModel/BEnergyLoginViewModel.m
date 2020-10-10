//
//  BEnergyLoginViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyLoginViewModel.h"
#import "BEnergyUserInfoModel.h"

@implementation BEnergyLoginViewModel

// 获取验证码
- (RACCommand *)hnFechVerityCodeCommand {
    ByEnergyWeakSekf
    RACSignal *phoneSignal = [_RACObserve(self, phone) map:^id _Nullable(id  _Nullable value) {
        return @([StringUtils isValidateMobile:value]);
    }];
    
    RACSignal *downTimeSignal = [_RACObserve(self, isDownTime) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    /**<合并手机号,验证码已发送 信号量*/
    RACSignal *combineLatest = [RACSignal combineLatest:@[phoneSignal, downTimeSignal] reduce:^id (NSNumber *accountValue, NSNumber *isDownTimeValue){
        return @([accountValue boolValue] && ![isDownTimeValue boolValue]);
    }];
    return [[RACCommand alloc] initWithEnabled:combineLatest signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        ByEnergyStrongSelf
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"phoneNo":byEnergyClearNilStr(self.phone)}];
        RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiGetVerifyCodeUrl) parameters:params.api responseClass:Nil netWorksModel:self.hnFechVerityCodeCommand.netWorksModel];
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

// 登录接口
- (RACCommand *)hnLoginCommand {
    ByEnergyWeakSekf
    RACSignal *phoneSignal = [_RACObserve(self, phone) map:^id _Nullable(id  _Nullable value) {
        return @([StringUtils isValidateMobile:value]);
    }];
    
    RACSignal *codeSignal = [_RACObserve(self, code) map:^id _Nullable(id  _Nullable value) {
        return @([(NSString *)value length] == 4 ? YES:NO);
    }];
    
    RACSignal *isAgreementSignal = [_RACObserve(self, isAgreement) map:^id _Nullable(id  _Nullable value) {
        return value;
    }];
    
    /**<合并手机号,验证码, 用户注册协议 信号量*/
    RACSignal *combineLatest = [RACSignal combineLatest:@[phoneSignal, codeSignal,isAgreementSignal] reduce:^id (NSNumber *accountValue, NSNumber *codeValue, NSNumber *agreement){
        return @([accountValue boolValue] && [codeValue boolValue] && [agreement boolValue] );
    }];
    return [[RACCommand alloc] initWithEnabled:combineLatest signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        ByEnergyStrongSelf
        NSString *codeString = byEnergyClearNilStr([StringUtils md5HexDigest:self.code]);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"phoneNo":self.phone, @"verifyCode":codeString}];
        RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiUserLoginUrl) parameters:dic.api responseClass:nil netWorksModel:self.hnLoginCommand.netWorksModel];
        [requestSignal subscribeNext:^(id  _Nullable x) {
            ByEnergyStrongSelf
            self.result = NO;
            if (!byEnergyIsNilOrNull(x)) {
                NSDictionary *dataDic = x;
                if (!byEnergyIsNilOrNull([dataDic objectForKey:@"token"])) {
                    [USER_DEFAULT setObject:[dataDic objectForKey:@"token"] forKey:@"token"];
                    [USER_DEFAULT synchronize];
                }
                NSError* err = nil;
                BEnergyUserInfoModel *userInfo = [[BEnergyUserInfoModel alloc] initWithDictionary:[dataDic objectForKey:@"userInfo"] error:&err];
                if (err == nil) {
                    [USER_DEFAULT setObject:self.phone forKey:@"phoneNo"];
                    [USER_DEFAULT synchronize];
                    [[BEnergySCUserStorage sharedInstance] saveUserInfo:userInfo];
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

// 退出登录移除token接口
- (RACCommand *)hnRemoveTokenCommand {
    ByEnergyWeakSekf
    if (!_hnRemoveTokenCommand) {
        _hnRemoveTokenCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiRemoveTokenUrl) parameters:params.api responseClass:[NSDictionary class] netWorksModel:self.hnRemoveTokenCommand.netWorksModel];
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
    return _hnRemoveTokenCommand;
}

@end
