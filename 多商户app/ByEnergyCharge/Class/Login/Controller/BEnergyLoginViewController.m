
//
//  BEnergyLoginViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/20.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyLoginViewController.h"
#import "BEnergyHomeVc.h"
#import "BEnergyLoginViewModel.h"
#import "UIButton+TimerCode.h"
#import "TYAttributedLabel.h"


@interface BEnergyLoginViewController ()<UITextFieldDelegate,UITextViewDelegate,TYAttributedLabelDelegate>
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UITextField *phoneTextfield;
@property (nonatomic, strong) UITextField *verifyTextfield;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UIImageView *checkImageView;
@property (nonatomic, strong) BEnergyLoginViewModel *viewModel;
@property (nonatomic, assign) BOOL isDownTime;
@property (nonatomic, strong) TYAttributedLabel *protocolContentLabel;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIView *phoneBackView;
@property (nonatomic, strong) UIView *verityBackView;
@end


@implementation BEnergyLoginViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//禁止侧滑
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.verifyButton invalidTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self popToPointViewController:NSStringFromClass([BEnergyHomeVc class])];
    }
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)backBtnClicked {
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)byEnergyInitViews {

    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.textLabel];
    [self.view addSubview:self.phoneBackView];
    [self.view addSubview:self.verityBackView];
    [self.view addSubview:self.protocolContentLabel];
    [self.view addSubview:self.checkImageView];
    [self.view addSubview:self.checkButton];
    [self.view addSubview:self.loginButton];
    [self.phoneTextfield becomeFirstResponder];
    

    ByEnergyWeakSekf
    [[self.phoneTextfield rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x){
        ByEnergyStrongSelf
        self.phoneBackView.layer.borderColor = BYENERGYCOLOR(0x00BFE5).CGColor;
        self.verityBackView.layer.borderColor = BYENERGYCOLOR(0xEFEFF4).CGColor;
    }];
    
    [[self.verifyTextfield rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(id x){
        ByEnergyStrongSelf
        self.phoneBackView.layer.borderColor = BYENERGYCOLOR(0xEFEFF4).CGColor;
        self.verityBackView.layer.borderColor = BYENERGYCOLOR(0x00BFE5).CGColor;
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        ByEnergyStrongSelf
        self.phoneBackView.layer.borderColor = BYENERGYCOLOR(0xEFEFF4).CGColor;
        self.verityBackView.layer.borderColor = BYENERGYCOLOR(0xEFEFF4).CGColor;
    }];
}
 
- (void)byEnergySetViewLayout {
    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(32);
        make.left.mas_equalTo(36);
        make.width.mas_equalTo(79.5);
        make.height.mas_equalTo(39.5);
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(36);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(33);
    }];
    
    [self.phoneBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel.mas_bottom).mas_offset(60);
        make.left.mas_equalTo(36);
        make.right.equalTo(self.view).offset(-36);
        make.height.mas_equalTo(45);
    }];
    
    [self.verityBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneBackView.mas_bottom).mas_offset(22);
        make.left.mas_equalTo(36);
        make.right.equalTo(self.view).offset(-36);
        make.height.mas_equalTo(45);
    }];
    
    
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verityBackView.mas_bottom).mas_equalTo(12);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(27);
    }];
    
    [_checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verityBackView.mas_bottom).mas_offset(17);
        make.left.mas_equalTo(24);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
    }];
    
    [_protocolContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(220, 17));
        make.bottom.mas_equalTo(-15-SafeAreaBottomHeight);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verityBackView.mas_bottom).mas_offset(44);
        make.left.mas_equalTo(36);
        make.right.mas_equalTo(-36);
        make.height.mas_equalTo(45);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    //数据绑定
    RAC(self.viewModel,phone) = self.phoneTextfield.rac_textSignal;
    RAC(self.viewModel,code) = self.verifyTextfield.rac_textSignal;
    RAC(self.viewModel,isDownTime) = _RACObserve(self, isDownTime);
    RAC(self.viewModel,isAgreement) = _RACObserve(self.checkButton, selected);
    [[_checkButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        UIButton *sender = (UIButton *)x;
        self.checkButton.selected = !sender.selected;
        if (self.checkButton.selected) {
            self.checkImageView.image = IMAGEWITHNAME(@"login_check_selected");
        }else {
            self.checkImageView.image = IMAGEWITHNAME(@"login_check_normal");
        }
//        self.viewModel.isAgreement = self.checkButton.selected;
    }];
    
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple * _Nullable x) {
        ByEnergyStrongSelf
        [self resignTextField];
        [x.first resignFirstResponder];
    }];
    
    _verifyButton.rac_command = [self.viewModel hnFechVerityCodeCommand];
    [[[_verifyButton.rac_command executionSignals] switchToLatest] subscribeNext:^(RACSignal<id> * _Nullable x) {
        ByEnergyStrongSelf
        [self.verifyTextfield becomeFirstResponder];
        if (self.viewModel.result == YES) {
            [self.verifyButton startCountDownTime:60 withCountDownBlock:^(BOOL isFinsh){
                self.isDownTime = !isFinsh;
            }];
        }else {
            self.isDownTime = NO;
            [self.verifyButton invalidTimer];
        }
    }];
    
    [_verifyButton.rac_command.errors subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.view endEditing:YES];
        self.isDownTime = NO;
        [self.verifyButton invalidTimer];
    }];
    
    _loginButton.rac_command = [self.viewModel hnLoginCommand];
    
    [[[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        [StringUtils endEditedFromView:self.view];
    }];
    
    [[[_loginButton.rac_command executionSignals] switchToLatest] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        self.loginButton.enabled = NO;
        if (self.viewModel.result == YES) {
            self.loginButton.enabled = YES;
            kWeakSelf(self);
            [HUDManager showStateHud:@"登录成功"
                               state:HUDStateTypeSuccess
                             imgName:nil
                          afterDelay:1.5
                              onView:ByEnergyAppWindow completionBlock:^{
                ByEnergySendNotification(ByEnergyLoginStateChange, nil);
                ByEnergySendNotification(ByEnergyUpdateNoticeHomePopView, nil);
                [self setStatusBarBackgroundColor:[UIColor clearColor]];
                [weakself dismissViewControllerAnimated:YES completion:^{
                }];
            }];
        }else {
            [HUDManager showStateHud:@"登录失败" state:HUDStateTypeFail];
        }
    }];
    
    [_loginButton.rac_command.errors subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        self.loginButton.enabled = YES;
    }];
    
    [_viewModel.hnFechVerityCodeCommand.errors subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        self.loginButton.enabled = YES;
        [self.view endEditing:YES];
        [HUDManager showTextHud:x.domain.description];
    }];
    
    ByEnergyReceivedNotification(UIKeyboardWillHideNotification, ^{
        ByEnergyStrongSelf
        [self resignTextField];
    }());
}

#pragma mark - TYAttributedLabelDelegate
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel
     textStorageClicked:(id<TYTextStorageProtocol>)TextRun
                atPoint:(CGPoint)point {
    ByEnergyBaseWebVc *protocolVC = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:AppToServiceAgreementUrl
                                                                                   title:@"用户服务协议"
                                                                                 baseUrl:URL_BASE params:@{@"type":@"register",@"api_version":byEnergyClearNilStr([[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]),@"api_platform":@"ios"}];
    [self.navigationController pushViewController:protocolVC animated:YES];
}

- (void)resignTextField{
   
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyLoginViewModel, viewModel)
- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = IMAGEWITHNAME(@"hainanIcon");
    }
    return _logoImageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = ByEnergyRegularFont(24);
        _textLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#353535"];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.text = @"欢迎使用海控充电";
    }
    return _textLabel;
}

- (UIButton *)verifyButton {
    if (!_verifyButton) {
        _verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _verifyButton.backgroundColor = [UIColor whiteColor];
        [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyButton setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#CDCDCD"] forState:UIControlStateDisabled];
        [_verifyButton setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#00BFE5"] forState:UIControlStateNormal];
        _verifyButton.layer.masksToBounds = YES;
        [_verifyButton.titleLabel setFont:ByEnergyRegularFont(11)];
        _verifyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _verifyButton;
}

- (UITextField *)phoneTextfield {
    if (!_phoneTextfield) {
        _phoneTextfield = [[UITextField alloc] init];
        _phoneTextfield.font = ByEnergyRegularFont(16);
        _phoneTextfield.keyboardType = UIKeyboardTypeDecimalPad;
        _phoneTextfield.delegate = self;
        [_phoneTextfield setTextCount:11];
        _phoneTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextfield.textColor = [UIColor colorByEnergyWithBinaryString:@"353535"];
        _phoneTextfield.attributedPlaceholder = [StringUtils setTextFieldPlacehoder:@"请输入手机号" Color:UIColor.byEnergyPlaceholderGray];
        if (byEnergyIsValidStr([USER_DEFAULT objectForKey:@"phoneNo"])) {
            _phoneTextfield.text = [USER_DEFAULT objectForKey:@"phoneNo"];
        }
        ViewRadius(_phoneTextfield, 5);
    }
    return _phoneTextfield;
}

- (UITextField *)verifyTextfield {
    if (!_verifyTextfield) {
        _verifyTextfield = [[UITextField alloc] init];
        _verifyTextfield.font = ByEnergyRegularFont(16);
        _verifyTextfield.keyboardType = UIKeyboardTypeDecimalPad;
        _verifyTextfield.delegate = self;
        _verifyTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verifyTextfield.textColor = [UIColor colorByEnergyWithBinaryString:@"353535"];
        _verifyTextfield.attributedPlaceholder = [StringUtils setTextFieldPlacehoder:@"请输入手机验证码" Color:UIColor.byEnergyPlaceholderGray];
    }
    return _verifyTextfield;
}

- (TYAttributedLabel *)protocolContentLabel {
    if (!_protocolContentLabel) {
        _protocolContentLabel = [[TYAttributedLabel alloc] init];
        _protocolContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _protocolContentLabel.delegate = self;
        _protocolContentLabel.highlightedLinkBackgroundColor = [UIColor clearColor];
        NSString *text = @"登录后代表您同意《用户服务协议》";
        TYTextContainer *textContainer = [[TYTextContainer alloc]init];
        textContainer.text = text;
        textContainer.font = ByEnergyRegularFont(12);
        textContainer.textAlignment = NSTextAlignmentCenter;
        textContainer.textColor = [UIColor colorByEnergyWithBinaryString:@"#ADADAD"];
        [textContainer addLinkWithLinkData:@"" linkColor:[UIColor colorByEnergyWithBinaryString:@"#576B95"] underLineStyle:kCTUnderlineStyleNone range:[text rangeOfString:@"《用户服务协议》"]];
        _protocolContentLabel.textContainer = textContainer;
    }
    return _protocolContentLabel;
}

- (UIImageView *)checkImageView {
    if (!_checkImageView) {
        _checkImageView = [[UIImageView alloc] init];
        _checkImageView.image = IMAGEWITHNAME(@"login_check_selected");
        _checkImageView.hidden = YES;
    }
    return _checkImageView;
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.backgroundColor = [UIColor clearColor];
        _checkButton.selected = YES;
        _checkButton.hidden = YES;
    }
    return _checkButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundImage:IMAGEWITHNAME(@"btn_n_login") forState:UIControlStateDisabled];
        [_loginButton setBackgroundImage:IMAGEWITHNAME(@"Rectangle") forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _loginButton.layer.masksToBounds = YES;
        [_loginButton.titleLabel setFont:ByEnergyRegularFont(18)];
    }
    return _loginButton;
}

- (UIView *)phoneBackView {
    if (!_phoneBackView) {
        _phoneBackView = [[UIView alloc] init];
        _phoneBackView.layer.borderWidth = 1;
        _phoneBackView.layer.borderColor = BYENERGYCOLOR(0xEFEFF4).CGColor;
        _phoneBackView.layer.cornerRadius = 8.0f;
        _phoneBackView.layer.masksToBounds = YES;
        UIImageView *phoneIcon = [[UIImageView alloc] initWithImage:IMAGEWITHNAME(@"phoneIcon")];
        [_phoneBackView addSubview:phoneIcon];
        [_phoneBackView addSubview:self.phoneTextfield];
        [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_phoneBackView).offset(16);
            make.centerY.equalTo(_phoneBackView);
            make.height.mas_offset(23);
            make.width.mas_offset(14);
        }];
        [self.phoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneIcon.mas_right).offset(16);
            make.centerY.equalTo(_phoneBackView);
            make.right.top.bottom.equalTo(_phoneBackView).offset(0);
        }];
    }
    return _phoneBackView;
}

- (UIView *)verityBackView {
    if (!_verityBackView) {
        _verityBackView = [[UIView alloc] init];
        _verityBackView.layer.borderWidth = 1;
        _verityBackView.layer.borderColor = BYENERGYCOLOR(0xEFEFF4).CGColor;
        _verityBackView.layer.cornerRadius = 8.0f;
        _verityBackView.layer.masksToBounds = YES;
        UIImageView *verityIcon = [[UIImageView alloc] initWithImage:IMAGEWITHNAME(@"codeIcon")];
        [_verityBackView addSubview:verityIcon];
        [_verityBackView addSubview:self.verifyTextfield];
        [_verityBackView addSubview:self.verifyButton];
        [verityIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_verityBackView).offset(16);
            make.centerY.equalTo(_verityBackView);
            make.height.mas_offset(23.5);
            make.width.mas_offset(21);
        }];
        
        [_verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.verifyTextfield);
            make.right.mas_equalTo(-14);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(45);
        }];
        
        [self.verifyTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(verityIcon.mas_right).offset(13);
            make.right.equalTo(_verifyButton.mas_left).offset(-10);
            make.centerY.equalTo(_verityBackView);
            make.top.bottom.equalTo(_verityBackView).offset(0);
        }];
    }
    return _verityBackView;
}
@end
