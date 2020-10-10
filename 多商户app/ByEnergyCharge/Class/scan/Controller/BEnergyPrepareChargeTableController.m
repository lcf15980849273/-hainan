//
//  BEnergyPrepareChargeTableController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/24.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyPrepareChargeTableController.h"
#import "BEnergyHomeVc.h"
#import "BEnergyChargingTableViewController.h"
#import "BEnergyChargeViewModel.h"
#import "BEnergyChargeOrderModel.h"
#import "BRStringPickerView.h"
#import "BEnergyStubChargeDetailsModel.h"
#import "BEnergyChargePayInfoModel.h"
#import "BEnergyChargePayPopView.h"
#import "BEnergyBalanceRechargeViewController.h"
#import "BEnergyRechargeViewModel.h"
#import "BEnergyAddCarNumberViewController.h"
#import "BEnergyPayInfoCell.h"
#import "BEnergyPrepareStubInfoCell.h"
#import "BEnergyChargeStartHeadView.h"
#import "BEnergySystemInfoViewModel.h"
#import "BEnergySystemInfoModel.h"
#import "BEnergyVoltageCell.h"
typedef enum : NSUInteger {
    submitTypePay,  // 前往充值(即充即退)
    submitTypeCharge,  // 确认充电(余额充值)
    submitTypeOrganization //确认充电（机构充电）
} submitType;
@interface BEnergyPrepareChargeTableController ()
@property (weak, nonatomic) IBOutlet UILabel *stubNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitChargeButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *payInfoTitleCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *payInfoCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *addCardNumberCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *cardNumberInfoCell;
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) BEnergyChargeViewModel *viewModel;
@property (nonatomic, assign) int voltage;//电压
@property (nonatomic, copy) NSString *carNumber;
@property (nonatomic, strong) BEnergyChargePayInfoModel *payInfoModel;
@property (nonatomic, assign) submitType submitButtonType;
@property (nonatomic, strong) BEnergyChargePayPopView *payPopView;
@property (nonatomic, strong) BEnergyRechargeViewModel *chargeViewModel;
@property (nonatomic, strong) BEnergyStubChargeDetailsModel *chargeDetailModel;
@property (nonatomic, strong) NSMutableArray <BEnergyPayTypeModel *> *typeArray;
@property (nonatomic, strong) BEnergyChargeStartHeadView *headView;
@property (nonatomic, strong) BEnergySystemInfoViewModel *systemInfoViewModel;
@property (nonatomic, strong) BEnergySystemInfoModel *systemInfoModel;
@property (nonatomic, copy) NSString *orderID;//微信订单编号 （全局设置，查询订单接口查询不到时，继续请求）
@property (nonatomic, strong) NSMutableDictionary *startChargeParam; //开始充电参数
@end

@implementation BEnergyPrepareChargeTableController

- (instancetype)init {
    return [BEnergyPrepareChargeTableController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setTranslucent:YES];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitDatas];
    
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
    
    //    [self popToPointViewController:NSStringFromClass([BEnergyHomeVc class])];
    
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
    
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

- (void)byEnergyInitDatas {}

- (void)byEnergyInitViews {
    
//    [self byEnergyNavItemWithImgeNames:@[@"btn_return_mine"]
//                                   isLeft:YES
//                                   target:self
//                                   action:@selector(backBtnClicked)
//                                     tags:@[]];
    
    self.navigationItem.title = @"确认充电";
//    self.navigationBarHiddenM = YES;
//    self.titleColorM = [UIColor whiteColor];
//    self.statusBarStyle = UIStatusBarStyleLightContent;
//    self.headView = [ByEnergyLoadViews loadViewFromNib:@"BEnergyChargeStartHeadView"];
//    self.headView.frame = CGRectMake(0, 0, SCREENWIDTH,  NavigationStatusBarHeight);
//    self.tableView.tableHeaderView = self.headView;
//    self.tableView.scrollEnabled = SCREENWIDTH == 320 ? YES : NO;
    self.tableView.backgroundColor = BYENERGYCOLOR(0xf5f5f5);
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyPayInfoCell bundle:nil] forCellReuseIdentifier:kBEnergyPayInfoCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyPrepareStubInfoCell bundle:nil] forCellReuseIdentifier:kBEnergyPrepareStubInfoCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyVoltageCell bundle:nil] forCellReuseIdentifier:kBEnergyVoltageCell];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    self.viewModel.stubId = self.stubId;
    RAC(self.viewModel,carNumber) = _RACObserve(self, carNumber);
    RAC(self.viewModel,voltageType) = _RACObserve(self, voltage);
    
    
    //获取充电页面数据
    [[[[self.viewModel.hnFetchChargesCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            self.tableView.hidden = NO;
            self.chargeDetailModel = x;
            [self fillStartChargeData];
        }
        [self.viewModel.hnChargeTypeCommand execute:nil];
        [self.systemInfoViewModel.hnSystemInfoCommand execute:nil];
        
    }];
    
    [self.viewModel.hnFetchChargesCommand execute:nil];
    
    
    //获取支付方式
    [[[[self.viewModel.hnChargeTypeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSDictionary *dic = x;
        self.payInfoModel = [BEnergyChargePayInfoModel mj_objectWithKeyValues:dic];
    }];

    
    [[self.viewModel.hnChargeTypeCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [HUDManager showStateHud:@"获取支付方式失败，请重试" state:HUDStateTypeFail];
    }];
    
    [[[[self.systemInfoViewModel.hnSystemInfoCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(BEnergySystemInfoModel *systemInfoModel) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            self.systemInfoModel = systemInfoModel;
            [self createPayTypeModelWithType:[systemInfoModel.auth.chargeType.value integerValue]];
        }
    }];

    //开始充电数据获取
    [[[[self.viewModel.hnStartChargeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [HUDManager hidenHud];
        if (self.viewModel.hnStartChargeCommand.result) {
            if (byEnergyIsValidStr([self.viewModel.hnStartChargeCommand.value platformError])) {
                [BEnergyCustomAlertView showAlertViewWithTitle:@"提示"
                                                        detail:[self.viewModel.hnStartChargeCommand.value platformError]
                                             buttonsTitleArray:@[@"稍后再说"]
                                               operationAction:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {}];
            }else {
                if ([self.viewModel.hnStartChargeCommand.value status] == 1 || [self.viewModel.hnStartChargeCommand.value status] == 9) {
                    [HUDManager showStateHud:@"连接成功"
                                       state:HUDStateTypeSuccess
                                     imgName:nil
                                  afterDelay:1.5
                                      onView:ByEnergyAppWindow
                             completionBlock:^{
                        BEnergyChargingTableViewController *vc = [[BEnergyChargingTableViewController alloc] init];
                        vc.orderId = [self.viewModel.hnStartChargeCommand.value id];
                        vc.isPopViewController = YES;
                        vc.duration = 1;
                        [self.navigationController pushViewController:vc animated:YES];
                    }];
                    
                }else {
                    [BEnergyCustomAlertView showAlertViewWithTitle:@"连接错误，请重试！"
                                                            detail:@""
                                                 buttonsTitleArray:@[@"我知道了"]
                                                   operationAction:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {}];
                }
            }
        }
    }];
    

    //发起充值
    [[[[self.chargeViewModel.hnMoneyChargeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            [self payWithOrderInfo:x platform:GDPayPlatformWeiXin];
        }
    }];
    
    //查询订单
    [[[[self.chargeViewModel.hnSearchOrderCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDictionary *dic) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            if ([dic isKindOfClass:[NSNull class]] || [dic isEqual:[NSNull null]]) {
                [HUDManager showStateHud:@"即充即退失败，请重试" state:HUDStateTypeFail];
                return;
            }
            if ( [dic isEqual:@""]) {
                [self.chargeViewModel.hnSearchOrderCommand execute:@{@"rechargeId":self.orderID}];
                return;
            }
            NSString *orderId = dic[@"orderId"];
            if (orderId.length > 0) {
                [self.payPopView viewHiden];
                BEnergyChargingTableViewController *vc = [[BEnergyChargingTableViewController alloc] init];
                vc.orderId = dic[@"orderId"];
                vc.isPopViewController = YES;
                vc.duration = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
    
    
    [[self.chargeViewModel.hnSearchOrderCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [HUDManager showStateHud:@"失败，请重试" state:HUDStateTypeFail];
    }];
}

- (void)fillStartChargeData {
    self.stubNameLabel.text = self.chargeDetailModel.name;
    self.carNumber = self.chargeDetailModel.carNumberList.count > 0 ?
    [self.chargeDetailModel.carNumberList firstObject] : @"";
    self.cardNumberLabel.text =  self.chargeDetailModel.carNumberList.count > 0 ?
    [self.chargeDetailModel.carNumberList firstObject] : @"暂无车牌信息";
    [self.tableView reloadData];
}

#pragma mark ----- tableViewDataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
         case 1:
            return self.typeArray.count + 1;
            break;
            case 2:
            case 3:
            case 4:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return indexPath.row == 0 ? 53.0f : 127.5f;
    }else if (indexPath.section == 1) {
        return indexPath.row == 0 ? 45.0f : 65.0f;
    }else if (indexPath.section == 2) {
        return self.chargeDetailModel.carNumberList.count > 0 ? 0.0f : 68.0f;
    }else if (indexPath.section == 4) {
        return 124.0f;
    }else {
        return self.chargeDetailModel.carNumberList.count > 0 ? 46.0f : 0.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        return 0.01f;
    }
    return 9.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? 5.0f : 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                return self.titleCell;
            }else {
                BEnergyPrepareStubInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyPrepareStubInfoCell];
                cell.model = self.chargeDetailModel;
                return cell;
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                return self.payInfoTitleCell;
            }else {
                BEnergyPayInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyPayInfoCell];
                cell.model = self.typeArray[indexPath.row - 1];
                return cell;
            }
            break;
        case 2:
            return  self.addCardNumberCell;
            break;
        case 3:
            return self.cardNumberInfoCell;
            break;
        case 4:
        {
            ByEnergyWeakSekf;
            BEnergyVoltageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyVoltageCell];
            [cell setSeleltVoltageButtonBlock:^(int tag) {
                ByEnergyStrongSelf;
                self.voltage = tag;
            }];
            return cell;
        }
            break;
        default:
            return [UITableViewCell new];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            for (int i = 0; i < self.typeArray.count; i ++) {
                if (i == indexPath.row - 1) {
                    self.typeArray[indexPath.row - 1].isSelect = YES;
                }else {
                    self.typeArray[i].isSelect = NO;
                }
            }
            
            if (self.typeArray[indexPath.row - 1].type == 1) {
                self.submitButtonType = submitTypePay;
            }else if (self.typeArray[indexPath.row - 1].type == 2) {
                self.submitButtonType = submitTypeCharge;
            }else {
                self.submitButtonType = submitTypeOrganization;
            }
            [self.submitChargeButton setTitle:self.submitButtonType == submitTypePay ? @"前往充值" : @"确认充电" forState:UIControlStateNormal];
            [self.tableView reloadData];
        }
    }else if (indexPath.section == 2) {
        [self addCardNumber];
    }
}

- (void)addCardNumber {
    BEnergyAddCarNumberViewController *vc = [[BEnergyAddCarNumberViewController alloc] init];
    vc.carNumber = @"琼";
    vc.isAddPlateNo = YES;
    ByEnergyWeakSekf
    [[vc.updateSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [self.viewModel.hnFetchChargesCommand execute:nil];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- action
- (IBAction)addCardNumberAgainButtonClick:(UIButton *)sender {
    [self addCardNumber];//重新添加车牌
}

- (IBAction)chooseCardNumberButtonClick:(UIButton *)sender {
    //选择车牌号
    ByEnergyWeakSekf
    [BRStringPickerView showStringPickerWithTitle:@""
                                       dataSource:self.chargeDetailModel.carNumberList
                                  defaultSelValue:self.carNumber
                                     isAutoSelect:NO
                                      resultBlock:^(id selectValue) {
        ByEnergyStrongSelf
        self.carNumber = selectValue;
        self.cardNumberLabel.text = self.carNumber;
        [self.tableView reloadData];
    }];
}

- (IBAction)submitChargeButtonClick:(UIButton *)sender {
    
    if (self.chargeDetailModel.isNeedCarNumber == 1 &&
        self.chargeDetailModel.carNumberList.count == 0) {
        [HUDManager showTextHud:@"请绑定车牌"];return;
    }
    
    
    if (self.submitButtonType == submitTypePay) {
        if (self.voltage == 24) {
            [BEnergyCustomAlertView showAlertViewWithTitle:@"您确定当前的车型适用于24V充电电压？"
                                               buttonArray:@[@"取消",@"确定"]
                                                     block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    [self goChargeMoney];
                }
            }];
        }else {
            [self goChargeMoney];
        }
        
    }else {
        if (self.voltage == 24) {
            [BEnergyCustomAlertView showAlertViewWithTitle:@"您确定当前的车型适用于24V充电电压？"
                                               buttonArray:@[@"取消",@"确定"]
                                                     block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    if (self.submitButtonType == submitTypeOrganization) {
                        [self.startChargeParam setObject:@(16) forKey:@"startType"];
                    }
                    [self.viewModel.hnStartChargeCommand execute:self.startChargeParam];
                }
            }];
            
        }else {
            if (self.submitButtonType == submitTypeOrganization) {
                [self.startChargeParam setObject:@(16) forKey:@"startType"];
            }
            [self.viewModel.hnStartChargeCommand execute:self.startChargeParam];
        }
    }
}

- (void)goChargeMoney {
    self.payPopView.model = self.payInfoModel;
    [self.payPopView viewShow];
}

//支付
- (void)payWithOrderInfo:(BEnergyTradeInfoModel *)oderInfo platform:(GDPayPlatform)platform {
    [[NSUserDefaults standardUserDefaults] setObject:oderInfo.id forKey:@"orderId"];
    [[NSUserDefaults standardUserDefaults] setObject:oderInfo.tradeNo forKey:@"tradeNo"];
    __weak typeof(self) weakSelf = self;
    if (byEnergyIsNilOrNull(oderInfo) == NO) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appScheme = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        [ByEnergyPayHandler payForOrder:oderInfo
                         platform:platform
                   viewController:self
                        urlScheme:appScheme
                       completion:^(NSString *result, NSString *errorStr) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.orderID = oderInfo.id;
                NSDictionary *param = @{@"rechargeId":oderInfo.id};
                [weakSelf.chargeViewModel.hnSearchOrderCommand execute:param];
            });
        }];
    }
}

- (void)createPayTypeModelWithType:(long)type {
    
    
    BEnergyPayTypeModel *one = [[BEnergyPayTypeModel alloc] init];
    one.type = 1;
    one.payTitle = @"即充即退";
    one.payTypeIcon = @"payTypenowIcon";
    one.payDescrib = @"(预付金额，充满自停，余额自动返还)";
    
    BEnergyPayTypeModel *two = [[BEnergyPayTypeModel alloc] init];
    two.type = 2;
    two.payTitle = @"余额充电";
    two.payTypeIcon = @"payTypeMIcon";
    two.payDescrib = [NSString stringWithFormat:@"账户余额:%.2f元",self.payInfoModel.userAmount];
    
    BEnergyPayTypeModel *three = [[BEnergyPayTypeModel alloc] init];
    three.type = 3;
    three.payTitle = @"机构充电";
    three.payTypeIcon = @"institutions";
    three.payDescrib = self.chargeDetailModel.organizationChargeInfo;
    
    if (self.typeArray.count > 0) {
        [self.typeArray removeAllObjects];
    }
    
    if (self.chargeDetailModel.organizationStatus == 0 || self.chargeDetailModel.organizationStatus == 2) {
        if (type == 0) { //即充即退和余额充值
            one.isSelect = YES;
            [self.typeArray addObject:one];
            [self.typeArray addObject:two];
            self.submitButtonType = submitTypePay;
            [self.submitChargeButton setTitle: @"前往充值" forState:UIControlStateNormal];
        }else if (type == 1) { //即充即退
            one.isSelect = YES;
            [self.typeArray addObject:one];
            self.submitButtonType = submitTypePay;
            [self.submitChargeButton setTitle: @"前往充值" forState:UIControlStateNormal];
        }else if(type == 2) { //余额充值
            two.isSelect = YES;
            [self.typeArray addObject:two];
            self.submitButtonType = submitTypeCharge;
            [self.submitChargeButton setTitle: @"确认充电" forState:UIControlStateNormal];
        }else{
            if (self.chargeDetailModel.organizationStatus == 2) {
                three.isSelect = YES;
                self.submitButtonType = submitTypeOrganization;
                [self.submitChargeButton setTitle: @"确认充电" forState:UIControlStateNormal];
            }
        }
        
        if (self.chargeDetailModel.organizationStatus == 2) {
            [self.typeArray addObject:three];
        }
        
    }else if (self.chargeDetailModel.organizationStatus == 1) {
        [self.typeArray addObject:three];
        three.isSelect = YES;
        self.submitButtonType = submitTypeOrganization;
        [self.submitChargeButton setTitle: @"确认充电" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}

#pragma mark ----- LazyLoad
- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [NSMutableArray new];
    }
    return _datasArray;
}

- (BEnergyRechargeViewModel *)chargeViewModel {
    if (!_chargeViewModel) {
        _chargeViewModel = [BEnergyRechargeViewModel new];
    }
    return _chargeViewModel;
}

- (BEnergyChargeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [BEnergyChargeViewModel new];
    }
    return _viewModel;
}

- (BEnergyStubChargeDetailsModel *)chargeDetailModel {
    if (!_chargeDetailModel) {
        _chargeDetailModel = [BEnergyStubChargeDetailsModel new];
    }
    return _chargeDetailModel;
}

- (BEnergySystemInfoViewModel *)systemInfoViewModel {
    if (!_systemInfoViewModel) {
        _systemInfoViewModel = [BEnergySystemInfoViewModel new];
    }
    return _systemInfoViewModel;
}

- (NSMutableArray<BEnergyPayTypeModel *> *)typeArray {
    if (!_typeArray) {
        _typeArray = [[NSMutableArray alloc] init];
    }
    return _typeArray;
}

- (BEnergyChargePayInfoModel *)payInfoModel {
    if (!_payInfoModel) {
        _payInfoModel = [[BEnergyChargePayInfoModel alloc] init];
    }
    return _payInfoModel;
}

- (NSMutableDictionary *)startChargeParam {
    if (!_startChargeParam) {
        _startChargeParam = [[NSMutableDictionary alloc] init];
    }
    return _startChargeParam;
}

- (BEnergyChargePayPopView *)payPopView {
    if (!_payPopView) {
        _payPopView = [[BEnergyChargePayPopView alloc] init];
        ByEnergyWeakSekf;
        [_payPopView setCommitButtonkBlock:^(ChargeTypeModel * _Nonnull chargeTypeModel, ChargeMoneyModel * _Nonnull moneyModel) {
            ByEnergyStrongSelf;
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:NSStringFormat(@"%@",moneyModel.value) forKey:@"price"];
            [params setObject:chargeTypeModel.type forKey:@"payType"];
            [params setObject:byEnergyClearNilStr([(BEnergyUserInfoModel *)[BEnergySCUserStorage sharedInstance].userInfo account]) forKey:@"destiAccount"];
            [params setObject:[NSNumber numberWithInt:8] forKey:@"useType"];
            [params setObject:@"" forKey:@"voucherIds"];
            [params setObject:@"0" forKey:@"refundToStarAccount"];
            if (byEnergyIsValidStr(self.stubId)) {
                [params setObject:self.stubId forKey:@"stubId"];
            }
            [params setObject:NSStringFormat(@"%d",self.voltage) forKey:@"voltageType"];
            [params setObject:byEnergyClearNilStr(self.carNumber) forKey:@"carNumber"];
            [params setObject:@"0" forKey:@"isBusiness"];
            [self.chargeViewModel.hnMoneyChargeCommand execute:params];
        }];
    }
    return _payPopView;
}
@end
