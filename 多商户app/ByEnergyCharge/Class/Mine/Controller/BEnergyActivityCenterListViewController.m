//
//  BEnergyActivityCenterListViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyActivityCenterListViewController.h"
#import "BEnergyActivityCenterListCell.h"
#import "BEnergyNoticeCenterViewModel.h"

@interface BEnergyActivityCenterListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)BEnergyNoticeCenterViewModel *noticeCenterViewModel;
@end

@implementation BEnergyActivityCenterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
}

- (void)byEnergyInitViews {
    
    self.navigationItem.title = @"活动中心";
    self.view.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f6f6"];
    
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyActivityCenterListCell bundle:nil] forCellReuseIdentifier:kBEnergyActivityCenterListCell];
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#f6f6f6"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.loadEmptyType = SCLoadEmptyTypeDefaltTwo;
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
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

- (void)fetchNoticeData {
    NSDictionary *tagInfo = @{@"city":[BEnergyAppStorage sharedInstance].userCityId,
                              @"useType":@(3),
                              @"isPopup":@(0)
    };
    
    [self.noticeCenterViewModel.hnActivityCommand execute:tagInfo];
}

- (void)byEnergyInitViewModel {
//    kWeakSelf(self);
//    self.tableView.headerRefreshingBlock = ^{
//        weakself.noticeCenterViewModel.page.PageIndex = 1;
//        [weakself fetchNoticeData];
//    };
    
    ByEnergyWeakSekf
    [[[[self.noticeCenterViewModel.hnActivityCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.noticeCenterViewModel.result) {
        }
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    }];
    
    [[self.noticeCenterViewModel.hnActivityCommand errors] subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView endRefreshing];
    }];

    self.tableView.viewModel = self.noticeCenterViewModel;
    self.tableView.headerRefreshingBlock = ^{
        ByEnergyStrongSelf
        self.noticeCenterViewModel.page.PageIndex = 1;
        [self fetchNoticeData];
    };
    
    self.tableView.footerRefreshingBlock = ^{
        ByEnergyStrongSelf
        [self fetchNoticeData];
    };
    [self.tableView beginRefreshing];
}

#pragma mark ----- tableViewDelegate Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticeCenterViewModel.datasArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 224.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BEnergyActivityCenterListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyActivityCenterListCell];
    cell.model = self.noticeCenterViewModel.datasArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BEnergyNoticeCenterModel *model = self.noticeCenterViewModel.datasArray[indexPath.row];
    if (model.refType == 1) {
        [self showWebWithpath:nil params:nil baseUrl:byEnergyClearNilStr(model.srcUrl) titleStr:@"" navigationController:self.navigationController];
    }
}

#pragma mark ----- pushWebView
- (void)showWebWithpath:(NSString *)pathStr
                 params:(NSDictionary *)params
                baseUrl:(NSString *)baseUrl
               titleStr:(NSString *)titleStr
   navigationController:(UINavigationController *)navigationController{
    
    ByEnergyBaseWebVc *vc = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:pathStr
                                                                           title:titleStr
                                                                         baseUrl:URL_BASE
                                                                          params:params];
    vc.byEnergyRefreshEnabled = NO;
    vc.byEnergyRefreshEnabled = NO;
    vc.byEnergyHideProgress = NO;
    vc.byEnergyHideLoading = NO;
    [navigationController pushViewController:vc animated:YES];
    
    //....
    SubscribeViewController *Subscribvc = [SubscribeViewController new];
    [Subscribvc showSheetStylePickerViewWithLastText:@"类别"];
}

#pragma mark - LazyLoad
LCFLazyload(BEnergyNoticeCenterViewModel, noticeCenterViewModel);


@end
