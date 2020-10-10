//
//  BEnergyApplyCashViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/4.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyApplyCashViewController.h"
#import "BEnergyApplyCashHeaderView.h"
#import "BRStringPickerView.h"
#import "BEnergyUserCashViewModel.h"
#import "BEnergyCashInfoModel.h"
#import "BEnergyApplyCashFooterView.h"
#import "BenergyApplyCashResultViewController.h"
@interface BEnergyApplyCashViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *reasonTextFiled;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) BEnergyApplyCashFooterView *footerView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) BEnergyApplyCashHeaderView *headerView;
@property (nonatomic, strong) BEnergyUserCashViewModel *userCashViewModel;
@property (nonatomic, copy) NSString *applyAmount;
@property (nonatomic, copy) NSString *reasonValue;
@end

@implementation BEnergyApplyCashViewController

- (instancetype)init {
    return [BEnergyApplyCashViewController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses removeObject:[UITableViewController class]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[UITableViewController class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self byEnergyInitDatas];
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

- (void)byEnergyInitDatas {}

- (void)byEnergySetViewLayout {

}

- (void)byEnergyInitViews {
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[[self.userCashViewModel.userCashInfoCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.userCashViewModel.result) {
            BEnergyCashInfoModel *model = self.userCashViewModel.value;
            self.headerView.amount = model.amount;
            NSString *text = NSStringFormat(@"%@",byEnergyClearNilStr(model.cashTips.title));
            for (Info *info in model.cashTips.info) {
                text = NSStringFormat(@"%@\n\n%@",text,info.value);
            }
            self.headerView.tipsLabel.text = model.cashAmountTips;
            self.footerView.textView.text = text;
            CGFloat height = [StringUtils getSpaceLabelHeight:self.footerView.textView.text withFont:ByEnergyRegularFont(14) withWidth:SCREENWIDTH - 40];
            self.footerView.height = height + 125;
            [self.tableView reloadData];
        }
    }];
    
    [[self.userCashViewModel.userCashInfoCommand errors] subscribeNext:^(NSError * _Nullable x) {
        
    }];
    
    [self.userCashViewModel.userCashInfoCommand execute:nil];
    
    [[[self.userCashViewModel.userCashApplyCommand.executionSignals switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.userCashViewModel.userCashApplyCommand.result) {
            [HUDManager showStateHud:@"申请成功" state:HUDStateTypeSuccess];
            ByEnergyReceivedNotification(ByEnergyUpdateUserInfo, nil);
            BenergyApplyCashResultViewController *vc = [[BenergyApplyCashResultViewController alloc] init];
            vc.applyAmount = [self.params objectForKey:@"applyAmount"];
            vc.aliPayAccount = [self.params objectForKey:@"aliPayAccount"];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [HUDManager showStateHud:@"申请失败" state:HUDStateTypeFail];
        }
    }];
    
    [[self.userCashViewModel.userCashApplyCommand errors] subscribeNext:^(NSError * _Nullable x) {
    }];
}

#pragma mark -----TableViewDelegate && TableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        __block NSArray *cashReasonList = [[self.userCashViewModel.value cashReason] objectAtIndex:0];
        [BRStringPickerView showStringPickerWithTitle:@""
                                           dataSource:cashReasonList
                                      defaultSelValue:@""
                                         isAutoSelect:NO
                                          resultBlock:^(id selectValue) {
            if ([cashReasonList indexOfObject:selectValue] != NSNotFound) {
                self.reasonTextFiled.text = selectValue;
                self.reasonValue = [[[self.userCashViewModel.value cashReason] objectAtIndex:1]
                                    objectAtIndex:[cashReasonList indexOfObject:selectValue]];
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark ----- applySubmit
- (void)applySubmit {
    [self.view endEditing:YES];
    NSString *showText = @"";
    if ([self.applyAmount floatValue] == 0) {
        [HUDManager showTextHud:@"请您输入大于0的提现金额"];return;
    }
    if (self.nameTextFiled.text.length == 0) {
        [HUDManager showTextHud:@"请输入您的支付宝真实姓名"];return;
    }
    if (self.accountTextField.text.length == 0) {
        [HUDManager showTextHud:@"请输入您的支付宝账号"];return;
    }
    if (self.reasonTextFiled.text.length == 0) {
        [HUDManager showTextHud:@"请选择提现原因"];return;
    }
    [self.params setObject:self.applyAmount forKey:@"applyAmount"];
    [self.params setObject:self.nameTextFiled.text forKey:@"aliPayName"];
    [self.params setObject:self.accountTextField.text forKey:@"aliPayAccount"];
    [self.params setObject:self.reasonValue forKey:@"cashReasonNum"];
    
    showText = NSStringFormat(@"金额：%@\n姓名：%@\n账号：%@",
    self.applyAmount,self.nameTextFiled.text,self.accountTextField.text);
    
    [BEnergyCustomAlertView showAlertViewWithAlignment:BDAlertViewTitleCenter
                                                 title:@"您是否确认提现?"
                                                detail:showText
                                     buttonsTitleArray:@[@"取消",@"提现"]
                                       operationAction:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self.userCashViewModel.userCashApplyCommand execute:self.params];
        }
    }
                               dismissWhenTouchOutside:NO];
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyUserCashViewModel, userCashViewModel)
LCFLazyload(NSMutableDictionary, params)
- (BEnergyApplyCashHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BEnergyApplyCashHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 200);
        RAC(self,applyAmount) = _RACObserve(_headerView, textField.text);
    }
    return _headerView;
}

- (BEnergyApplyCashFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[BEnergyApplyCashFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 115)];
        ByEnergyWeakSekf
        [_footerView setSubmitButtonBlock:^{
            ByEnergyStrongSelf
            [self applySubmit];
        }];
    }
    return _footerView;
}
@end
