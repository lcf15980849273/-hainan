//
//  BEnergyMyAccountInfoViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyMyAccountInfoViewController.h"
#import "BEnergyBalanceRechargeViewController.h"
#import "BEnergyWalletDetailsViewController.h"
#import "BEnergyUserInfoViewModel.h"
#import "BEnergyAccountInfoView.h"
#import "BEnergyAmountDetailViewModel.h"
#import "BEnergyUserWalletBalanceModel.h"
#import "BEnergyMyCardView.h"
#import "BEnergySystemInfoViewModel.h"
#import "BEnergyActivityRechargeViewController.h"
@interface BEnergyMyAccountInfoViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BEnergyUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) BEnergyAmountDetailViewModel *amountDetailModel;
@property (nonatomic, strong) BEnergyAccountInfoView *balanceInfoView;//余额信息View
@property (nonatomic, strong) UIButton *fastChargeButton;
@property (nonatomic, strong) BEnergyMyCardView *cardInfoView;//卡号View
@property (nonatomic, strong) BEnergySystemInfoViewModel *systemInfoViewModel;
@property (nonatomic, strong) UIButton *activityButton;
@end

@implementation BEnergyMyAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
    
}

- (void)byEnergyInitViews {
    
    [self byEnergyNavItemWitnTitles:@[@"明细"]
                             isLeft:NO
                             target:self
                             action:@selector(navButtonClick:)
                               tags:@[@"1"]];
    
    self.titleLabel.text = @"我的钱包";
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.balanceInfoView];
    [self.view addSubview:self.fastChargeButton];
    [self.view addSubview:self.cardInfoView];
    [self.view addSubview:self.activityButton];
    self.activityButton.hidden = YES;
    ByEnergyWeakSekf
    ByEnergyReceivedNotification(ByEnergyUpdateUserInfo, ^{
        ByEnergyStrongSelf
        [self.amountDetailModel.hnUserWalletBalanceCommand execute:nil];
    }());
    
    ByEnergyReceivedNotification(ByEnergyRefreshMyAmount, ^{
        ByEnergyStrongSelf
        [self.amountDetailModel.hnUserWalletBalanceCommand execute:nil];
    }());
}

- (void)byEnergySetViewLayout {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(37);
    }];
    
    [self.balanceInfoView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    
    [self.balanceInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(19);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(203);
    }];
    
    [self.cardInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.balanceInfoView.mas_bottom).mas_offset(19);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(138);
    }];
    
    [self.fastChargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(- 10 - SafeAreaBottomHeight);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(50);
    }];
    
    [self.activityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.fastChargeButton.mas_top).offset(- 15);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(50);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[[self.amountDetailModel.hnUserWalletBalanceCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(BEnergyUserWalletBalanceModel *x) {
        ByEnergyStrongSelf
        if (self.amountDetailModel.result) {
            [self.balanceInfoView fillDataWithDataModel:self.amountDetailModel.value];
            self.cardInfoView.hidden = x.isBandChargeCard == 0 ? NO : YES;
            self.cardInfoView.cardNumberLabel.text = x.chargeCardNo;
            NSArray *array = [NSArray yy_modelArrayWithClass:[BEnergyActiveChargeModel class] json:[self.amountDetailModel.value rechargeActivityList]];
            self.activityButton.hidden = array.count == 0 ? YES : NO;
        }
    }];
    
    [self.amountDetailModel.hnUserWalletBalanceCommand execute:nil];
    
    
    [[[[self.systemInfoViewModel.hnSystemInfoCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(BEnergySystemInfoModel *systemInfoModel) {
        ByEnergyStrongSelf
        if (self.systemInfoViewModel.result) {
             self.balanceInfoView.model = systemInfoModel;
        }
    }];

    [self.systemInfoViewModel.hnSystemInfoCommand execute:nil];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

#pragma mark -----Action-----
- (void)navButtonClick:(UIButton *)sender {
    BEnergyWalletDetailsViewController *vc = [[BEnergyWalletDetailsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyUserInfoViewModel, userInfoViewModel)
LCFLazyload(BEnergySystemInfoViewModel, systemInfoViewModel)
LCFLazyload(BEnergyAmountDetailViewModel, amountDetailModel)
- (BEnergyMyCardView *)cardInfoView {
    if (!_cardInfoView) {
        _cardInfoView = [[BEnergyMyCardView alloc] init];
        _cardInfoView.hidden = YES;
    }
    return _cardInfoView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = ByEnergyRegularFont(26);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = UIColor.byEnergyTitleTextBlack;
    }
    return _titleLabel;
}

- (BEnergyAccountInfoView *)balanceInfoView{
    if (!_balanceInfoView) {
        _balanceInfoView = [ByEnergyLoadViews loadViewFromNib:@"BEnergyAccountInfoView"];
//        BEnergyUserInfoModel *userInfoModel = (BEnergyUserInfoModel *)[BEnergySCUserStorage sharedInstance].userInfo;
//        BEnergyUserWalletBalanceModel *model = [[BEnergyUserWalletBalanceModel alloc] init];
//        model.totalAmount = userInfoModel.totalAmount;
//        model.cashFreezingStatus = 1;
//        [_balanceInfoViewfillDataWithDataModel:model];
    }
    return _balanceInfoView;
}

- (UIButton *)fastChargeButton {
    if (!_fastChargeButton) {
        _fastChargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fastChargeButton setTitle:@"普通充值" forState:UIControlStateNormal];
        [_fastChargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _fastChargeButton.adjustsImageWhenHighlighted = NO;
        [_fastChargeButton setBackgroundImage:IMAGEWITHNAME(@"chargingBtn") forState:UIControlStateNormal];
        _fastChargeButton.layer.cornerRadius = 5.0f;
        ByEnergyWeakSekf
        [[[_fastChargeButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            BEnergyBalanceRechargeViewController *vc = [[BEnergyBalanceRechargeViewController alloc] init];
            vc.activeArray = [NSArray yy_modelArrayWithClass:[BEnergyActiveChargeModel class] json:[self.amountDetailModel.value rechargeActivityList]];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _fastChargeButton;
}

- (UIButton *)activityButton {
    if (!_activityButton) {
        _activityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_activityButton setTitle:@"活动充值" forState:UIControlStateNormal];
        [_activityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _activityButton.adjustsImageWhenHighlighted = NO;
        [_activityButton setBackgroundImage:IMAGEWITHNAME(@"activityBtn") forState:UIControlStateNormal];
        _activityButton.layer.cornerRadius = 5.0f;
        ByEnergyWeakSekf
        [[[_activityButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            BEnergyActivityRechargeViewController *vc = [[BEnergyActivityRechargeViewController alloc] init];
            vc.activeArray = [NSArray yy_modelArrayWithClass:[BEnergyActiveChargeModel class] json:[self.amountDetailModel.value rechargeActivityList]];
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    return _activityButton;
}
@end
