//
//  RepayAdvanceViewController.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayAdvanceViewController.h"
#import "RepayBottomView.h"
#import "RepayAdvanceModel.h"
@interface RepayAdvanceViewController ()<RepayBottomViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *moneyLabl;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UIView *maskingView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *shouxuLabel;
@property (weak, nonatomic) IBOutlet UILabel *repaymentLabel;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *preiodLabel;
@property (nonatomic, strong) RepayBottomView *repayBottomView;
@property (nonatomic, strong) RepayAdvanceModel *advanceModel;
@end

@implementation RepayAdvanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getAdvanceRepayInfoData];
}

- (void)initDataAndViews {
    [self setViewShadowWithView:self.maskingView];
    [self setViewShadowWithView:self.bottomView];
    self.bottomView.layer.cornerRadius = self.bottomViewHeight.constant/2;
    self.commitButton.layer.cornerRadius = self.bottomViewHeight.constant/2;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshListData)
                                                 name:@"abc"
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
- (void)getAdvanceRepayInfoData {
//    [MBProgressHUD showMessage:nil];
//    [NetWorkHelp PostWithUrl:AdvancePrepayUrl
//                      IPRoot:IP_APIRootEnumCommon
//                      params:@{@"loan_id":self.loan_id}
//                     success:^(id  _Nonnull object) {
//                         [MBProgressHUD hideHUD];
//                         if ([object[RESPONSE_STATUS] isEqualToString:RESPONSE_SUCCESS_STATU]) {
//                             NSArray *array = object[KResponseResultKey];
//                             if (array.count > 0) {
//                                 self.emptyView.hidden = YES;
//                                 self.advanceModel = [RepayAdvanceModel yy_modelWithJSON:[array firstObject]];
//                                 [self fillAdvanceRepayData];
//                             }else {
//                                 self.emptyView.hidden = NO;
//                             }
//                         }else {
//                             self.emptyView.hidden = NO;
//                         }
//                     } failure:^(id  _Nonnull object) {
//                         self.emptyView.hidden = NO;
//                         [MBProgressHUD hideHUD];
//                     }];
}

- (void)fillAdvanceRepayData {
    self.moneyLabl.text = [NSString doubleReplaceWithNumber:self.advanceModel.principal];
    self.preiodLabel.text = [NSString stringWithFormat:@"共%@",self.advanceModel.undue_cnt];
    self.shouxuLabel.text = [NSString stringWithFormat:@"%@",[NSString doubleReplaceWithNumber:self.advanceModel.fee]];
    self.repaymentLabel.text = [NSString stringWithFormat:@"%@元",[NSString doubleReplaceWithNumber:self.advanceModel.amount]];
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


- (IBAction)commitButtonClick:(UIButton *)sender {
    [self getRepayAmountDataWithLoanId:self.advanceModel.loan_id type:@"pre" term:nil];
    
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

#pragma mark - 收到推送刷新页面
- (void)refreshListData {
    [self getAdvanceRepayInfoData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshListData" object:nil];
}
#pragma mark - LazyLoad
- (RepayBottomView *)repayBottomView {
    if (!_repayBottomView) {
        _repayBottomView = [[RepayBottomView alloc]initWithFrame:CGRectZero];
        _repayBottomView.delegate = self;
    }
    return _repayBottomView;
}

- (RepayAdvanceModel *)advanceModel {
    if (!_advanceModel) {
        _advanceModel = [RepayAdvanceModel new];
    }
    return _advanceModel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"abc" object:nil];
}
@end
