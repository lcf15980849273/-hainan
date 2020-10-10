//
//  BEnergyApplyInvoiceTableController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/1.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyApplyInvoiceTableController.h"
#import "BEnergyInvoiceSelectedViewController.h"
#import "BEnergyApplyForInvoiceViewModel.h"
#import "UILabel+FitLines.h"

#define tips @"请确保您的开票信息准确无误，申请后工作人员将于1~3个工作日审核，审核通过后将直接邮寄给您，您确定是否开票？"
@interface BEnergyApplyInvoiceTableController ()
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) BEnergyApplyForInvoiceViewModel *applyForInvoiceViewModel;
@property (nonatomic, copy) NSString *amount;//开票金额
@property (weak, nonatomic) IBOutlet UILabel *invoiceAmountLabel;//金额Label
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;//地址
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;//收票人姓名
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;//手机号码
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;//发票抬头
@property (weak, nonatomic) IBOutlet UITextField *taxpayersTextField;//纳税人识别号
@property (weak, nonatomic) IBOutlet UITextView *tipsTextView;//温馨提示
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipsTextViewHeight; //textView高度
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *enterpriceButton;
@property (weak, nonatomic) IBOutlet UIButton *personalButton;
@end

@implementation BEnergyApplyInvoiceTableController

- (instancetype)init {
    return [BEnergyApplyInvoiceTableController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitDatas];
    
    [self byEnergyInitViews];
    
    [self byEnergyInitViewModel];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses removeObject:[UITableViewController class]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[UITableViewController class]];
}

- (void)byEnergyInitDatas {
    self.navigationItem.title = @"开具发票";
    [self.params setObject:@"4" forKey:@"invoiceType"];//初始化开票为公司（4:公司，3:个人）
}

- (void)byEnergyInitViews {
    self.isGrouped = YES;
    self.enterpriceButton.selected = YES;
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[self.applyForInvoiceViewModel.hnInvoiceApplyCommand.executionSignals switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.applyForInvoiceViewModel.result) {
            [HUDManager showStateHud:@"申请成功" state:HUDStateTypeSuccess];
            [self.completeSubject sendNext:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [[[[self.applyForInvoiceViewModel.hnInvoiceTipsCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.applyForInvoiceViewModel.result) {
            NSString *text = byEnergyClearNilStr([self.applyForInvoiceViewModel.value objectForKey:@"title"]);
            for (NSDictionary *dic in [self.applyForInvoiceViewModel.value objectForKey:@"info"]) {
                text = NSStringFormat(@"%@\n\n%@",text,[dic objectForKey:@"value"]);
            }
            self.tipsTextView.text = text;
            CGFloat height = [StringUtils getSpaceLabelHeight:self.tipsTextView.text withFont:ByEnergyRegularFont(16) withWidth:SCREENWIDTH - 40];
            self.tipsTextViewHeight.constant = height;
            self.footerView.zm_height = height + 75.0f;
            [self.tableView reloadData];
        }
    }];
    [self.applyForInvoiceViewModel.hnInvoiceTipsCommand execute:nil];
}

#pragma mark ----- tableViewDelegateDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return self.enterpriceButton.selected ? 3 : 2;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    label.textColor = [UIColor colorByEnergyWithBinaryString:@"#757575"];
    label.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    label.font = ByEnergyRegularFont(14);
    switch (section) {
        case 1:
            label.text = @"基本信息";
            break;
        case 2:
            label.text = @"发票抬头";
            break;
        default:
            label.text = @"";
            break;
    }
    label.firstLineHeadIndent = 20.0f;
    return label;
}

#pragma mark ----- action

- (IBAction)chooseButtonClick:(UIButton *)sender {
    BEnergyInvoiceSelectedViewController *vc = [[BEnergyInvoiceSelectedViewController alloc] init];
    if ([self.params objectForKey:@"orderIdList"]) {
        NSString *orderIdListStr = [self.params objectForKey:@"orderIdList"];
        vc.orderIdList = [[orderIdListStr componentsSeparatedByString:@","] mutableCopy];
    }
    
    ByEnergyWeakSekf
    [vc.selectSubject subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        NSDictionary *dic = (NSDictionary *)x;
        self.amount = dic[@"money"];
        self.invoiceAmountLabel.text = [NSString stringWithFormat:@"%@元",dic[@"money"]];
        [self.params setObject:byEnergyClearNilStr(dic[@"orderIdList"]) forKey:@"orderIdList"];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)enterpriseButtonClick:(UIButton *)sender {
    sender.selected = YES;
    self.personalButton.selected = NO;
    self.companyNameTextField.placeholder = @"请输入您的公司全称";
    [self.params setObject:@"4" forKey:@"invoiceType"];
    [self.tableView reloadData];
//    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];

   //....
   FirstTableView *tab = [FirstTableView new];
   [tab createServiceData];
   [tab byEnergyWithLoadfistTableViewLoaclData];
   SecondTableView *sec = [SecondTableView new];
   [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
   [sec refreshByEnergySecondTableData];
}

- (IBAction)personalButtonClick:(UIButton *)sender {
    sender.selected = YES;
    self.enterpriceButton.selected = NO;
    [self.params setObject:@"3" forKey:@"invoiceType"];
    self.companyNameTextField.placeholder = @"请输入发票抬头";
    [self.tableView reloadData];
//    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)submitButtonClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if (!byEnergyIsValidStr(self.addressTextField.text)) {
        [HUDManager showTextHud:@"请输入您的收票地址"];return;
    }
    if (!byEnergyIsValidStr(self.nameTextField.text)) {
        [HUDManager showTextHud:@"请输入发票接收人姓名"];return;
    }
    if (!byEnergyIsValidStr(self.phoneTextFiled.text)) {
        [HUDManager showTextHud:@"请输入发票接收手机号码"];return;
    }
    if (![StringUtils validateContactNumber:self.phoneTextFiled.text]) {
        [HUDManager showTextHud:@"请输入正确的手机号码"];return;
    }
    if (self.enterpriceButton.selected) {
        if (!byEnergyIsValidStr(self.companyNameTextField.text)) {
            [HUDManager showTextHud:@"请输入发票抬头"];return;
        }
        if (!byEnergyIsValidStr(self.taxpayersTextField.text)) {
            [HUDManager showTextHud:@"请输入纳税人识别号"];return;
        }
    }
    else {
        if (!byEnergyIsValidStr(self.companyNameTextField.text)) {
            [HUDManager showTextHud:@"请输入发票抬头"];return;
        }
    }

    [self.params setObject:self.addressTextField.text forKey:@"address"];
    [self.params setObject:self.taxpayersTextField.text forKey:@"corporationNum"];
    [self.params setObject:self.amount forKey:@"money"];
    [self.params setObject:self.nameTextField.text forKey:@"name"];
    [self.params setObject:self.phoneTextFiled.text forKey:@"phone"];
    [self.params setObject:self.companyNameTextField.text forKey:@"title"];
    
    [BEnergyCustomAlertView showAlertViewWithTitle:@"确认开票？"
                                            detail:tips
                                 buttonsTitleArray:@[@"取消",@"开票"]
                                   operationAction:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
             [self.applyForInvoiceViewModel.hnInvoiceApplyCommand execute:self.params];
        }
    }];
}


#pragma mark ----- Lazyload
LCFLazyload(NSMutableDictionary, params)
LCFLazyload(BEnergyApplyForInvoiceViewModel, applyForInvoiceViewModel)

@end
