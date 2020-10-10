//
//  BEnergyChargingTableViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargingTableViewController.h"
#import "BEnergyBalanceRechargeViewController.h"
#import "BEnergyChargeOrderDetailTableController.h"
#import "BEnergyHomeVc.h"
#import "BEnergyChargeOrderDetailsCell.h"
#import "BEnergyChargingCoverView.h"
#import "BEnergyChargeViewModel.h"
#import "BEnergyChargeOrderModel.h"
#import "ByEnergyScanManager.h"
#import "BEnergyChargeOrderModel.h"
#import "BEnergyStubViewController.h"
#import "MineTableViewController.h"
#import "BEnergyChargeOrderViewController.h"
#import "BEnergyStubDetailViewController.h"
@interface BEnergyChargingTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *charingNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cdlLabel;//充电量
@property (weak, nonatomic) IBOutlet UIImageView *turnAroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *haveCdlLabel;//已充电量
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;//充电费用
@property (weak, nonatomic) IBOutlet UILabel *currenrLabel;//电流
@property (weak, nonatomic) IBOutlet UILabel *voltageLabel;//电压
@property (nonatomic, strong) BEnergyChargeViewModel *viewModel;
@property (nonatomic, strong) RACDisposable * dispoable;
@property (nonatomic, strong) RACDisposable * loadingDispoable;
@property (nonatomic, assign) BOOL hasShowAlert;//是否已经提示余额不足
@property (nonatomic, strong) BEnergyChargingCoverView * coverView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property(nonatomic, strong)BEnergyChargeOrderModel *orderModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
@end

@implementation BEnergyChargingTableViewController

- (instancetype)init {
    return [BEnergyChargingTableViewController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([ByEnergyTopVC isKindOfClass:[BEnergyHomeVc class]] || [ByEnergyTopVC isKindOfClass:[MineTableViewController class]] ) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }else {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (IBAction)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self byEnergyInitViewModel];
    
    if (self.isPopViewController) {
        for (UIViewController * vc in [self.navigationController viewControllers]) {
            if ([vc isKindOfClass:[BEnergyChargeOrderViewController class]]) {
                [self popToPointViewController:NSStringFromClass([BEnergyChargeOrderViewController class])];
            }else if ([vc isKindOfClass:[BEnergyHomeVc class]]) {
                [self popToPointViewController:NSStringFromClass([BEnergyHomeVc class])];
            }else if ([vc isKindOfClass:[BEnergyStubViewController class]]) {
                [self popToPointViewController:NSStringFromClass([BEnergyStubViewController class])];
            }else if ([vc isKindOfClass:[MineTableViewController class]]) {
                [self popToPointViewController:NSStringFromClass([MineTableViewController class])];
            }else if ([vc isKindOfClass:[BEnergyStubDetailViewController class]]) {
                [self popToPointViewController:NSStringFromClass([BEnergyStubDetailViewController class])];
            }
        }
    }
    [self turnAroundImageViewAnimation];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.coverView];
}

- (void)initDataAndViews {
    self.title = @"充电中";
    [self.view addSubview:self.coverView];
    self.coverView.hidden = self.duration == 0 ? YES:NO;
    self.view.backgroundColor = BYENERGYCOLOR(0xEFF8FF);
    self.statusBarStyle = UIStatusBarStyleLightContent;
    self.backView.layer.cornerRadius = 5.0f;
    self.backView.layer.shadowOffset = CGSizeMake(0, 2);
    self.backView.layer.shadowOpacity = 1.0;
    self.backView.layer.shadowRadius = 5;
    self.titleHeight.constant = IsIphoneXLater ? 50.0f : 30.0f;
    self.backView.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                                      green:0.0f/255.0f
                                                       blue:0.0f/255.0f
                                                      alpha:0.1].CGColor;
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)turnAroundImageViewAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1.3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = ULLONG_MAX;
    rotationAnimation.removedOnCompletion = NO;
    [self.turnAroundImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)byEnergyInitViewModel {
    
    ByEnergyWeakSekf
    self.viewModel.orderId = self.orderId;
    [[[[self.viewModel.hnchargingDetailCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            if (self.viewModel.value == nil) {
                [self hideLoading];
                [HUDManager showTextHud:@"订单有误！"];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                if ([self.viewModel.value status] == 9) {
                    [self hideLoading];
                    [self.dispoable dispose];
                    ByEnergySendNotification(ByEnergyChargeOrderRefresh, nil);
                    [self chargeHasEnd];
                }else if ([self.viewModel.value status] == 1) {
                    BEnergyChargeOrderModel *model = self.viewModel.value;
                    if (![[[ByEnergyScanManager sharedByEnergyScanManager] homeChargeListModel] isUnpaid]) {
                        if (model.userAmount <= 10 && self.hasShowAlert == NO) {
                            kWeakSelf(self);
                            //[self hideLoading];
                            if ([self.viewModel.value startType] != 16) { //不是机构充电才去检测余额是否足够
                                weakself.hasShowAlert = YES;
                                [BEnergyCustomAlertView showAlertViewWithTitle:@"您的余额不足，即将停止充电。请前往充值！"
                                                                   buttonArray:@[@"稍后再说",@"前往充值"]
                                                                         block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
                                    if (buttonIndex == 1) {
                                        [weakself pushBEnergyBalanceRechargeViewController];
                                    }
                                }];
                            }

                        }
                    }
                }else if ([self.viewModel.value status] == 2) {
                    [self hideLoading];
                    [self.dispoable dispose];
                    ByEnergySendNotification(ByEnergyChargeOrderRefresh, nil);
                    [self pushBEnergyWaitingPayViewController];
                }
            }
            self.isUserInitiative = NO;
            self.orderModel = self.viewModel.value;
            [self reloadDatas];
        }
    }];
    
    [[self.viewModel.hnchargingDetailCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [self.dispoable dispose];
    }];
    
    [self.viewModel.hnchargingDetailCommand execute:nil];
    
    [[[[self.viewModel.hnEndChargeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            [self.dispoable dispose];
            [HUDManager showStateHud:@"充电结束"
                               state:HUDStateTypeSuccess
                             imgName:nil
                          afterDelay:1.5
                              onView:ByEnergyAppWindow completionBlock:^{
                BEnergyChargeOrderModel *orderInfo = (BEnergyChargeOrderModel *)x;
                ByEnergySendNotification(ByEnergyChargeOrderRefresh, nil);
                if (orderInfo.status == 2) {
                    [self pushBEnergyWaitingPayViewController];
                }else {
                    BEnergyChargeOrderDetailTableController *vc = [[BEnergyChargeOrderDetailTableController alloc] init];
                    vc.orderId = orderInfo.id;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }
    }];
    
    [[self.viewModel.hnEndChargeCommand errors] subscribeNext:^(NSError * _Nullable x) {
        
    }];
    
    //这个就是RAC中的GCD
    self.dispoable = [[[RACSignal interval:5.0 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDate * _Nullable x) {
        ByEnergyStrongSelf
        [self.viewModel.hnchargingDetailCommand execute:nil];
    }];
    
    if (self.duration) {
        self.loadingDispoable = [[[RACSignal interval:25.0 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDate * _Nullable x) {
            ByEnergyStrongSelf
            [self hideLoading];
        }];
    }
}

#pragma mark ----- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 ) {
        return IsIphoneXLater ? 88.0f : 64.0f;
    }else {
        return 645.0f;
    }
}

#pragma mark ----- action
- (IBAction)endCharingButtonClick:(UIButton *)sender {
    [self carChargeEnd];
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc showSheetStylePickerViewWithLastText:@"类别"];
}

- (void)hideLoading {
    kWeakSelf(self)
    [self.loadingDispoable dispose];
    [UIView animateWithDuration:self.duration
                     animations:^{
        weakself.coverView.alpha = 0;
    } completion:^(BOOL finished) {
        weakself.coverView.hidden = YES;
    }];
}

- (void)carChargeEnd{
    kWeakSelf(self);
    [BEnergyCustomAlertView showAlertViewWithTitle:@"确定停止充电吗？"
                                       buttonArray:@[@"按错了",@"确定"]
                                             block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        if (buttonIndex == 1 ) {
            NSDictionary *param = @{@"chargeId":byEnergyClearNilStr([self.viewModel.value fetchValueWithName:@"outOrderId"])};
            [weakself.viewModel.hnEndChargeCommand execute:param];
        }else {
            
        }
    }];
}

- (void)chargeHasEnd {
    if (!self.isUserInitiative) {
        [self pushBEnergyChargeOrderDetailsViewController];
        return;
    }
    kWeakSelf(self);
    [AlertViewTools showSystemAlertViewTitle:@"当前订单已结束，是否查看此订单详情"
                                     Message:@""
                                      Cancel:@"返回"
                                      Submit:@"查看详情"
                           completionHandler:^(NSUInteger buttonIndex) {
        if (buttonIndex == 1) {
            [weakself pushBEnergyChargeOrderDetailsViewController];
        }else {
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)backBtnClicked {
    ByEnergySendNotification(kByEnergyUpdateBadge, nil);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadDatas {
    self.charingNameLabel.text = self.orderModel.stubGroupName;
    self.codeLabel.text = self.orderModel.stubId;
    self.cdlLabel.text = [NSString stringWithFormat:@"%d",self.orderModel.soc];
    self.haveCdlLabel.text = [NSString stringWithFormat:@"%.2f",self.orderModel.power];
    self.timeLabel.text = self.orderModel.timeCharge;
    self.costLabel.text = [NSString stringWithFormat:@"%.2f",self.orderModel.feeTotal];
    self.currenrLabel.text = [NSString stringWithFormat:@"充电电流:%.2fA",self.orderModel.current];
    self.voltageLabel.text = [NSString stringWithFormat:@"充电电压:%.2fV",self.orderModel.voltage];
}

//充电订单详情
- (void)pushBEnergyChargeOrderDetailsViewController {
    BEnergyChargeOrderDetailTableController *vc = [[BEnergyChargeOrderDetailTableController alloc] init];
    vc.orderId = [self.viewModel.value id];
    vc.isPopViewController = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//充值
- (void)pushBEnergyBalanceRechargeViewController {
    BEnergyBalanceRechargeViewController *vc = [[BEnergyBalanceRechargeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//待支付订单详情页
- (void)pushBEnergyWaitingPayViewController {
//    BEnergyWaitingPayViewController *vc = [[BEnergyWaitingPayViewController alloc] init];
//    vc.orderId = [self.viewModel.value id];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyChargeViewModel, viewModel)
- (BEnergyChargingCoverView *)coverView {
    if (!_coverView) {
        _coverView = [[BEnergyChargingCoverView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    }
    return _coverView;
}

@end
