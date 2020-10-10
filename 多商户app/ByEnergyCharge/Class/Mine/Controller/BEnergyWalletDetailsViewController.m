//
//  BEnergyWalletDetailsViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyWalletDetailsViewController.h"
#import "BEnergyWalletDetailsCell.h"
#import "BEnergyAmountDetailViewModel.h"

@interface BEnergyWalletDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BEnergyAmountDetailViewModel *amountDetailViewModel;

@end

@implementation BEnergyWalletDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)byEnergyInitViews {
    self.navigationItem.title = @"余额明细";
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColor.byEnergyLineGray;
    self.tableView.loadEmptyType = SCLoadEmptyTypeNoCapital;
    [self.view addSubview:self.tableView];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergySetViewLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[[self.amountDetailViewModel.hnUserAmountDetailCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    }];
    
    [[self.amountDetailViewModel.hnUserAmountDetailCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [self.tableView endRefreshing];
    }];
    kWeakSelf(self);
    self.tableView.viewModel = self.amountDetailViewModel;
    self.tableView.headerRefreshingBlock = ^{
        [weakself.amountDetailViewModel.hnUserAmountDetailCommand execute:nil];
    };
    
    self.tableView.footerRefreshingBlock = ^{
        [weakself.amountDetailViewModel.hnUserAmountDetailCommand execute:nil];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.amountDetailViewModel.value count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"BEnergyWalletDetailsCell";
    BEnergyWalletDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BEnergyWalletDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell byEnergyFillCellDataWithModel:[self.amountDetailViewModel.value objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark -----LazyLoad
LCFLazyload(BEnergyAmountDetailViewModel, amountDetailViewModel)
@end
