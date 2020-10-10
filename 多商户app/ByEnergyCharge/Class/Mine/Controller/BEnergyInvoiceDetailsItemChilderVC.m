//
//  BEnergyInvoiceDetailsItemChilderVC.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceDetailsItemChilderVC.h"
#import "BEnergyInvoiceDetailsViewController.h"
#import "BEnergyInvoiceDetailsItemCell.h"
#import "BEnergyApplyForInvoiceViewModel.h"
#import "BEnergyInvoiceSortModel.h"

@interface BEnergyInvoiceDetailsItemChilderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BEnergyApplyForInvoiceViewModel *applyForInvoiceViewModel;

@end

@implementation BEnergyInvoiceDetailsItemChilderVC

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self byEnergyInitViews];
    [self byEnergySetViewLayout];
    [self byEnergyInitViewModel];
}

- (void)byEnergyInitViews {
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    self.tableView.separatorColor = UIColor.byEnergyLineGray;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.loadEmptyType = SCLoadEmptyTypeNoInvoice;
    [self.view addSubview:self.tableView];
    
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
        make.top.mas_equalTo(NomalNavBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    self.applyForInvoiceViewModel.status = NSStringFormat(@"%d",self.statusType);
    [[[[self.applyForInvoiceViewModel.hnInvoiceSortCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    }];
    
    [[self.applyForInvoiceViewModel.hnInvoiceSortCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [self.tableView endRefreshing];
    }];
    
    self.tableView.viewModel = self.applyForInvoiceViewModel;
    kWeakSelf(self);
    self.tableView.headerRefreshingBlock = ^{
        [weakself.applyForInvoiceViewModel.hnInvoiceSortCommand execute:nil];
    };
    
    self.tableView.footerRefreshingBlock = ^{
        [weakself.applyForInvoiceViewModel.hnInvoiceSortCommand execute:nil];
    };
    
    [self.tableView beginRefreshing];
}

#pragma mark -----懒加载-----
LCFLazyload(BEnergyApplyForInvoiceViewModel, applyForInvoiceViewModel)

#pragma mark -----TableViewDelegate && TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.applyForInvoiceViewModel.value count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"BEnergyInvoiceDetailsItemCell";
    BEnergyInvoiceDetailsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BEnergyInvoiceDetailsItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BEnergyInvoiceSortModel *model = [self.applyForInvoiceViewModel.value objectAtIndex:indexPath.row];
    model.statusType = self.statusType;
    [cell byEnergyFillCellDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BEnergyInvoiceDetailsViewController *vc = [[BEnergyInvoiceDetailsViewController alloc] init];
    vc.invoiceNum = byEnergyClearNilStr([[self.applyForInvoiceViewModel.value objectAtIndex:indexPath.row] invoiceNum]);
    vc.status = self.statusType;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}


@end
