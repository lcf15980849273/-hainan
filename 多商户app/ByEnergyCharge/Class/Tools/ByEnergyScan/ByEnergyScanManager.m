//
//  ByEnergyScanManager.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/8/21.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyScanManager.h"
#import "SCPermission.h"
#import "BEnergyScanQRViewController.h"
#import "BEnergyBalanceRechargeViewController.h"
#import "BEnergyWaitPayOrderView.h"
#import "RYCoverView.h"
#import "BEnergyChargeListModel.h"

@interface ByEnergyScanManager ()<BEnergyWaitPayOrderViewDelegate>
//待支付订单
@property (nonatomic, strong) BEnergyWaitPayOrderView *BEnergyWaitPayOrderView;
@end

@implementation ByEnergyScanManager

SINGLETON_FOR_CLASS(ByEnergyScanManager);

- (void)checkScanQR {
    kWeakSelf(self);
    BEnergyChargeListModel *model = (BEnergyChargeListModel *)[self.homeChargeListModel unpaid];
    if (byEnergyIsValidStr(model.orderId)) {
        [self.BEnergyWaitPayOrderView fillDataWithDataModel:model];
        [RYCoverView translucentWindowCenterCoverContent:self.BEnergyWaitPayOrderView animated:YES notClick:YES];
        return;
    }
    if (self.homeChargeListModel.isUnpaid) {
        if ([self.homeChargeListModel.chargelist count] > 0) {
            [HUDManager showTextHud:@"您有一笔订单未完成，请稍后再试"];
            return;
        }
        if (self.homeChargeListModel.userAmount < self.homeChargeListModel.userLessMoney) {
            [self showAlert:@"余额预存10元即可充电！快点我充值吧！"];
            return;
        }
    }else {
        if (self.homeChargeListModel.userAmount <= 0) {
            [self showAlert:@"余额预存10元即可充电！快点我充值吧！"];
            return;
        }
    }
    
    [SCPermission authorizedWithType:SCPermissionType_Camera WithResult:^(BOOL granted) {
        if (granted) {
            [weakself pushBEnergyScanQRViewController];
        }
    }];
}

- (void)showAlert:(NSString *)message{
    kWeakSelf(self);
    [BEnergyCustomAlertView showAlertViewWithTitle:@"提示"
                                            detail:message
                                 buttonsTitleArray:@[@"稍后再说",@"点我充值"]
                                   operationAction:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [weakself pushBEnergyBalanceRechargeViewController];
        }
    }];
}

/**
 充值
 */
- (void)pushBEnergyBalanceRechargeViewController {
    kWeakSelf(self);
    BEnergyBalanceRechargeViewController *vc = [[BEnergyBalanceRechargeViewController alloc] init];
    [[weakself.controller navigationController] pushViewController:vc animated:YES];
}

/**
 扫码充电
 */
- (void)pushBEnergyScanQRViewController {
    kWeakSelf(self);
    BEnergyScanQRViewController *vc = [BEnergyScanQRViewController new];
    vc.style = [BEnergyScanQRViewController ScanViewStyle];
    vc.ispushCharging = YES;
    vc.isOpenInterestRect = YES;
    vc.libraryType = SLT_Native;
    vc.scanCodeType = SCT_QRCode;
    vc.isNeedScanImage = YES;
    [[weakself.controller navigationController] pushViewController:vc animated:YES];
}
/**
 待支付订单
 */
- (BEnergyWaitPayOrderView *)BEnergyWaitPayOrderView {
    if (_BEnergyWaitPayOrderView == nil) {
        _BEnergyWaitPayOrderView = [ByEnergyLoadViews loadViewFromNib:@"BEnergyWaitPayOrderView"];
        _BEnergyWaitPayOrderView.delegate = self;
    }
    return _BEnergyWaitPayOrderView;
}

#pragma mark -----BEnergyWaitPayOrderViewDelegate
- (void)submitPay {
    [RYCoverView hide];
    if (self.controller) {
//        BEnergyWaitingPayViewController *vc = [[BEnergyWaitingPayViewController alloc] init];
//        vc.orderId = self.homeChargeListModel.unpaid.orderId;
//        [[self.controller navigationController] pushViewController:vc animated:YES];
    }
}

- (void)closeView {
    [RYCoverView hide];
}

@end
