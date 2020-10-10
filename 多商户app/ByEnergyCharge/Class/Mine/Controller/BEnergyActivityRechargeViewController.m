//
//  BEnergyActivityRechargeViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/12.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyActivityRechargeViewController.h"
#import "BEnergyActiveRechargeCell.h"
#import "BEnergyRechargeViewModel.h"
@interface BEnergyActivityRechargeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIImageView *weSelectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *zhiSelectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yunSelectImageView;

@property (weak, nonatomic) IBOutlet UIView *weChatView;
@property (weak, nonatomic) IBOutlet UIView *zhifubaoView;
@property (weak, nonatomic) IBOutlet UIView *yunshanfuView;


@property (nonatomic, copy) NSString *byReprice;//充值金额
@property (nonatomic, copy) NSString *activityID;
@property (nonatomic, strong) BEnergyRechargeViewModel *rechargeViewModel;
@property (nonatomic, copy) NSString *byDestiAccount;//充值账号
@property (nonatomic, assign) int selectIndex;//选中的
@end

@implementation BEnergyActivityRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self byEnergyInitViewModel];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)byEnergySetViewLayout {
    
}

- (void)initDataAndViews {
    
    self.selectIndex = 3;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.weSelectImageView.image = IMAGEWITHNAME(@"check_selected_Balance");
    self.zhiSelectImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
    self.yunSelectImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyActiveRechargeCell bundle:nil] forCellReuseIdentifier:kBEnergyActiveRechargeCell];
    if ([[BEnergyAppStorage sharedInstance].systemInfo.auth.wxpayStatus.value isEqualToString:@"0"]) {
        self.weChatView.hidden = NO;
    }else {
        self.weChatView.hidden = YES;
    }
    if ([[BEnergyAppStorage sharedInstance].systemInfo.auth.alipayStatus.value isEqualToString:@"0"]) {
        self.zhifubaoView.hidden = NO;
    }else {
        self.zhifubaoView.hidden = YES;
    }
    if ([[BEnergyAppStorage sharedInstance].systemInfo.auth.umspayStatus.value isEqualToString:@"0"]) {
        self.yunshanfuView.hidden = NO;
    }else {
        self.yunshanfuView.hidden = YES;
    }
    
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[[self.rechargeViewModel.hnMoneyChargeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.rechargeViewModel.result) {
            [self rechargePayOrderInfo:x payPlatform:self.rechargeViewModel.payType];
        }
    }];
}

- (void)setActiveArray:(NSArray<BEnergyActiveChargeModel *> *)activeArray {
    _activeArray = activeArray;
    [self.tableView reloadData];
}

#pragma mark -----TableViewDelegate && TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.activeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BEnergyActiveRechargeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyActiveRechargeCell];
    cell.model = self.activeArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(20, 10, 200, 23)];
    label.font = ByEnergyRegularFont(26);
    label.textColor = UIColor.byEnergyTitleTextBlack;
    [headerView addSubview:label];
    label.text = @"活动充值";
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.activeArray[indexPath.row].joinFlag) {
        BEnergyActiveChargeModel *model = self.activeArray[indexPath.row];
        self.byReprice = model.conditionAmount;
        self.activityID = model.id;
        for (int i = 0; i < self.activeArray.count; i ++) {
            self.activeArray[i].isSelect = i == indexPath.row ? YES : NO;
        }
    }
    [self.myTableView reloadData];
}

- (IBAction)submitChargeButtonClick:(UIButton *)sender {
    self.byDestiAccount = [(BEnergyUserInfoModel *)[BEnergySCUserStorage sharedInstance].userInfo account];
    if ([self.byReprice floatValue] <= 0) {
        [HUDManager showTextHud:@"请选择活动!"];return;
    }
    [self rechargeSubmitMoneyWithPrice:self.byReprice type:self.selectIndex voucherIds:@""];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (IBAction)wePayButtonClick:(UIButton *)sender {
    self.selectIndex = 3;
    self.weSelectImageView.image = IMAGEWITHNAME(@"check_selected_Balance");
    self.zhiSelectImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
    self.yunSelectImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
}

- (IBAction)aiPayButtonClick:(UIButton *)sender {
    self.selectIndex = 0;
    self.weSelectImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
    self.zhiSelectImageView.image = IMAGEWITHNAME(@"check_selected_Balance");
    self.yunSelectImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
}
- (IBAction)yunshanfuButtonClick:(UIButton *)sender {
    self.selectIndex = 1;
    self.yunSelectImageView.image = IMAGEWITHNAME(@"check_selected_Balance");
    self.weSelectImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
    self.zhiSelectImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
}

#pragma mark -BtnAct
- (void)rechargeSubmitMoneyWithPrice:(NSString *)price type:(int)repaytype voucherIds:(NSString *)revoucherids {
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
    [params setObject:[NSNumber numberWithInt:2] forKey:@"useType"];
    [params setObject:self.activityID forKey:@"userActivityId"];
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
@end
