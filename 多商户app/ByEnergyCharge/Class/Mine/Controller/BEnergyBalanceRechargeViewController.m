//
//  BEnergyBalanceRechargeViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBalanceRechargeViewController.h"
#import "BEnergyRechargeOneSelfView.h"
#import "BEnergyBalanceRechargeCell.h"
#import "BEnergyRechargeViewModel.h"

@interface BEnergyBalanceRechargeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView *byFooterView;
@property (nonatomic, strong) UIButton *bySubmitBtn;
@property (nonatomic, strong) NSMutableArray <RechargeModel *> *datasArray;
@property (nonatomic, assign) int selectIndex;//选中的
@property (nonatomic, copy) NSString *byDestiAccount;//充值账号
@property (nonatomic, copy) NSString *byReprice;//充值金额
@property (nonatomic, strong) BEnergyRechargeViewModel *rechargeViewModel;
@property (nonatomic, strong) BEnergyRechargeOneSelfView *byOneSelfView;


@end

@implementation BEnergyBalanceRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitDatas];
    
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)backBtnClicked {
    if (self.refreshChargeStartViewData) {
        self.refreshChargeStartViewData();
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)byEnergyInitViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = self.byFooterView;
    [self.byFooterView addSubview:self.bySubmitBtn];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.byOneSelfView;
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergyInitDatas {
    self.selectIndex = 3;
}

- (void)byEnergySetViewLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(- SafeAreaBottomHeight);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[self.byOneSelfView.reChargeSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        self.byReprice = x;
    }];
    
    [[[[self.rechargeViewModel.hnMoneyChargeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.rechargeViewModel.result) {
            [self rechargePayOrderInfo:x payPlatform:self.rechargeViewModel.payType];
        }
    }];
}

#pragma mark -----TableViewDelegate && TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BEnergyBalanceRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:kBEnergyBalanceRechargeCell];
    if (cell == nil) {
        cell = [[BEnergyBalanceRechargeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kBEnergyBalanceRechargeCell];
    }
    RechargeModel *model = [self.datasArray objectAtIndex:indexPath.row];
    model.selected = self.selectIndex == [model.payValue intValue] ? YES : NO;
    cell.model = model;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = [self.datasArray[indexPath.row].payValue intValue];
    [self.tableView reloadData];
}

#pragma mark -BtnAct
- (void)rechargeSubmitMoneyWithPrice:(NSString *)price type:(int)repaytype voucherIds:(NSString *)revoucherids {
    [self.view endEditing:YES];
    switch (repaytype) {
        case 0:
            self.rechargeViewModel.payType = GDPayPlatformAlipay;
            break;
        case 1:
            self.rechargeViewModel.payType = GDPayPlatformUPPay;
            break;
        case 3:
            self.rechargeViewModel.payType = GDPayPlatformWeiXin;
            break;
        default:
            break;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
#if DevelopSever
    [params setObject:NSStringFormat(@"%@",@"0.01") forKey:@"price"];
#elif TestSever
    [params setObject:NSStringFormat(@"%@",@"0.01") forKey:@"price"];
#elif ProductSever
    [params setObject:NSStringFormat(@"%@",price) forKey:@"price"];
#endif
    [params setObject:[NSNumber numberWithInt:repaytype] forKey:@"payType"];
    [params setObject:byEnergyClearNilStr(revoucherids) forKey:@"voucherIds"];
    [params setObject:byEnergyClearNilStr(_byDestiAccount) forKey:@"destiAccount"];
    
    [params setObject:[NSNumber numberWithInt:0] forKey:@"useType"];
    [params setObject:[NSNumber numberWithInt:1] forKey:@"refundToStarAccount"];
    [self.rechargeViewModel.hnMoneyChargeCommand execute:params];
}

/**
 支付回调
 @param oderInfo 订单ID
 @param platform 支付类型
 */
- (void)rechargePayOrderInfo:(BEnergyTradeInfoModel *)oderInfo payPlatform:(GDPayPlatform)platform {
    
    [[NSUserDefaults standardUserDefaults] setObject:oderInfo.id forKey:@"orderId"];
    [[NSUserDefaults standardUserDefaults] setObject:oderInfo.tradeNo forKey:@"tradeNo"];
    if (byEnergyIsNilOrNull(oderInfo) == NO) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appScheme = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        
        [ByEnergyPayHandler payForOrder:oderInfo
                               platform:platform
                         viewController:self
                              urlScheme:appScheme
                             completion:^(NSString *result, NSString *errorStr) {
            if ([result isEqualToString:@"success"]) {
                ByEnergySendNotification(ByEnergyUpdateUserInfo, nil);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    [HUDManager showStateHud:@"支付成功" state:HUDStateTypeSuccess];
                });
            }
            else {
                [HUDManager showTextHud:errorStr];
            }
        }];
    }
}

#pragma mark -----LazyLoad
LCFLazyload(BEnergyRechargeViewModel, rechargeViewModel)

- (UIView *)byFooterView {
    if (!_byFooterView) {
        _byFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 104)];
        _byFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _byFooterView;
}

- (BEnergyRechargeOneSelfView *)byOneSelfView {
    if (!_byOneSelfView) {
        _byOneSelfView =[[BEnergyRechargeOneSelfView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 360)];
    }
    return _byOneSelfView;
}

- (NSMutableArray <RechargeModel *> *)datasArray {
    if (!_datasArray) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        if ([[BEnergyAppStorage sharedInstance].systemInfo.auth.wxpayStatus.value isEqualToString:@"0"]) {
            [array addObject:@{
                @"payKey":@"wechat",
                @"payTitle":@"微信支付",
                @"payValue":@(3),
                @"imageName":@"icon_wechat_Balance",
            }];
        }
        
        if ([[BEnergyAppStorage sharedInstance].systemInfo.auth.alipayStatus.value isEqualToString:@"0"]) {
            [array addObject: @{
                @"payKey":@"alipay",
                @"payTitle":@"支付宝支付",
                @"payValue":@(0),
                @"imageName":@"icon_alipay_Balance",
            }];
        }
        
        if ([[BEnergyAppStorage sharedInstance].systemInfo.auth.umspayStatus.value isEqualToString:@"0"]) {
            [array addObject: @{
                @"payKey":@"yunshanfu",
                @"payTitle":@"云闪付",
                @"payValue":@(1),
                @"imageName":@"yunIcon",
            }];
        }
        _datasArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[RechargeModel class] json:array]];
    }
    return _datasArray;
}

- (UIButton *)bySubmitBtn {
    if (!_bySubmitBtn) {
        ByEnergyWeakSekf
        _bySubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bySubmitBtn.frame = CGRectMake(27, 0, self.byFooterView.width - 54, 45);
        _bySubmitBtn.center = CGPointMake(self.byFooterView.width/2, (self.byFooterView.height/2)+8);
        _bySubmitBtn.adjustsImageWhenHighlighted = NO;
        [_bySubmitBtn setTitle:@"确认充值" forState:UIControlStateNormal];
        [_bySubmitBtn setBackgroundImage:IMAGEWITHNAME(@"chargingBtn") forState:UIControlStateNormal];
        [_bySubmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bySubmitBtn.titleLabel.font = ByEnergyRegularFont(18);
        _bySubmitBtn.layer.cornerRadius = 5.0f;
        [[[_bySubmitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            self.byDestiAccount = [(BEnergyUserInfoModel *)[BEnergySCUserStorage sharedInstance].userInfo account];
            if ([self.byReprice floatValue] <= 0) {
                [HUDManager showTextHud:@"请输入充值金额!"];return;
            }
            [self rechargeSubmitMoneyWithPrice:self.byReprice type:self.selectIndex voucherIds:@""];
        }];
    }
    return _bySubmitBtn;
}

@end
