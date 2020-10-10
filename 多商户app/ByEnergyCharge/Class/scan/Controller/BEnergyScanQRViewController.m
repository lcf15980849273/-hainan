

//
//  BEnergyScanQRViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyScanQRViewController.h"
#import "BEnergyPrepareChargeTableController.h"
#import "ByEnergyStubCodeTools.h"
#import "UIButton+HitRec.h"
#import "UIButton+Layout.h"
#import "BEnergyStubInfoModel.h"
#import "BEnergyInputCodeView.h"

#import "BEnergyHomeVc.h"
#import "MineTableViewController.h"
@interface BEnergyScanQRViewController ()<BEnergyViewControllerProtocol>
@property (nonatomic, strong) UILabel *titleLabel;// 扫码区域上方提示文字
@property (nonatomic, strong) UIButton *flashButton;//闪光灯
@property (nonatomic, strong) UIButton *switchButton;//输入编号充电
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) BEnergyChargeViewModel *viewModel;
@property (nonatomic, strong) ByEnergyStubCodeTools *stubCodeTools;
@property (nonatomic, assign) BOOL lastResult;
@property (nonatomic, assign) BOOL isReading;
@property (nonatomic, strong) BEnergyInputCodeView *inputCodeView;
@property (nonatomic, strong) UIBarButtonItem *leftItem;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation BEnergyScanQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cameraInvokeMsg = @"";
    [self byEnergyInitViewModel];
    
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.flashButton];
    [self.view addSubview:self.switchButton];
    [self.view addSubview:self.backButton];
    
    [self.flashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-100-SafeAreaBottomHeight);
        make.size.mas_equalTo(CGSizeMake(90, 84));
        make.right.mas_equalTo(-self.style.xScanRetangleOffset);
    }];
    
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-100-SafeAreaBottomHeight);
        make.size.mas_equalTo(CGSizeMake(90, 84));
        make.left.mas_equalTo(self.style.xScanRetangleOffset);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.equalTo(self.view).offset(0);
        make.height.width.mas_equalTo(44);
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.lastResult = NO;
    self.isReading = NO;
    [self startimer];
    [self.navigationController setNavigationBarHidden:YES animated:self.ispushCharging];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([ByEnergyTopVC isKindOfClass:[BEnergyHomeVc class]] || [ByEnergyTopVC isKindOfClass:[MineTableViewController class]] ) {
        self.ispushCharging = NO;
    }
    
    if (self.ispushCharging) {
        [self.navigationController setNavigationBarHidden:NO animated:self.ispushCharging];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopTimer];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:_flashButton];
    [self.view bringSubviewToFront:_titleLabel];
    [self.view bringSubviewToFront:self.backButton];
    [self.view bringSubviewToFront:_switchButton];
    self.flashButton.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 20, 18);
    self.flashButton.titleEdgeInsets = UIEdgeInsetsMake(64, -self.flashButton.imageView.width, 0, 0);
    
    self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 20, 15);
    self.switchButton.titleEdgeInsets = UIEdgeInsetsMake(64, -self.switchButton.imageView.width, 0, 0);
}


- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[self.stubCodeTools chargeSubject] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [self stopTimer];
        [HUDManager hidenHud];
        BEnergyStubInfoModel *stubInfo = (BEnergyStubInfoModel *)x;
        if (byEnergyIsValidStr(stubInfo.id)) {
            self.ispushCharging = YES;
            BEnergyPrepareChargeTableController *vc = [[BEnergyPrepareChargeTableController alloc] init];
            vc.stubId = stubInfo.id;
            vc.isPopViewController = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    [[self.stubCodeTools failSubject] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self continueTimer];
        self.lastResult = NO;
        self.isReading = NO;
        [self reStartDevice];
        
    }];
}


#pragma mark -实现类继承该方法，作出对应处理

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array {
    if (!array ||  array.count < 1) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    LBXScanResult *scanResult = array[0];
    NSString *strResult = scanResult.strScanned;
    self.scanImage = scanResult.imgScanned;
    if (!strResult) {
        [self popAlertMsgWithScanResult:nil];
         return;
    }
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    
    NSString *stuId = scanResult.strScanned;
    [self inputStubInfomationWithStubId:stuId];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult {
    if (!strResult) {
        strResult = @"识别失败";
    }
    
    kWeakSelf(self);
    
    [BEnergyCustomAlertView showAlertViewWithTitle:strResult
                                       buttonArray:@[@"知道了"]
                                             block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        [weakself reStartDevice];
    }];
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc selectAddressWithType:@"厦门"];
    [vc selectIndutryOrIdentifyWithType:@"类别"];
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}
 

#pragma mark -----Action-----
//充电桩的对应ID  输入二维码时调用
- (void)inputStubInfomationWithStubId:(NSString *)stubId {
    [self.stubCodeTools inputStubInfomationWithStubId:stubId];
}

- (void)requestFailed{
    self.lastResult = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.lastResult = NO;
        self.isReading = NO;
        [self reStartDevice];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUDManager showTextHud:@"非充电桩二维码" onView:self.view];
    });
    
}

- (void)showAlert:(NSString *)message {
    
    [BEnergyCustomAlertView showAlertViewWithTitle:@"提示"
                                            detail:message
                                 buttonsTitleArray:@[@"确定"]
                                   operationAction:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        [self reStartDevice];
        self.lastResult = NO;
        self.isReading = NO;
    }];
}


#pragma mark --设置扫码View
+ (LBXScanViewStyle*)ScanViewStyle {
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    //扫码区域4个角的颜色
    style.colorAngle = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
    style.centerUpOffset = 65;
    style.xScanRetangleOffset = 35;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480 ) {
        //3.5inch 显示的扫码缩小
        style.centerUpOffset = 45;
        style.xScanRetangleOffset = 25;
    }
    
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    style.animationImage = [UIImage imageNamed:@"ScanningLine"];
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    
    //    //使用的支付宝里面网格图片
    //    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    //    style.animationImage = imgFullNet;
    
    return style;
}

//开关闪光灯
- (void)openOrCloseFlash {
    [super openOrCloseFlash];
    if (self.isOpenFlash) {
        [_flashButton setImage:[UIImage imageNamed:@"btn_flash_selected_Scan"] forState:UIControlStateNormal];
    }else
        [_flashButton setImage:[UIImage imageNamed:@"btn_flash_selected_Scan"] forState:UIControlStateNormal];
}

- (void)importStubID:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.titleLabel.hidden = sender.selected;
    if (sender.selected) {
        [self stopScan];
        [self pauseTimer];
        self.stubCodeTools.type = StubCodeToolsTypeTextField;
        [self.view addSubview:self.inputCodeView];
        [self.inputCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(0);
            make.top.equalTo(self.view).offset(0);
        }];
    }else {
        self.stubCodeTools.type = StubCodeToolsTypeDefault;
        [self.inputCodeView viewHiden];
        [self continueTimer];
        [self reStartDevice];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    [self.scanObj cameraBackgroundDidTap:point];
    
}

//暂停定时器(只是暂停,并没有销毁timer)
-(void)pauseTimer {
    [self.timer setFireDate:[NSDate distantFuture]];
}

//继续计时
-(void)continueTimer {
    [self.timer setFireDate:[NSDate distantPast]];
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc selectAddressWithType:@"厦门"];
    [vc selectIndutryOrIdentifyWithType:@"类别"];
}

//开始计时
-(void)startimer {
    [self.timer fire];
}

//暂停并销毁
-(void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)beginChange {
    [self.scanObj cameraBackgroundDidTap:self.view.center];
}

#pragma mark ----- LazyLoad
- (BEnergyInputCodeView *)inputCodeView {
    if (!_inputCodeView) {
        _inputCodeView = [[BEnergyInputCodeView alloc] init];
        _inputCodeView.backgroundColor = [UIColor blackColor];
        ByEnergyWeakSekf
        [_inputCodeView setComitButtonBlock:^{
            ByEnergyStrongSelf
            [self.inputCodeView.codeTextFiled resignFirstResponder];
            [self.view endEditing:YES];
            [self.stubCodeTools inputStubInfomationWithStubId:self.inputCodeView.codeTextFiled.text];
        }];
    }
    return _inputCodeView;
}

LCFLazyload(BEnergyChargeViewModel, viewModel)
-(NSTimer*)timer{
    if (!_timer) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:5
                                                 target:self
                                               selector:@selector(beginChange)
                                               userInfo:nil
                                                repeats:YES];
    }
    return _timer;
}

- (ByEnergyStubCodeTools *)stubCodeTools {
    if (!_stubCodeTools) {
        _stubCodeTools = [[ByEnergyStubCodeTools alloc] init];
        _stubCodeTools.type = StubCodeToolsTypeDefault;
        _stubCodeTools.controller = self;
        ByEnergyWeakSekf
        [_stubCodeTools setResetScanBlock:^{
            ByEnergyStrongSelf
            [self continueTimer];
            self.lastResult = NO;
            self.isReading = NO;
            [self reStartDevice];
        }];
    }
    return _stubCodeTools;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.bounds = CGRectMake(0, 0, 300, 20);
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"请扫描充电桩二维码";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.center = CGPointMake(SCREENWIDTH/2, self.view.height/2-self.style.centerUpOffset+(SCREENWIDTH-self.style.xScanRetangleOffset*2)/2+_titleLabel.height/2+14);
    }
    return _titleLabel;
}

- (UIButton *)flashButton {
    if (!_flashButton) {
        _flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flashButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_flashButton setTitle:@"开启手电筒" forState:UIControlStateNormal];
        [_flashButton setImage:[UIImage imageNamed:@"btn_flash_selected_Scan"] forState:UIControlStateNormal];
        _flashButton.titleLabel.font = ByEnergyRegularFont(10);
        _flashButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_flashButton addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashButton;
}

- (UIButton *)switchButton {
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchButton.adjustsImageWhenHighlighted = NO;
        [_switchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_switchButton setTitle:@"输入桩编号" forState:UIControlStateNormal];
        [_switchButton setTitle:@"切换到二维码" forState:UIControlStateSelected];
        [_switchButton setImage:[UIImage imageNamed:@"btn_input_Scan"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"code"] forState:UIControlStateSelected];
        [_switchButton addTarget:self action:@selector(importStubID:) forControlEvents:UIControlEventTouchUpInside];
        _switchButton.titleLabel.font = ByEnergyRegularFont(10);
        _switchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _switchButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:IMAGEWITHNAME(@"btn_return_mine") forState:UIControlStateNormal];
        ByEnergyWeakSekf
        [[_backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            [self.navigationController popViewControllerAnimated:YES];
        }];
        _backButton.hitEdgeInsets = UIEdgeInsetsMake(-15, -15, -15, -20);
    }
    return _backButton;
}
@end
