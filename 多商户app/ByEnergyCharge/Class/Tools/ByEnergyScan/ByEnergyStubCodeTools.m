
//
//  ByEnergyStubCodeTools.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyStubCodeTools.h"
#import "BEnergyStubInfoModel.h"
#import "BEnergyChargeOrderModel.h"

@interface ByEnergyStubCodeTools ()
@property (nonatomic, assign) BOOL canRequest;
@end

@implementation ByEnergyStubCodeTools

- (instancetype) init {
    if (self = [super init]) {
        self.canRequest = YES;
        [self byEnergyInitViewModel];
    }
    return self;
}

- (void)byEnergyInitViewModel  {
    
    ByEnergyWeakSekf
    [[[[self.viewModel.hnCheckGusStausCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            [self.viewModel.hnCheckStubInfoCommand execute:nil];
        }
    }];
    
    [[self.viewModel.hnCheckGusStausCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [HUDManager hidenHud];
        NSDictionary *dic = x.userInfo[@"operationInfoKey"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDManager showStateHud:dic[@"msg"]
                               state:HUDStateTypeFail
                             imgName:nil
                          afterDelay:1
                              onView:ByEnergyAppWindow
                     completionBlock:^{
                if (self.resetScanBlock) {
                    self.resetScanBlock();
                }
            }];
            
        });
    }];
    
    [[[[self.viewModel.hnCheckStubInfoCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            BEnergyStubInfoModel *stubInfo = (BEnergyStubInfoModel *)self.viewModel.value;
            if ([stubInfo.status isEqualToString:@"00"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [HUDManager showStateHud:@"校验成功"
                                       state:HUDStateTypeSuccess
                                     imgName:nil
                                  afterDelay:0.5
                                      onView:ByEnergyAppWindow
                             completionBlock:^{
                        [self.chargeSubject sendNext:stubInfo];
                    }];
                    
                });
                
            }else {
                [HUDManager hidenHud];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([stubInfo.status isEqualToString:@"01"]) {
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩正在充电中"]];
                    }else if ([stubInfo.status isEqualToString:@"02"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩有故障"]];
                    }else if ([stubInfo.status isEqualToString:@"03"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"车位占用中"]];
                    }else if ([stubInfo.status isEqualToString:@"04"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩维护中"]];
                    }else if ([stubInfo.status isEqualToString:@"05"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩离线中"]];
                    }else if ([stubInfo.status isEqualToString:@"06"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩在建中"]];
                    }else if ([stubInfo.status isEqualToString:@"07"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩程序升级中"]];
                    }else if ([stubInfo.status isEqualToString:@"08"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩预约等待充电中"]];
                    }else if ([stubInfo.status isEqualToString:@"09"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩储能车储能中"]];
                    }else if ([stubInfo.status isEqualToString:@"99"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩已删除"]];
                    }else if ([stubInfo.status isEqualToString:@"FF"]){
                        [self showAlert:[NSString stringWithFormat:@"桩编号：%@\n%@",stubInfo.id,@"充电桩已锁定"]];
                    }
                });
            }
        }else {
            
            if (self.type == StubCodeToolsTypeDefault) {
                [HUDManager showTextHud:@"二维码有误，请重新扫描"];
            }else if (self.type == StubCodeToolsTypeTextField) {
                [HUDManager showTextHud:@"编号错误，请重新输入"];
            }
            kWeakSelf(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUDManager hidenHud];
                [weakself.failSubject sendNext:nil];
            });
        }
    }];
    
    [[self.viewModel.hnCheckStubInfoCommand errors] subscribeNext:^(NSError * _Nullable x) {
        if (self.type == StubCodeToolsTypeDefault) {
            [HUDManager showTextHud:@"二维码有误，请重新扫描"];
        }else if (self.type == StubCodeToolsTypeTextField) {
            [HUDManager showTextHud:@"编号错误，请重新输入"];
        }
        kWeakSelf(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUDManager hidenHud];
            [weakself.failSubject sendNext:nil];
        });
        
    }];
}

- (void)showAlert:(NSString *)message {

    [BEnergyCustomAlertView showAlertViewWithTitle:@"提示"
                                            detail:message
                                 buttonsTitleArray:@[@"确定"]
                                   operationAction:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        self.canRequest = YES;
        [self.failSubject sendNext:nil];
    }];
}

//充电桩的对应ID  输入二维码时调用
- (void)inputStubInfomationWithStubId:(NSString *)stubId {
    self.viewModel.stubId = stubId;
    if ([stubId length] == 0) {
        if (self.type == StubCodeToolsTypeDefault) {
            [HUDManager showTextHud:@"二维码有误，请重新扫描"];
        }else if (self.type == StubCodeToolsTypeTextField) {
            [HUDManager showTextHud:@"编号错误，请重新输入"];
        }
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDManager showLoadingHud:@"校验中，请稍后..."];
        });
        [self.viewModel.hnCheckGusStausCommand execute:nil];
    }
}

#pragma mark -----LazyLoad
LCFLazyload(BEnergyChargeViewModel, viewModel)

- (RACSubject *)chargeSubject {
    if (_chargeSubject == nil) {
        _chargeSubject = [RACSubject subject];
    }
    return _chargeSubject;
}

- (RACSubject *)failSubject {
    if (_failSubject == nil) {
        _failSubject = [RACSubject subject];
    }
    return _failSubject;
}
@end
