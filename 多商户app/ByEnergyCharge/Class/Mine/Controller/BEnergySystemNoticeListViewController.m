//
//  BEnergySystemNoticeListViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergySystemNoticeListViewController.h"
#import "BEnergySystemNoticeListCell.h"
#import "BEnergyNoticeCenterViewModel.h"
@interface BEnergySystemNoticeListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)BEnergyNoticeCenterViewModel *noticeCenterViewModel;
@end

@implementation BEnergySystemNoticeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
    
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
}

- (void)byEnergyInitViews {
    
    self.navigationItem.title = @"系统公告";
    self.view.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f6f6"];
    
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergySystemNoticeListCell bundle:nil] forCellReuseIdentifier:kBEnergySystemNoticeListCell];
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f6f6"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.loadEmptyType = SCLoadEmptyTypeDefaltTwo;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    
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
        make.top.left.right.mas_offset(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

- (void)createParams {
    self.noticeCenterViewModel.page.PageIndex = 1;
    NSDictionary *tagInfo = @{@"city":[BEnergyAppStorage sharedInstance].userCityId,
                            @"useType":@(2),
                            @"isPopup":@(0)
    };
    
    [self.noticeCenterViewModel.hnSystemNoticeCommand execute:tagInfo];
}

- (void)byEnergyInitViewModel {
    kWeakSelf(self);
    self.tableView.headerRefreshingBlock = ^{
        [weakself createParams];
    };
    
    ByEnergyWeakSekf
    [[[[self.noticeCenterViewModel.hnSystemNoticeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.noticeCenterViewModel.result) {
        }
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    }];
    
    [[self.noticeCenterViewModel.hnSystemNoticeCommand errors] subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView endRefreshing];
    }];
    
    self.tableView.viewModel = self.noticeCenterViewModel;
    self.tableView.headerRefreshingBlock = ^{
        ByEnergyStrongSelf
        self.noticeCenterViewModel.page.PageIndex = 1;
        [self createParams];
    };
    
    self.tableView.footerRefreshingBlock = ^{
        ByEnergyStrongSelf
        [self createParams];
    };
    [self.tableView beginRefreshing];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
}

#pragma mark ----- tableViewDelegate Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticeCenterViewModel.datasArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 171.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BEnergySystemNoticeListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergySystemNoticeListCell];
    cell.model = self.noticeCenterViewModel.datasArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
}

#pragma mark - LazyLoad

LCFLazyload(BEnergyNoticeCenterViewModel, noticeCenterViewModel);
@end
