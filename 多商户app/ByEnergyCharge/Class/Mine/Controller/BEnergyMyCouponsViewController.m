
//
//  BEnergyMyCouponsViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyMyCouponsViewController.h"
#import "BEnergyMyCouponsTableViewCell.h"
#import "BEnergyCouponsViewModel.h"
#import "BEnergyStubViewController.h"
#import "BEnergyStubGroupCityModel.h"

@interface BEnergyMyCouponsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BEnergyCouponsViewModel *couponsViewModel;
@end

@implementation BEnergyMyCouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self byEnergyInitViews];
    [self byEnergySetViewLayout];
    [self byEnergyInitViewModel];
}

- (void)byEnergyInitViews {
    self.navigationItem.title = self.state == 0 ? @"我的优惠券" : @"已失效优惠券";
    if (self.state == 0) {
        [self byEnergyNavItemWitnTitles:@[@"查看失效"] isLeft:NO target:self action:@selector(loseCoupons) tags:nil];
        UIButton *rightButtonItem = self.navigationItem.rightBarButtonItem.customView;
        [rightButtonItem setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#00BFE5"] forState:UIControlStateNormal];
        rightButtonItem.titleLabel.font = ByEnergyRegularFont(13);
    }
    self.view.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    self.isGrouped = YES;
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    CGRect frame = CGRectMake(0, 0, 0, CGFLOAT_MIN);
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:frame];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:frame];
    self.tableView.loadEmptyType = SCLoadEmptyTypeDefalt;
    [self.view addSubview:self.tableView];
    if (self.state == MyCouponsStateLose) {
        self.tableView.refreshFooternoMoreDataText = @"仿佛错过1个亿～";
    }
    
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)byEnergyInitViewModel {
    kWeakSelf(self);
    ByEnergyWeakSekf
    self.couponsViewModel.status = self.state;
    [[[[self.couponsViewModel.hnCouponListCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    }];
    
    [[self.couponsViewModel.hnCouponListCommand errors] subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView endRefreshing];
    }];
    
    self.tableView.viewModel = self.couponsViewModel;
    self.tableView.headerRefreshingBlock = ^{
        [weakself.couponsViewModel.hnCouponListCommand execute:nil];
    };
    
    self.tableView.footerRefreshingBlock = ^{
         [weakself.couponsViewModel.hnCouponListCommand execute:nil];
    };
    [self.tableView beginRefreshing];
}

#pragma mark -----TableViewDelegate && TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.couponsViewModel.value count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"BEnergyMyCouponsTableViewCell";
    BEnergyMyCouponsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BEnergyMyCouponsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    }
    cell.status = self.state;
    
    [cell byEnergyFillCellDataWithModel:[self.couponsViewModel.value objectAtIndex:indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//暂时去掉之前点击优惠券定位到具体能使用的充电桩位置
//    if (self.state == 0) {
//        [self pushBEnergyStubViewController];
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 127;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark ----- Action

- (void)loseCoupons {
    BEnergyMyCouponsViewController *vc = [[BEnergyMyCouponsViewController alloc] init];
    vc.state = MyCouponsStateLose;
    [self.navigationController pushViewController:vc animated:YES];
    
    //....
    SubscribeViewController *Subscribevc = [SubscribeViewController new];
    [Subscribevc showSheetStylePickerViewWithLastText:@"类别"];
    
    
}

//桩群列表
- (void)pushBEnergyStubViewController {
    BEnergyStubViewController *vc = [[BEnergyStubViewController alloc] init];
    BEnergyStubGroupCityModel *cityModel = [BEnergyStubGroupCityModel new];
    cityModel.city = [BEnergyAppStorage sharedInstance].userCityId;
    cityModel.name = [BEnergyAppStorage sharedInstance].userCityName;
    vc.selectedCity = cityModel;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -----懒加载-----
- (BEnergyCouponsViewModel *)couponsViewModel {
    if (!_couponsViewModel) {
        _couponsViewModel = [[BEnergyCouponsViewModel alloc] init];
    }
    return _couponsViewModel;
}
@end
