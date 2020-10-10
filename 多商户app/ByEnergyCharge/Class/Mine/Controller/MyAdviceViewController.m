//
//  MyAdviceViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

///  
#import "MyAdviceViewController.h"
#import "BEnergyMyFeedBackListCell.h"
#import "AddAdviceViewController.h"
#import "BEnergyFeedBackViewModel.h"
@interface MyAdviceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BEnergyFeedBackViewModel *FeedBackViewModel;
@end

@implementation MyAdviceViewController

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
    
    self.navigationItem.title = @"我的反馈";
    self.view.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f6f6"];
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyMyFeedBackListCell bundle:nil] forCellReuseIdentifier:kBEnergyMyFeedBackListCell];
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f6f6"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.loadEmptyType = SCLoadEmptyTypeDefalt;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
        make.top.left.right.mas_offset(0);
        make.bottom.mas_equalTo(- SafeAreaBottomHeight);
    }];
}

- (void)byEnergyFetchFeedBackList {
    
    NSMutableDictionary *tagInfo = [NSMutableDictionary dictionary];
    [self.FeedBackViewModel.hnMyFeedBackListCommand execute:tagInfo];
}

- (void)byEnergyInitViewModel {
    
    ByEnergyWeakSekf
    [[[[self.FeedBackViewModel.hnMyFeedBackListCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.FeedBackViewModel.result) {
            [self.tableView reloadData];
            [self.tableView endRefreshing];
        }
    }];
    
    [[self.FeedBackViewModel.hnMyFeedBackListCommand errors] subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView endRefreshing];
    }];
    
    self.tableView.viewModel = self.FeedBackViewModel;
    self.tableView.headerRefreshingBlock = ^{
        ByEnergyStrongSelf
        [self byEnergyFetchFeedBackList];
    };
    
    self.tableView.footerRefreshingBlock = ^{
        ByEnergyStrongSelf
        [self byEnergyFetchFeedBackList];
    };
    [self.tableView beginRefreshing];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

#pragma mark ----- tableViewDelegate Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.FeedBackViewModel.datasArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BEnergyMyFeedBackListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyMyFeedBackListCell];
    cell.model = self.FeedBackViewModel.datasArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddAdviceViewController *vc = [[AddAdviceViewController alloc] init];
    BEnergyMyFeedBackListModel *model = self.FeedBackViewModel.datasArray[indexPath.row];
    vc.feedBackId = model.id;
    vc.model = model;
    ByEnergyWeakSekf
    [vc setRefreshFeedBackListDataBlock:^{
        ByEnergyStrongSelf
        [self.tableView beginRefreshing];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LazyLoad

LCFLazyload(BEnergyFeedBackViewModel, FeedBackViewModel)
@end
