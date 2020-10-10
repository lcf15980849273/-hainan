
//
//  BEnergyStubViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/15.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubViewController.h"
#import "BEnergyStubGroupViewModel.h"
#import "BEnergyStubGroupModel.h"
#import "BEnergyStubDetailViewController.h"
#import "ByEnergyScanManager.h"
#import "BEnergyStubListCell.h"

//.....
#import "RepayBottomView.h"
#import "coreGraphicsCustomView.h"
#import "CFAutoCellHeightCell.h"
@interface BEnergyStubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BEnergyStubGroupViewModel *stubGroupViewModel;
@end

@implementation BEnergyStubViewController

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
}

- (void)byEnergyInitViews {
    
    self.navigationItem.title = @"电站列表";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.loadEmptyType = SCLoadEmptyTypeDefalt;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 17, 0, 17);
    self.view.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"F6F4FA"];
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"F6F4FA"];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyStubListCell bundle:nil] forCellReuseIdentifier:kBEnergyStubListCell];
    
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
        make.bottom.mas_equalTo(- SafeAreaBottomHeight);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[[self.stubGroupViewModel.hnStubListCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.stubGroupViewModel.result) {
            [self.tableView reloadData];
            [self.tableView endRefreshing];
        }
    }];
    
    [[self.stubGroupViewModel.hnStubListCommand errors] subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView endRefreshing];
    }];
    
    kWeakSelf(self);
    self.tableView.viewModel = self.stubGroupViewModel;
    self.tableView.headerRefreshingBlock = ^{
        [weakself getStubGroupList];
    };
    
    self.tableView.footerRefreshingBlock = ^{
        [weakself getStubGroupList];
    };
    [self.tableView beginRefreshing];
}


#pragma mark -----TableViewDelegate && TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.stubGroupViewModel.datasArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorByEnergyWithBinaryString:@"F6F4FA"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BEnergyStubListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyStubListCell];
    cell.groupModel = [self.stubGroupViewModel.datasArray objectAtIndex:indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.stubGroupViewModel.datasArray.count > indexPath.row) {
        BEnergyStubGroupModel *stubGroup = self.stubGroupViewModel.datasArray[indexPath.section];
        BEnergyStubDetailViewController *vc = [[BEnergyStubDetailViewController alloc] init];
        vc.stubGroupID = stubGroup.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //......
    coreGraphicsCustomView *vc = [coreGraphicsCustomView new];
    [vc pushWithDefalutView];
}

#pragma mark ----- 导航
- (void)navBtnAtIndex:(NSIndexPath *)indexPath {
    int index = (int)indexPath.row;
    if ([self.stubGroupViewModel.datasArray count]<=index) {
        return;
    }
    BEnergyStubGroupModel *stubGroup = self.stubGroupViewModel.datasArray[index];
    [[BEnergyAppStorage sharedInstance] byEnergyOpenNaviWithLat:stubGroup.gisGcj02Lat
                                               destinationLng:stubGroup.gisGcj02Lng
                                              destinationName:stubGroup.name
                                              destinationView:self.view];
    
    
    //......
    coreGraphicsCustomView *vc = [coreGraphicsCustomView new];
    [vc pushWithDefalutView];
}

- (void)getStubGroupList {
    NSMutableDictionary *tagInfo = [NSMutableDictionary dictionary];
    [tagInfo addEntriesFromDictionary:[BEnergyAppStorage sharedInstance].locationTagInfo];
    [self.stubGroupViewModel.hnStubListCommand execute:tagInfo];
}

#pragma mark ------LazyLoad
LCFLazyload(BEnergyStubGroupViewModel, stubGroupViewModel)


@end
