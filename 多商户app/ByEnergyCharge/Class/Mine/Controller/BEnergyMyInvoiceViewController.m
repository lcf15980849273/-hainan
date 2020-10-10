//
//  BEnergyMyInvoiceViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyMyInvoiceViewController.h"
#import "BEnergyApplyForInvoiceViewModel.h"
#import "BEnergyInvoiceDetailsItemViewController.h"
#import "BEnergyApplyInvoiceTableController.h"
@interface BEnergyMyInvoiceViewController ()
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *applyButton;
@property (nonatomic, strong) BEnergyApplyForInvoiceViewModel *applyForInvoiceViewModel;
@property (weak, nonatomic) IBOutlet UILabel *hasInvoiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *notInvoiceLabel;

@end

@implementation BEnergyMyInvoiceViewController

- (instancetype)init {
    return [BEnergyMyInvoiceViewController byEnergyLoadStoryboardFromStoryboardName];
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

- (void)byEnergyInitViews {
    self.tableView.tableFooterView = self.footerView;
    [self.footerView addSubview:self.applyButton];
    [self byEnergyNavItemWitnTitles:@[@"明细"] isLeft:NO target:self action:@selector(detailsBtnAct) tags:@[@(0)]];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergySetViewLayout {
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(104);
        make.width.mas_offset(SCREENWIDTH);
        make.top.mas_equalTo(SCREENHEIGHT - SafeAreaBottomHeight - NavigationStatusBarHeight - 104);
    }];
    
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(-27);
        make.left.mas_equalTo(27);
        make.bottom.mas_equalTo(-11);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[[self.applyForInvoiceViewModel.hnFetchInvoiceSumCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.applyForInvoiceViewModel.result) {
            self.hasInvoiceLabel.text = [NSString stringWithFormat:@"%@元",[self.applyForInvoiceViewModel.value objectForKey:@"readySum"]];
            self.notInvoiceLabel.text = [NSString stringWithFormat:@"%@元",[self.applyForInvoiceViewModel.value objectForKey:@"notReadySum"]];
        }
    }];
    [self.applyForInvoiceViewModel.hnFetchInvoiceSumCommand execute:nil];
}

#pragma mark -----Action-----
- (void)detailsBtnAct {
    BEnergyInvoiceDetailsItemViewController *vc = [[BEnergyInvoiceDetailsItemViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -----LazyLoad

LCFLazyload(BEnergyApplyForInvoiceViewModel, applyForInvoiceViewModel)

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = [UIColor whiteColor];
    }
    return _footerView;
}

- (UIButton *)applyButton {
    if (!_applyButton) {
        _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyButton.frame = CGRectMake(27, 0, self.footerView.width-54, 54);
        _applyButton.center = CGPointMake(self.footerView.width/2, (self.footerView.height/2)+8);
        _applyButton.adjustsImageWhenHighlighted = NO;
        _applyButton.backgroundColor = BYENERGYCOLOR(0x00BFE5);
        _applyButton.layer.cornerRadius = 5.0f;
        [_applyButton setTitle:@"申请开票" forState:UIControlStateNormal];
        [_applyButton setBackgroundImage:IMAGEWITHNAME(@"chargingBtn") forState:UIControlStateNormal];
        [_applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _applyButton.titleLabel.font = ByEnergyRegularFont(18);
        ByEnergyWeakSekf
        [[[_applyButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            BEnergyApplyInvoiceTableController *vc = [[BEnergyApplyInvoiceTableController alloc] init];
            [[vc.completeSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                [self.applyForInvoiceViewModel.hnFetchInvoiceSumCommand execute:nil];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _applyButton;
}


@end
