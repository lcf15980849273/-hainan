//
//  BEnergyChargeOrderChilderVC.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/20.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargeOrderChilderVC.h"
#import "BEnergyChargeOrderDetailTableController.h"
#import "BEnergyChargingTableViewController.h"
#import "BEnergyChargeViewModel.h"
#import "AlertViewTools.h"
#import "BEnergyChargeListModel.h"
#import "BEnergyChargeOrderModel.h"

#import "BEnergyOrderFishCell.h"
#import "BEnergyOrderChargingCell.h"
//......
#import "BEnergyStubViewController.h"
#import "CFCALayerViewController.h"
#import "coreGraphicsCustomView.h"
#import "SecondTableView.h"
#import "CFAutoCellHeightViewController.h"
@interface BEnergyChargeOrderChilderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BEnergyChargeViewModel *chargeViewModel;

@end

@implementation BEnergyChargeOrderChilderVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self byEnergyInitViews];
    [self byEnergySetViewLayout];
    [self byEnergyInitViewModel];
    
}

- (void)byEnergyInitViews {
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f4fa"];
//    self.tableView.separatorColor = UIColor.byEnergyLineGray;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.loadEmptyType = SCLoadEmptyTypeNoOrder;
    [self.view addSubview:self.tableView];
    self.orderType = ChargeOrderTypeForChargeing;
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyOrderChargingCell bundle:nil] forCellReuseIdentifier:kBEnergyOrderChargingCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyOrderFishCell bundle:nil] forCellReuseIdentifier:kBEnergyOrderFishCell];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
    
}

- (void)byEnergySetViewLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NomalNavBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(- SafeAreaBottomHeight);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    if (self.orderType == ChargeOrderTypeForChargeing) {
        [[[[self.chargeViewModel.hnEndChargeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
            ByEnergyStrongSelf
            [HUDManager showLoadingHud:@"停止充电中..."];
            BEnergyChargeOrderModel *orderInfo = (BEnergyChargeOrderModel *)x;
            if (self.chargeViewModel.result) {
                [HUDManager showStateHud:@"充电结束"
                                   state:HUDStateTypeSuccess
                                 imgName:nil
                              afterDelay:1.5
                                  onView:ByEnergyAppWindow
                         completionBlock:^{
                    BEnergyChargeOrderDetailTableController *vc = [[BEnergyChargeOrderDetailTableController alloc] init];
                    vc.orderId = orderInfo.id;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
        }];
        
        [[self.chargeViewModel.hnEndChargeCommand errors] subscribeNext:^(NSError * _Nullable x) {
            ByEnergyStrongSelf
            [self.tableView endRefreshing];
        }];
    }
    
    [[[[self.chargeViewModel.hnOdderListCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
//        NSArray *array = x;
//        if (self.orderType == ChargeOrderTypeForChargeing) {
//            if (array.count != 0) {
//                [self.tabBarController.tabBar showOrHidenBadgeViewWithIndex:3 Flag:YES Count:array.count];
//            }else {
//                [self.tabBarController.tabBar hideBadgeOnItemIndex:3];
//            }
//        }
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    }];
    
    [[self.chargeViewModel.hnOdderListCommand errors] subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView endRefreshing];
    }];
    self.tableView.viewModel = self.chargeViewModel;
    self.tableView.headerRefreshingBlock = ^{
        ByEnergyStrongSelf
        self.chargeViewModel.type = self.orderType;
        [self.chargeViewModel.hnOdderListCommand execute:nil];
    };
    
    self.tableView.footerRefreshingBlock = ^{
        ByEnergyStrongSelf
        self.chargeViewModel.type = self.orderType;
        [self.chargeViewModel.hnOdderListCommand execute:nil];
    };
    
    [self.tableView beginRefreshing];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}


#pragma mark -----TableViewDelegate && TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.chargeViewModel.value count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 5.0f : 00.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorByEnergyWithBinaryString:@"f6f4fa"];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorByEnergyWithBinaryString:@"f6f4fa"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.orderType) {
        case ChargeOrderTypeForFinish:
            return 123;
            break;
        case ChargeOrderTypeForChargeing:
            return 110;
            break;
        case ChargeOrderTypeForWaitPay:
            return 155;
            break;
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BEnergyChargeListModel *model = [self.chargeViewModel.value objectAtIndex:indexPath.section];
    model.chargeListOrderType = self.orderType;
    if (self.orderType == ChargeOrderTypeForChargeing) {
        BEnergyOrderChargingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyOrderChargingCell];
        ByEnergyWeakSekf
        [cell setStopChargingBlock:^{
            ByEnergyStrongSelf
            [self carChargeEnd:model.outOrderId];
        }];
        cell.chargeListModel = model;
        return cell;
        
    }else if (self.orderType == ChargeOrderTypeForFinish) {
        BEnergyOrderFishCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyOrderFishCell];
        cell.chargeListModel = model;
        return cell;
    }else {
        return [UITableViewCell new];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.orderType == ChargeOrderTypeForFinish) {
        BEnergyChargeOrderDetailTableController *vc = [[BEnergyChargeOrderDetailTableController alloc] init];
        vc.orderId = [[self.chargeViewModel.value objectAtIndex:indexPath.section] orderId];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.orderType == ChargeOrderTypeForChargeing) {
        BEnergyChargingTableViewController *vc = [[BEnergyChargingTableViewController alloc] init];
        vc.isUserInitiative = YES;
        vc.orderId = [[self.chargeViewModel.value objectAtIndex:indexPath.section] orderId];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.orderType == ChargeOrderTypeForWaitPay) {
        [self unpaidOrder:[[self.chargeViewModel.value objectAtIndex:indexPath.section] orderId]];
    }
}

- (void)carChargeEnd:(NSString *)outOrderId {

    [BEnergyCustomAlertView showAlertViewWithTitle:@"确定停止充电吗？"
                                       buttonArray:@[@"按错了",@"确定"]
                                             block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        if (buttonIndex == 1 ) {
            [self.chargeViewModel.hnEndChargeCommand execute:@{@"chargeId":byEnergyClearNilStr(outOrderId)}];
        }
    }];
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc showSheetStylePickerViewWithLastText:@"类别"];
}

- (void)unpaidOrder:(NSString *)outOrderId {
//    BEnergyWaitingPayViewController *vc = [[BEnergyWaitingPayViewController alloc] init];
//    vc.orderId = outOrderId;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)refreshDatas {
    [self.tableView beginRefreshing];
}

#pragma mark ----LazyLoad

- (BEnergyChargeViewModel *)chargeViewModel {
    if (!_chargeViewModel) {
        _chargeViewModel = [[BEnergyChargeViewModel alloc] init];
    }
    return _chargeViewModel;
}
@end
