
//
//  BEnergyAddCarNumberViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyAddCarNumberViewController.h"
#import "CarNumberView.h"
#import "CarNumberModel.h"
#import "IQKeyboardManager.h"
#import "UIButton+HitRec.h"
#import "BEnergyCarNumberViewModel.h"

@interface BEnergyAddCarNumberViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UILabel *detailLabel;
//@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, assign) BOOL isNewEnergyCar;
@property (nonatomic, strong) CarNumberView *carNumberView;
@property (nonatomic, strong) UISwitch *switchButton;
@property (nonatomic, strong) UILabel *defaultLabel;
@property (nonatomic, strong) CarNumberModel *carNumberModel;
@property (nonatomic, strong) BEnergyCarNumberViewModel *carNumberViewModel;
@property (nonatomic, assign) BOOL defaultCarType;
@end

@implementation BEnergyAddCarNumberViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self byEnergyInitViews];
    [self byEnergyInitDatas];
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

- (void)loadViewIfNeeded {
    [super loadViewIfNeeded];
//    self.checkBtn.hitEdgeInsets = UIEdgeInsetsMake(-15, -20, -15, -20);
}


- (void)byEnergyInitDatas {
//    if (self.isAddPlateNo) {
//        self.carNumberModel.items = 8;
//    }else {
//        self.carNumberModel.items = self.carNumber.length + 1;
//    }
    
    self.defaultCarType = YES;
    if (self.isAddPlateNo) {
        self.titleLabel.text = @"添加车牌号";
        [self.submitBtn setTitle:@"确认添加" forState:UIControlStateNormal];
        [self.switchButton setOn:YES];
    }else {
        self.titleLabel.text = @"编辑车牌号";
        [self.submitBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        self.defaultCarType = self.listModel.defaultFlag;
        [self.switchButton setOn:self.listModel.defaultFlag];
    }
    
    
    self.carNumberModel.items = 9;
}

- (void)byEnergyInitViews {
    [self.view addSubview:self.titleLabel];
//    [self.view addSubview:self.detailLabel];
//    [self.view addSubview:self.checkBtn];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.carNumberView];
    [self.view addSubview:self.switchButton];
    [self.view addSubview:self.defaultLabel];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(37);
    }];
    
//    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.titleLabel.mas_bottom).mas_offset(12);
//        make.left.equalTo(weakself.titleLabel.mas_left).mas_offset(0);
//        make.size.mas_equalTo(CGSizeMake(16, 16));
//    }];
//
//    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakself.checkBtn.mas_centerY).mas_offset(0);
//        make.left.equalTo(weakself.checkBtn.mas_right).mas_offset(5);
//        make.right.mas_equalTo(-20);
//        make.height.mas_equalTo(17);
//    }];
    
    [self.carNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titleLabel.mas_bottom).mas_offset(18);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.carNumberView.mas_bottom).mas_offset(18);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(22);
    }];
    
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.carNumberView.mas_bottom).mas_offset(21);
        make.right.equalTo(weakself.switchButton.mas_left).mas_equalTo(-10);
        make.height.mas_equalTo(22);
    }];
    
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.switchButton.mas_bottom).mas_offset(25);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(45);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    kWeakSelf(self);
    [[[[self.carNumberViewModel.hnAddCarNumberCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.carNumberViewModel.result) {
            [HUDManager showStateHud:@"添加成功！"
                               state:HUDStateTypeSuccess
                             imgName:nil
                          afterDelay:1
                              onView:ByEnergyAppWindow completionBlock:^{
                if (weakself.updateSubject) {
                    [weakself.updateSubject sendNext:nil];
                }
                [weakself.navigationController popViewControllerAnimated:YES];
            }];
        }else {
            [HUDManager showStateHud:@"添加失败！" state:HUDStateTypeFail];
        }
    }];
    
    [[[[self.carNumberViewModel.hnUpdateCarNumberCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.carNumberViewModel.result) {
            [HUDManager showStateHud:@"修改成功！"
                               state:HUDStateTypeSuccess
                             imgName:nil
                          afterDelay:1
                              onView:ByEnergyAppWindow completionBlock:^{
                if (weakself.updateSubject) {
                    [weakself.updateSubject sendNext:nil];
                }
                [weakself.navigationController popViewControllerAnimated:YES];
            }];
        }else {
            [HUDManager showStateHud:@"修改失败！" state:HUDStateTypeFail];
            
        }
    }];
}

#pragma mark -----懒加载-----

LCFLazyload(CarNumberModel, carNumberModel)

LCFLazyload(BEnergyCarNumberViewModel, carNumberViewModel)

- (CarNumberView *)carNumberView {
    if (_carNumberView == nil) {
        _carNumberView = [[CarNumberView alloc] init];
        _carNumberView.carNumberModel = self.carNumberModel;
    }
    
    return _carNumberView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = ByEnergyRegularFont(26);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = UIColor.byEnergyTitleTextBlack;
        [_titleLabel setFont:[FontFitTool FontWithType:FontTypeHel_Bold size:26]];
        _titleLabel.text = @"添加车牌号";
    }
    return _titleLabel;
}

//- (UILabel *)detailLabel {
//    if (_detailLabel == nil) {
//        _detailLabel = [[UILabel alloc] init];
//        _detailLabel.font = ByEnergyRegularFont(18);
//        _detailLabel.text = @"新能源汽车牌照";
//        _detailLabel.textAlignment = NSTextAlignmentLeft;
//        [_detailLabel setFont:[FontFitTool FontWithType:FontTypeHel_Bold size:18]];
//        _detailLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#14974F"];
//    }
//    return _detailLabel;
//}
//
//- (UIButton *)checkBtn {
//    ByEnergyWeakSekf
//    if (_checkBtn == nil) {
//        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_checkBtn setImage:IMAGEWITHNAME(@"PlateNo_check_nor") forState:UIControlStateNormal];
//        [_checkBtn setImage:IMAGEWITHNAME(@"PlateNo_check_sel") forState:UIControlStateSelected];
//        [[[_checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            ByEnergyStrongSelf
//            self.checkBtn.selected = !self.checkBtn.selected;
//            self.carNumberView.isNewEnergyCar = self.checkBtn.selected;
//            self.isNewEnergyCar = self.checkBtn.selected;
//        }];
//    }
//    return _checkBtn;
//}

- (UIButton *)submitBtn {
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"确认添加" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.adjustsImageWhenHighlighted = NO;
        [_submitBtn setBackgroundImage:IMAGEWITHNAME(@"Rectangle") forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = ByEnergyRegularFont(18);
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UISwitch *)switchButton {
    if (!_switchButton) {
        _switchButton = [[UISwitch alloc]init];
        [_switchButton addTarget:self action:@selector(isDefaultCar:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
}

- (UILabel *)defaultLabel {
    if (!_defaultLabel) {
        _defaultLabel = [UILabel new];
        _defaultLabel.text = @"设为默认";
        _defaultLabel.font = ByEnergyRegularFont(15);
    }
    return  _defaultLabel;
}

- (RACSubject *)updateSubject {
    if (_updateSubject == nil) {
        _updateSubject = [RACSubject subject];
    }
    return _updateSubject;
}

#pragma mark ----- Action

- (void)setCarNumber:(NSString *)carNumber {
    _carNumber = carNumber;
//    self.checkBtn.selected = NO;
//    if (_carNumber.length == 8) {
//        self.checkBtn.selected = YES;
//    }
//    self.carNumberView.carNumberModel.items = self.checkBtn.selected?9:8;
    self.carNumberView.carNumber = _carNumber;
//    self.isNewEnergyCar = self.checkBtn.selected;
}

- (void)submit:(UIButton *)sender {
    NSString *carNumber = [self.carNumberView text];
    if (!byEnergyIsValidStr(carNumber)) {
        [HUDManager showTextHud:@"请输入车牌号" onView:self.view];return;
    }else {
//        NSInteger maxCount = self.isNewEnergyCar?8:7;
//        if (carNumber.length == maxCount) {
            
            self.carNumberViewModel.carNumber = carNumber;
            if (self.isAddPlateNo) {
                if ([self.carNumberList containsObject:carNumber]) {
                    [HUDManager showTextHud:@"当前车牌号已添加，请重新输入!" onView:self.view];
                    return;
                }
                NSDictionary *param = @{@"carNumber":carNumber,
                                        @"defaultFlag":self.defaultCarType ? @"1" : @"0",};
                
                [self.carNumberViewModel.hnAddCarNumberCommand execute:param];
            }else {
                [self.carNumberViewModel.hnUpdateCarNumberCommand execute:@{@"oldCarNumber":self.listModel.carNumber,
                                                                            @"defaultFlag":self.defaultCarType ? @"1" : @"0",
                                                                            @"newCarNumber" :carNumber,
                                                                            @"carTypeUserId":self.listModel.carTypeUserId.length > 0 ? self.listModel.carTypeUserId : @"",
                }];
            }
//        }
//        else {
//            [SCAlertViewUtils showAlertWithType:SCAlertTypeAlert title:@"请输入正确的车牌号" message:@"" cancelButtonTitle:@"知道了" destructiveButtonTitle:nil otherButtonTitles:nil completionHandler:^(SCAlertButtonType buttonType, NSUInteger buttonIndex) {
//            }];
//        }
    }
}

- (void)isDefaultCar:(UISwitch *)sender {
    self.defaultCarType = sender.isOn;
}
@end
