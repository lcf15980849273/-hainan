//
//  RepayViewController.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/8/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayViewController.h"
#import "RepayListHeaderView.h"
#import "RepayListCell.h"
#import "RepayModel.h"
#import "RepaymentViewController.h"
@interface RepayViewController ()
@property (nonatomic, strong) RepayModel *repayModel;
@property (nonatomic, strong) RepayListHeaderView *headerView;
@end

@implementation RepayViewController

- (void)viewDidLoad {
//    self.style = UITableViewStylePlain;
    [super viewDidLoad];
    
    [self initDataAndViews];
    
//    [self.refreshHeader beginRefreshing];
}

- (void)initDataAndViews {
    self.title = @"";
//    self.refreshFooter.hidden = YES;
//    self.dataNoDataView.noDataTitle = @"";
//    self.dataNoDataView.noDataImage = @"empty";
    self.view.backgroundColor = BYENERGYCOLOR(0xf8f8f8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).offset(0);
        make.height.mas_offset(SCREENHEIGHT);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:kRepayListCell bundle:nil] forCellReuseIdentifier:kRepayListCell];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetRepayListData) name:@"refreshListData" object:nil];
    //    [NSNotificationCenter addNotificationForName:LSLoanStateChangeNotification target:self action:@selector(fetRepayListData)];
}

- (void)fetRepayListData {
    
//    [NetWorkHelp GetWithUrl:RepayCenterURL
//                     IPRoot:IP_APIRootEnumCommon
//                     params:@{}
//                    success:^(id  _Nonnull object) {
//                        [self.refreshHeader endRefreshing];
//                        self.repayModel = [RepayModel yy_modelWithJSON:object[@"results"]];
//                        self.showsDataNoDataView = !self.repayModel.list.count;
//                        self.headerView.model = self.repayModel;
//                        [self.tableView reloadData];
//                    } failure:^(id  _Nonnull object) {
//                        self.showsDataNoDataView = YES;
//                        [self.refreshHeader endRefreshing];
//                    }];
}

- (void)refreshData {
    [self fetRepayListData];
}

#pragma mark - tableViewDelegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repayModel.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 255.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepayListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kRepayListCell];
    cell.model = self.repayModel.list[indexPath.row];
    [cell setRepayButtonBLock:^(RepayListModel * _Nonnull model) {
        RepaymentViewController *vc = [RepaymentViewController new];
        vc.loan_id = model.loan_id;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}

#pragma mark - lazyLoad
- (RepayModel *)repayModel {
    if (!_repayModel) {
        _repayModel = [RepayModel new];
    }
    return _repayModel;
}

- (RepayListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[RepayListHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
    }
    return _headerView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshListData" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"" object:nil];
}
@end
