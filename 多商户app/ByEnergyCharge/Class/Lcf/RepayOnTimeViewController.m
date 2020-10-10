//
//  RepayOnTimeViewController.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayOnTimeViewController.h"
#import "RepayOnTimeListCell.h"
#import "RepayBottomView.h"
#import "RepayOnTimeModel.h"
#import "RecordRepayPlanViewController.h"
@interface RepayOnTimeViewController ()<UITableViewDelegate,UITableViewDataSource,RepayBottomViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *repayAllMoneyLabl;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UIView *maskingView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (nonatomic, strong) RepayBottomView *repayBottomView;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (nonatomic, strong) RepayOnTimeModel *repayOntimeModel;
@end

@implementation RepayOnTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];   
}

- (void)viewWillAppear:(BOOL)animated {
     [self getRepayInfoData];
}

- (void)initDataAndViews {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setViewShadowWithView:self.maskingView];
    [self setViewShadowWithView:self.bottomView];
    self.bottomView.layer.cornerRadius = self.bottomViewHeight.constant/2;
    self.commitButton.layer.cornerRadius = self.bottomViewHeight.constant/2;
    [self.tableView registerNib:[UINib nibWithNibName:kRepayOnTimeListCell bundle:nil]
         forCellReuseIdentifier:kRepayOnTimeListCell];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshListData)
                                                 name:@""
                                               object:nil];
}

- (void)setViewShadowWithView:(UIView *)view {
    view.layer.shadowOffset = CGSizeMake(0, 2);
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowRadius = 5;
    view.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                             green:0.0f/255.0f
                                              blue:0.0f/255.0f
                                             alpha:0.2].CGColor;
}

#pragma mark - request
- (void)getRepayInfoData {
    
//    [MBProgressHUD showMessage:nil];
//    [NetWorkHelp GetWithUrl:RepayListUrl
//                     IPRoot:IP_APIRootEnumCommon
//                     params:@{@"loan_id":self.loan_id}
//                    success:^(id  _Nonnull object) {
//                        [MBProgressHUD hideHUD];
//                        if ([object[RESPONSE_STATUS] isEqualToString:RESPONSE_SUCCESS_STATU]) {
//                            NSArray *array = object[KResponseResultKey];
//                            self.repayOntimeModel = [RepayOnTimeModel yy_modelWithJSON:[array firstObject]];
//                            self.emptyView.hidden = self.repayOntimeModel.list.count;
//                            self.timeLabel.text = [NSString stringWithFormat:@"%@）",[NSDate timestampSwitchTime:[self.repayOntimeModel.date intValue] andFormatter:@"MM月dd日"]];
//                            self.moneyLabl.text = [NSString doubleReplaceWithNumber:self.repayOntimeModel.amount];
//                            self.repayAllMoneyLabl.text = [NSString stringWithFormat:@"¥%@",[NSString doubleReplaceWithNumber:self.repayOntimeModel.total_amount]];
//                            [self.tableView reloadData];
//                        }else {
//                            self.emptyView.hidden = NO;
//                        }
//                    } failure:^(id  _Nonnull object) {
//                        self.emptyView.hidden = NO;
//                        [MBProgressHUD hideHUD];
//                    }];
}


- (void)getRepayAmountDataWithLoanId:(NSString *)loanid type:(NSString *)type term:(NSString *)term {
//    [MBProgressHUD showMessage:nil];
//    NSDictionary *param = @{
//                            @"loan_id":loanid,
//                            @"type":type,
//                            @"term":term.length > 0 ? term:@""
//                            };
//    [NetWorkHelp PostWithUrl:LoanAmountUrl
//                      IPRoot:IP_APIRootEnumCommon
//                      params:param
//                     success:^(id  _Nonnull object) {
//                         [MBProgressHUD hideHUD];
//                         if ([object[RESPONSE_STATUS] isEqualToString:RESPONSE_SUCCESS_STATU]) {
//                             NSArray *array = object[KResponseResultKey];
//                             if (array.count != 0) {
//                                 RepayBottomViewModel *model = [RepayBottomViewModel yy_modelWithJSON:[array firstObject]];
//                                 self.repayBottomView.model = model;
//                                 [self.repayBottomView ViewShow];
//                             }
//                         }
//                     } failure:^(id  _Nonnull object) {
//                         [MBProgressHUD hideHUD];
//                     }];
}

#pragma mark -
- (IBAction)commitButtonClick:(UIButton *)sender {
    if (self.repayOntimeModel.total_amount > 0) {
        [self getRepayAmountDataWithLoanId:self.repayOntimeModel.loan_id type:@"sum" term:nil];
    }else {
//        [MBProgressHUD showError:@""];
    }
}

#pragma mark - RepayBottomViewDelegate
- (void)commitRepayWithModel:(RepayBottomViewModel *)model {
    NSDictionary *param = @{
                            @"loan_id":model.loan_id,
                            @"type":model.repayType,
                            @"term":model.term.length > 0 ? model.term:@""
                            };
//    [MBProgressHUD showMessage:nil];
//    [NetWorkHelp PostWithUrl:HomeRepayUrl
//                      IPRoot:IP_APIRootEnumCommon
//                      params:param
//                     success:^(id  _Nonnull object) {
//                         [MBProgressHUD hideHUD];
//                         if ([object[RESPONSE_STATUS] isEqualToString:RESPONSE_SUCCESS_STATU]) {
//                             dispatch_async(dispatch_get_main_queue(), ^{
//                                 [MBProgressHUD showSuccess:object[@"error_message"]];
//                             });
//                         }
//                     } failure:^(id  _Nonnull object) {
//                         [MBProgressHUD hideHUD];
//                     }];
}

#pragma mark - 收到推送刷新列表
- (void)refreshListData {
    [self getRepayInfoData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshListData" object:nil];
}

#pragma mark - tableViewDelegate DataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepayOnTimeListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kRepayOnTimeListCell];
    cell.repayOntimeModel = self.repayOntimeModel;
//    cell.model = self.repayOntimeModel.list[indexPath.row];
//    if ([self.repayOntimeModel.list[indexPath.row].state isEqualToString:@""]) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }else {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
    
    [cell setShowRepayPlanBlock:^(RepayOnTimeListModel * _Nonnull model) {
        RecordRepayPlanViewController *vc = [RecordRepayPlanViewController new];
        vc.loanid = model.loan_id;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    RepayOnTimeListModel *listModel = self.repayOntimeModel.list[indexPath.row];
//    if (![listModel.state isEqualToString:@""]) {
//        [self getRepayAmountDataWithLoanId:listModel.loan_id type:listModel.type term:listModel.term];
//        
//    }
}

#pragma mark - LazyLoad
- (RepayBottomView *)repayBottomView {
    if (!_repayBottomView) {
        _repayBottomView = [[RepayBottomView alloc]initWithFrame:CGRectZero];
        _repayBottomView.delegate = self;
    }
    return _repayBottomView;
}

- (RepayOnTimeModel *)repayOntimeModel {
    if (!_repayOntimeModel) {
        _repayOntimeModel = [RepayOnTimeModel new];
    }
    return _repayOntimeModel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"" object:nil];
}
@end
