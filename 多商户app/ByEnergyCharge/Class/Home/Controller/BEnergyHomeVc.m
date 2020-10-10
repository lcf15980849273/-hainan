//
//  BEnergyHomeVc.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/11.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyHomeVc.h"
#import "MapManager.h"
#import "ByEnergyScanManager.h"
#import "BEnergyStubGroupViewModel.h"
#import "BEnergyChargeViewModel.h"
#import "BEnergyCarNumberViewModel.h"
#import "BEnergyFocusViewModel.h"
#import "BEnergyStubGroupCityModel.h"
#import "BEnergyStubGroupModel.h"
#import "BEnergyChargeListModel.h"
#import "BEnergyHomeChargeListModel.h"
#import "BEnergyStubGroupInfoView.h"
#import "BEnergyStubDetailViewController.h"
#import "BEnergyAddCarNumberViewController.h"
#import "LaunchAdModel.h"
#import "BEnergyApiCloudStorage.h"
#import "BEnergyUserInfoViewModel.h"
#import "BEnergyHomePagePopView.h"
#import "BEnergyNoticeCenterViewModel.h"
#import "BEnergyNoticeCenterModel.h"
#import "BEnergyNoticeCenterViewController.h"
#import "BEnergyMyCouponsViewController.h"
#import "BEnergyCouponsViewModel.h"
#import "BEnergyNoticeCenterViewController.h"
#import "BEnergySystemNoticeListViewController.h"

//......
#import "BEnergyStubViewController.h"
#import "CFCALayerViewController.h"
#import "coreGraphicsCustomView.h"
#import "SecondTableView.h"
#import "CFAutoCellHeightViewController.h"
@interface BEnergyHomeVc ()<CAAnimationDelegate,SDCycleScrollViewDelegate> {
    
}
@property (nonatomic, strong) MapManager *byMapManager;//地图类
@property (nonatomic, strong) BEnergyStubGroupViewModel *stubGroupViewModel;//stubGroupViewModel
@property (nonatomic, strong) BEnergyCarNumberViewModel *byCarNumberViewModel;//车牌号ViewModel
@property (nonatomic, strong) BEnergyUserInfoViewModel *byUserInfoViewModel;//获取用户信息
@property (nonatomic, strong) BEnergyCouponsViewModel *byCouponsViewModel;
@property (nonatomic, strong) BEnergyChargeViewModel *byChargeViewModel;//获取充电订单数量
@property (nonatomic, strong) BEnergyStubGroupCityModel *bySelectedCity;//选中的城市
@property (nonatomic, strong) BEnergyStubGroupInfoView *byStubGroupInfoView;//桩群详情
@property (nonatomic, assign) BOOL hasSearchIdle;//是否已经请求过桩群
@property (nonatomic, assign) BOOL freshFocusUI;//是否更新焦点图UI
@property (nonatomic, assign) BOOL canShowCounpon;
@property (nonatomic, strong) BEnergyHomePagePopView *byPopView;//首页广告弹窗
@property (nonatomic, strong) BEnergyNoticeCenterViewModel *byNoticeViewModel;//弹窗viewModel
@property (nonatomic, strong) UIButton *byrefreshBtn;//刷新按钮
@property (nonatomic, strong) UIButton *byListBtn;//列表按钮
@property (nonatomic, strong) UIButton *byCouponButton;//优惠券按钮
@property (nonatomic, assign) int index;//选中的定位图标
@end

@implementation BEnergyHomeVc

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (isLogOut == NO) {
        [self.byChargeViewModel.homeChargeList execute:nil];
    }

    self.byPopView.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
    
    [self byEnergyInitNotification];
    
    self.stubGroupViewModel.type = 0;
    
    [self.stubGroupViewModel.hnStubGroupCommand execute:nil];
    
    

    
}

- (void)byEnergyInitNotification {
    
    ByEnergyReceivedNotification(ByEnergyLogout, ^{
        //登录逻辑修改
        //[BEnergyLoginManger ByEnergyPresentLoginViewController];
        self.canShowCounpon = NO;
        self.byCouponButton.hidden = YES;
    }());
    
    ByEnergyWeakSekf
    ByEnergyReceivedNotification(ByEnergyLoginStateChange, ^{
        ByEnergyStrongSelf
        //登录逻辑修改
        //[self byEnergyFetchStubGroupList];
        
        [self.byCarNumberViewModel.hnFetchCarNumberCommand execute:nil];
        self.stubGroupViewModel.type = 0;
        [self.stubGroupViewModel.hnStubGroupCommand execute:nil];
        [self.byChargeViewModel.homeChargeList execute:nil];
    }());
    
    ByEnergyReceivedNotification(ByEnergyRefreshFocusList, ^{
        ByEnergyStrongSelf
        if (self.hasSearchIdle == NO) {
            if ([self canSearch]) {
                self.hasSearchIdle = YES;
                [self byEnergyFetchStubGroupList];
            }
        }
    }());
    
    ByEnergyReceivedNotification(ByEnergySearchIdleStub, ^{
        ByEnergyStrongSelf
        if (byEnergyIsValidStr([BEnergyAppStorage sharedInstance].userCityId)) {
            BEnergyStubGroupCityModel *newCity = [BEnergyStubGroupCityModel new];
            newCity.city = [BEnergyAppStorage sharedInstance].userCityId;
            newCity.name = [BEnergyAppStorage sharedInstance].userCityName;
            self.bySelectedCity = newCity;
            [self byEnergyFetchStubGroupList];
        }
    }());
    
    ByEnergyReceivedNotification(ByEnergyUpdateUserInfo, ^{
        ByEnergyStrongSelf
        [self.byUserInfoViewModel.userInfo execute:nil];
    }());
    
    
    ByEnergyReceivedNotification(ByEnergyUpdateNoticeHomePopView, ^{
        ByEnergyStrongSelf
//        [self byEnergyFetchAdvertisingData];
        [self byEnergyCheckHasCouponData];
    }());
    
}

- (void)byEnergyInitViews {
    
    self.isShowLiftBack = NO;
    self.byStubGroupInfoView = [[BEnergyStubGroupInfoView alloc] init];
    _byStubGroupInfoView.hidden = YES;
    [self.view addSubview:_byStubGroupInfoView];
    [self.view addSubview:self.byrefreshBtn];
    [self.view addSubview:self.byCouponButton];
    [self.view addSubview:self.byListBtn];
    //.......
    CFCALayerViewController *vc = [CFCALayerViewController new];
    [vc drawMyLayer];
}

- (void)byEnergySetViewLayout {
    
    [self.byStubGroupInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7);
        make.right.mas_equalTo(-7);
        make.bottom.mas_equalTo(-15);
        make.height.mas_equalTo(0);
    }];
    
    [self.byCouponButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-140);
        make.left.mas_equalTo(SCREENWIDTH == 320 ? 5 : 15);
        make.size.mas_equalTo(CGSizeMake(63, 61));
    }];
    
    [self.byrefreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-160);
        make.right.equalTo(self.view).offset(-10);
        make.size.mas_offset(CGSizeMake(51, 51));
    }];
    
    [self.byListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.byrefreshBtn.mas_top).offset(-10);
        make.right.equalTo(self.view).offset(-10);
        make.size.mas_offset(CGSizeMake(51, 51));
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.byrefreshBtn];
    [self.view bringSubviewToFront:self.byListBtn];
    [self.view bringSubviewToFront:self.byCouponButton];
    [self.view bringSubviewToFront:self.byStubGroupInfoView];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    RAC(self.byMapManager,selectedCity) = _RACObserve(self, bySelectedCity);
    RAC(self.byMapManager,datasArray) = _RACObserve(self.stubGroupViewModel, datasArray);
    [_RACObserve(self, bySelectedCity) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.byMapManager.selectedCity = x;
    }];
    
    [[[self.stubGroupViewModel.hnHomeStubListCommand executionSignals] switchToLatest] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.stubGroupViewModel.result) {
            [self.byMapManager addAnomationWithArray:self.stubGroupViewModel.datasArray];
            [self.byMapManager locationToUser];
        }
    }];
    
    [self.byMapManager.showSubject subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        int index = [x intValue];
        if (index >= [self.stubGroupViewModel.datasArray count]) {
            [self showStubDetaiInfoView:NO WithIndex:index];
            return;
        }
        [self.byStubGroupInfoView fillDataWithDataModel:[self.stubGroupViewModel.datasArray objectAtIndex:index] ];
        self.index = index;
        [self showStubDetaiInfoView:YES WithIndex:index];
    }];
    
    [self.byMapManager.hideSubject subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        self.index = [x intValue];
        [self showStubDetaiInfoView:NO WithIndex:[x intValue]];
    }];
    
    [[[self.byrefreshBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        [self.byMapManager locationToUser];
        [self.byrefreshBtn byEnergyViewWithAnimation:self.byrefreshBtn];
        [self byEnergyFetchStubGroupList];
    }];
    
    [[[self.byListBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        [self.navigationController pushViewController:[BEnergyStubViewController new] animated:YES];
    }];
    
    
    [[[self.byStubGroupInfoView.loactionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        [[BEnergyAppStorage sharedInstance] byEnergyOpenNaviWithLat:self.byStubGroupInfoView.stubGroup.gisGcj02Lat
                                                     destinationLng:self.byStubGroupInfoView.stubGroup.gisGcj02Lng
                                                    destinationName:self.byStubGroupInfoView.stubGroup.name
                                                    destinationView:self.view];
    }];
    
    
    [[self.byStubGroupInfoView.detailSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        BEnergyStubDetailViewController *vc = [[BEnergyStubDetailViewController alloc]init];
        vc.stubGroupID = [x id];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[[[self.byCarNumberViewModel.hnFetchCarNumberCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.byCarNumberViewModel.result) {
            if (self.byCarNumberViewModel.datasArray.count == 0) {
                [self pushBEnergyAddCarNumberViewController];
            }
        }
    }];
    
    if (isLogOut == NO) {
        [self.byCarNumberViewModel.hnFetchCarNumberCommand execute:nil];
    }
    
    [[[[self.stubGroupViewModel.hnStubGroupCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.stubGroupViewModel.result) {
            NSArray *stubGroupCityList = x;
            [[BEnergyApiCloudStorage sharedInstance] setStubGroupCityList:stubGroupCityList];
        }
    }];
    
    
    [[[[self.byUserInfoViewModel.userInfo executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
    }];
    
    
    [[[[self.byChargeViewModel.homeChargeList executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [[ByEnergyScanManager sharedByEnergyScanManager] setHomeChargeListModel:self.byChargeViewModel.value];
    }];
    
    if (isLogOut == NO) {
        [self.byChargeViewModel.homeChargeList execute:nil];
    }

    
    [[[[self.byNoticeViewModel.hnActivityCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        
        
        //登录逻辑修改
        if (self.byNoticeViewModel.datasArray.count > 0 ) {
            [self.byPopView viewShow];
        }
        /*
        if (self.byNoticeViewModel.datasArray.count > 0 && [[USER_DEFAULT objectForKey:@"token"] length] > 0) {
            [self.byPopView viewShow];
        }*/
        NSMutableArray *imageArray = [NSMutableArray new];
        for (BEnergyNoticeCenterModel *model in self.byNoticeViewModel.datasArray) {
            [imageArray addObject:model.imgPopupUrl];
        }
        self.byPopView.advImageView.imageURLStringsGroup = imageArray;
    }];
    [self byEnergyFetchAdvertisingData];
    
    
    [[[[self.byCouponsViewModel.hnCouponListCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDictionary *x) {
        NSDictionary *dic = x[@"couponList"];
        if ([dic isEqual:[NSNull null]]) {
            self.canShowCounpon = NO;
            self.byCouponButton.hidden = YES;
        }else {
            self.canShowCounpon = dic.count;
            self.byCouponButton.hidden = !dic.count;
        }
    }];
    
    if (isLogOut == NO) {
        [self byEnergyCheckHasCouponData];
    }
    
    //......
    coreGraphicsCustomView *vc = [coreGraphicsCustomView new];
    [vc pushWithDefalutView];
}

#pragma mark ----- 获取首页弹窗广告
- (void)byEnergyFetchAdvertisingData {
    self.byNoticeViewModel.page.PageIndex = 1;
    NSDictionary *param = @{
        @"city":[BEnergyAppStorage sharedInstance].userCityId,
//        @"city":@"460100",  //海南测试
        @"useType":@(2),
        @"isPopup":@(1),
    };
    [self.byNoticeViewModel.hnActivityCommand execute:param];
}

#pragma mark ----- 是否有优惠券
- (void)byEnergyCheckHasCouponData {
    self.byCouponsViewModel.status = 0;
    self.byCouponsViewModel.page.PageIndex = 1;
    [self.byCouponsViewModel.hnCouponListCommand execute:nil];
}


#pragma mark ----- 获取桩群信息
- (void)byEnergyFetchStubGroupList {
    if ([self canSearch] && byEnergyIsValidStr([BEnergyAppStorage sharedInstance].userCityId)) {
        NSMutableDictionary *tagInfo = [NSMutableDictionary dictionary];
        [tagInfo addEntriesFromDictionary:[BEnergyAppStorage sharedInstance].locationTagInfo];
        [self.stubGroupViewModel.hnHomeStubListCommand execute:tagInfo];
    }
}


#pragma mark ----- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    BEnergyNoticeCenterModel *model = self.byNoticeViewModel.datasArray[index];
    if (model.refType == 1) {
        self.byPopView.hidden = YES;
        [self showWebWithpath:nil
                       params:nil
                      baseUrl:byEnergyClearNilStr(model.srcUrl)
                     titleStr:@""
                      refType:model.refType
         navigationController:self.navigationController];
    }else if (model.refType == 3) {
        self.byPopView.hidden = YES;
        [self.navigationController pushViewController:[BEnergySystemNoticeListViewController new] animated:YES];
    }else if (model.refType == 4) {
        self.byPopView.hidden = YES;
        [self.navigationController pushViewController:[BEnergyNoticeCenterViewController new] animated:YES];
    }
}

#pragma mark -----是否显示桩群详情，底部弹窗视图做动画
- (void)showStubDetaiInfoView:(BOOL)show WithIndex:(int)index {
    BEnergyStubGroupModel *model = [self.stubGroupViewModel.datasArray objectAtIndex:index];
    CGFloat height = model.nameSize.height + 95;
    self.byStubGroupInfoView.height = height;
    if (self.canShowCounpon) {
        self.byCouponButton.hidden = show;
    }
    ByEnergyWeakSekf
    [UIView animateWithDuration:0.3 animations:^{
        ByEnergyStrongSelf
        [self.byStubGroupInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(show ? height : 0);
        }];
        
        [self.byStubGroupInfoView.superview layoutIfNeeded];
    }];
    _byStubGroupInfoView.hidden = !show;
    self.byStubGroupInfoView.loactionBtn.userInteractionEnabled = show;
}

#pragma mark ----- 充值添加车牌号
- (void)pushBEnergyAddCarNumberViewController {
    [BEnergyCustomAlertView showAlertViewWithTitle:@"绑定车牌号"
                                            detail:@"绑定车牌号，立享停车优惠哦！"
                                 buttonsTitleArray:@[@"取消",@"绑定"]
                                   operationAction:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            BEnergyAddCarNumberViewController *vc = [[BEnergyAddCarNumberViewController alloc] init];
            vc.carNumber = @"琼";
            vc.isAddPlateNo = YES;
            self.byPopView.hidden = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}


- (void)showWebWithpath:(NSString *)pathStr
                 params:(NSDictionary *)params
                baseUrl:(NSString *)baseUrl
               titleStr:(NSString *)titleStr refType:(int)refType
   navigationController:(UINavigationController *)navigationController{
    
    ByEnergyBaseWebVc *vc = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:pathStr
                                                                           title:titleStr
                                                                         baseUrl:baseUrl
                                                                          params:params];
    
    if (refType == 0) {
        vc.byEnergyRefreshEnabled = YES;
    }else if (refType == 1) {
        vc.byEnergyHideLoading = YES;
        vc.byEnergyHideProgress = YES;
        vc.byEnergyRefreshEnabled = NO;
    }
    [navigationController pushViewController:vc animated:YES];
}


#pragma mark ----- 充值验证定位是否正确
- (BOOL)canSearch {
    BOOL canSearch = YES;
    NSNumber *lat = [[BEnergyAppStorage sharedInstance].locationTagInfo objectForKey:@"lat"];
    NSNumber *lng = [[BEnergyAppStorage sharedInstance].locationTagInfo objectForKey:@"lng"];
    if (byEnergyIsNilOrNull(lat)||byEnergyIsNilOrNull(lng)) {
        canSearch = NO;
    } else if ([lat doubleValue]==0 && [lng doubleValue]==0) {
        canSearch = NO;
    }
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc showSheetStylePickerViewWithLastText:@"类别"];
    
    return canSearch;
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyStubGroupViewModel, stubGroupViewModel)
LCFLazyload(BEnergyChargeViewModel, byChargeViewModel)
LCFLazyload(BEnergyUserInfoViewModel, byUserInfoViewModel)
LCFLazyload(BEnergyNoticeCenterViewModel, byNoticeViewModel);
LCFLazyload(BEnergyCouponsViewModel, byCouponsViewModel);

- (BEnergyHomePagePopView *)byPopView {
    if (!_byPopView) {
        _byPopView = [[BEnergyHomePagePopView alloc]initWithFrame:CGRectZero];
        _byPopView.advImageView.delegate = self;
    }
    return _byPopView;
}

- (BEnergyCarNumberViewModel *)byCarNumberViewModel {
    if (!_byCarNumberViewModel) {
        _byCarNumberViewModel = [[BEnergyCarNumberViewModel alloc] init];
        _byCarNumberViewModel.hnFetchCarNumberCommand.netWorksModel.isShowError = NO;
    }
    return _byCarNumberViewModel;
}

- (UIButton *)byrefreshBtn {
    if (!_byrefreshBtn) {
        _byrefreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _byrefreshBtn.adjustsImageWhenHighlighted = NO;
        [_byrefreshBtn setBackgroundImage:[UIImage imageNamed:@"homeRefresh"] forState:UIControlStateNormal];
        _byrefreshBtn.layer.shadowColor = [UIColor grayColor].CGColor;
        _byrefreshBtn.layer.shadowOpacity = 0.5;
        _byrefreshBtn.layer.shadowOffset = CGSizeMake(0, 0);
        _byrefreshBtn.layer.shadowRadius = 3.0;
    }
    return _byrefreshBtn;
}

- (UIButton *)byListBtn {
    if (!_byListBtn) {
        _byListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _byListBtn.adjustsImageWhenHighlighted = NO;
        [_byListBtn setBackgroundImage:[UIImage imageNamed:@"homeList"] forState:UIControlStateNormal];
        _byListBtn.layer.shadowColor = [UIColor grayColor].CGColor;
        _byListBtn.layer.shadowOpacity = 0.5;
        _byListBtn.layer.shadowOffset = CGSizeMake(0, 0);
        _byListBtn.layer.shadowRadius = 3.0;
    }
    return _byListBtn;
}

- (MapManager *)byMapManager {
    if (!_byMapManager) {
        _byMapManager = [MapManager sharedManager];
        _byMapManager.controller = self;
        _byMapManager.showCenterAnnotation = YES;
        [_byMapManager initMapView];
    }
    return _byMapManager;
}

- (UIButton *)byCouponButton {
    if (!_byCouponButton) {
        _byCouponButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _byCouponButton.adjustsImageWhenHighlighted = NO;
        _byCouponButton.layer.shadowColor = [UIColor blackColor].CGColor;
        _byCouponButton.layer.shadowOpacity = 0.5;
        _byCouponButton.layer.shadowOffset = CGSizeMake(0, 0);
        _byCouponButton.layer.shadowRadius = 3.0;
        _byCouponButton.hidden = YES;
        [_byCouponButton setBackgroundImage:[UIImage imageNamed:@"home coupons"] forState:UIControlStateNormal];
        ByEnergyWeakSekf
        [[[_byCouponButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            [self.navigationController pushViewController:[BEnergyMyCouponsViewController new] animated:YES];
        }];
    }
    return _byCouponButton;
}

/*启动页广告相关通知（放在ViewDiload方法里面）
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(showAdvertiseDetailVc:)
                                             name:ADDetailPushCenter
                                           object:nil];

[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(showAlert)
                                             name:@"T_TLaunchAdDetailPageRemoveNotification"
                                           object:nil];*/

/*
#pragma mark ----- 广告跳转
- (void)showAdvertiseDetailVc:(NSNotification *)notification {
    [HUDManager hidenHud];
    NSDictionary *dic = notification.object;
    LaunchAdModel *model = (LaunchAdModel *)[dic objectForKey:@"models"];
    if (model != nil) {
        [self showWebWithpath:model.refType == 0 ? AdsDetailUrl : nil
                       params:model.refType == 0 ? @{@"id":model.id} : nil
                      baseUrl:model.refType == 0 ? URL_BASE : byEnergyClearNilStr(model.refId)
                     titleStr:model.refType == 0 ? @"详情" : @""
                      refType:model.refType
         navigationController:self.navigationController];
    }
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)showAlert {
    [self.byCarNumberViewModel.hnFetchCarNumberCommand execute:nil];
}*/
@end

