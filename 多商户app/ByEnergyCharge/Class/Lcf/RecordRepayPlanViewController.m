//
//  RecordRepayPlanViewController.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RecordRepayPlanViewController.h"
#import "RecordRepayPlanListCell.h"
#import "RepayDetailPlanListModel.h"
@interface RecordRepayPlanViewController ()

@property (strong,nonatomic)NSMutableArray <RepayDetailPlanListModel *> *listModelArray;
@end

@implementation RecordRepayPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataAndViews];
}

- (void)viewDidLayoutSubviews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
        if(@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else {
            make.bottom.equalTo(self.view);
        }
    }];
}

- (void)initDataAndViews {
    self.title = @"";
//    self.dataNoDataView.noDataTitle = @"";
//    self.dataNoDataView.noDataImage = @"empty";
    [self.tableView.mj_header beginRefreshing];
//    self.tableView.backgroundColor = COLOR_HEX(0xedeeee);
    [self.tableView registerNib:[UINib nibWithNibName:kRecordRepayPlanListCell bundle:nil] forCellReuseIdentifier:kRecordRepayPlanListCell];
}

#pragma mark - request

- (void)loadMoreData {
    [self fetchRepayPlanListData];
}

- (void)refreshData {
//    self.currentPage = 1;
    self.listModelArray.count == 0 ?  : [self.listModelArray removeAllObjects];
    [self fetchRepayPlanListData];
}

- (void)fetchRepayPlanListData {
    
//    NSDictionary *param = @{@"loan_id":self.loanid,@"pn":@(self.currentPage)};
//    [NetWorkHelp GetWithUrl:MineLoanPlans
//                     IPRoot:IP_APIRootEnumCommon
//                     params:param
//                    success:^(id  _Nonnull object) {
//                        [self endLoading];
//                        if ([object[RESPONSE_STATUS] isEqualToString:RESPONSE_SUCCESS_STATU]) {
//                            NSArray *tempLoanArray = [NSArray yy_modelArrayWithClass:[RepayDetailPlanListModel class]
//                                                                                json:object[KResponseResultKey]];
//                            if (self.currentPage == 1) {
//                                self.listModelArray = [NSMutableArray arrayWithArray:tempLoanArray];
//                            }
//                            else {
//                                [self.listModelArray addObjectsFromArray:tempLoanArray];
//                            }
//                            if (![object[@"has_more"] doubleValue]) {
//                                [self.refreshFooter endRefreshingWithNoMoreData];
//                            }
//                            self.currentPage ++ ;
//                            self.showsDataNoDataView = !self.listModelArray.count;
//                            [self.tableView reloadData];
//                        }
//
//
//    } failure:^(id  _Nonnull object) {
//
//    }];
}

#pragma mark - tableViewDelegate DataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecordRepayPlanListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kRecordRepayPlanListCell];
    cell.model = self.listModelArray[indexPath.section];
    return cell;
}


#pragma mark - LazyLoad
- (NSMutableArray<RepayDetailPlanListModel *> *)listModelArray {
    if (!_listModelArray) {
        _listModelArray = [NSMutableArray new];
    }
    return _listModelArray;
}
@end
