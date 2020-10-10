
//
//  BEnergyStubDetailViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubDetailViewController.h"
#import <UShareUI/UShareUI.h>
#import "RYCoverView.h"
#import "BEnergyPriceFormView.h"
#import "ByEnergySlideMenuView.h"
#import "ByEnergyBaseScrollView.h"
#import "BaseScrollViewFollowTbaleView.h"
#import "BEnergyStubGroupDetailHeadView.h"
#import "BEnergyStubGroupDetailIntegralCell.h"
#import "BEnergyStubGroupDetailBaseCell.h"
#import "BEnergyStubGroupViewModel.h"
#import "BEnergyStubGroupDetailModel.h"
#import "AlertViewTools.h"
#import "UILabel+FitLines.h"
#import "ImageBrowserViewController.h"
#import "SCPermission.h"
#import "ByEnergyScanManager.h"
#import "BEnergyPayTypeInfoCell.h"
#import "BEnergyStubGroupDetailFooterView.h"
#import "BEnergyStubDetailInfoCell.h"

//.....
#import "RepayBottomView.h"
#import "coreGraphicsCustomView.h"
#import "CFAutoCellHeightCell.h"
#import "coreGraphicsCustomView.h"

#define ScrollTop                192//头部从哪里开始悬停
#define TableSectionDistance     369
@interface BEnergyStubDetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,
UITableViewDataSource,ImageBrowserViewControllerDelegate>

@property (nonatomic,strong) BEnergyStubGroupDetailHeadView *byDetailHeadView;
@property (nonatomic,strong) ByEnergyBaseScrollView *byRootScrollView;//byRootScrollView要有滑动穿透
@property (nonatomic,strong) BaseScrollViewFollowTbaleView *scrollFollow;//必须写成属性
@property (nonatomic,strong) ByEnergySlideMenuView *bySlideMenuView;//选择卡
@property (nonatomic,strong) UIView *bySlideMenuHeadView;//选择卡bg
@property (nonatomic,strong) BEnergyPriceFormView *byPriceFormView;//价格时间表
@property (nonatomic,strong) UIScrollView *byHeadScrollView;
@property (nonatomic,strong) ImageBrowserViewController *byBrowserViewVC;//图片查看器
@property (nonatomic,strong) BEnergyStubGroupDetailFooterView *footerView;
@property (nonatomic,strong) BEnergyStubGroupViewModel *stubGroupViewModel;//ViewModel
@property (nonatomic,strong) BEnergyStubGroupDetailModel *byStubGroupDetailModel;
@property (nonatomic,strong) SocProgressModel *progressMoel;//桩充电量进度
@property (nonatomic,assign) BOOL canMove;
@property (nonatomic,assign) BOOL animated;
@property (nonatomic,strong) RACDisposable * dispoable;
@property (nonatomic,assign) BOOL isStart;//是否已启动定时器
@end

@implementation BEnergyStubDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitViews];
    
    [self byEnergySetViewLayout];
    
    [self byEnergyInitViewModel];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
    
    /*
    [self byEnergyNavItemWithImgeNames:@[@"actcenter"] isLeft:NO
                                     target:self
                                     action:@selector(serviceAndShareBtnAct)
                                       tags:@[@2000,@2001]];*/
    
}

/*
- (void)serviceAndShareBtnAct {
    ShareModel *model = [ShareModel new];

    
    model.text = @"分享美图啦啦啦啦";
    model.thumImage = @"mineBack";
    model.shareImage = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2168899201,507192445&fm=26&gp=0.jpg";
    model.platformsArray = @[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)];
    model.controller = self;
    [BEnergyShareTool shareWithContentModel:model useImageType:useImgeTypeNomal shareType:shareImageAndText];
}*/

- (void)viewDidDisappear:(BOOL)animated {
    [self.dispoable dispose];
}

- (void)byEnergyInitViews {

    self.title = @"电站详情";
    [self.view addSubview:self.footerView];
    self.byDetailHeadView = [[BEnergyStubGroupDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 320)];
    
    self.byRootScrollView = [[ByEnergyBaseScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - kTopHeight - self.footerView.height - 5)];
    self.byRootScrollView.delegate = self;
    self.byRootScrollView.showsVerticalScrollIndicator = NO;
    self.byRootScrollView.contentSize = CGSizeMake(self.byRootScrollView.bounds.size.width, self.byRootScrollView.bounds.size.height + ScrollTop);
    UIScrollView *headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.byRootScrollView.bounds.size.width, self.byDetailHeadView.height)];
    headScrollView.contentSize = CGSizeMake(self.byRootScrollView.bounds.size.width, headScrollView.bounds.size.height);
    headScrollView.pagingEnabled = YES;
    headScrollView.backgroundColor = [UIColor whiteColor];
    headScrollView.tag = 1001012;
    headScrollView.showsVerticalScrollIndicator = NO;
    [headScrollView addSubview:self.byDetailHeadView];
    
    self.byHeadScrollView = headScrollView;
    [self.byRootScrollView addSubview:headScrollView];
    [self.view addSubview:self.byRootScrollView];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.byDetailHeadView.height, self.byRootScrollView.bounds.size.width, self.byRootScrollView.bounds.size.height-(headScrollView.height-ScrollTop))];
    scrollView.contentSize = CGSizeMake(self.byRootScrollView.bounds.size.width, scrollView.bounds.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.tag = 1001011;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.byRootScrollView addSubview:scrollView];
    [scrollView addSubview:self.bySlideMenuHeadView];
    
    self.isGrouped = YES;
    self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.bySlideMenuHeadView.frame), self.byRootScrollView.bounds.size.width, scrollView.bounds.size.height-CGRectGetHeight(self.bySlideMenuHeadView.frame));
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    self.tableView.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0, 0, 0, CGFLOAT_MIN);
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:frame];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:frame];
    [scrollView addSubview:self.tableView];
    self.animated = NO;
    self.canMove = NO;
    self.scrollFollow = [[BaseScrollViewFollowTbaleView alloc] initRootScrollView:self.byRootScrollView AndRootScrollViewScrollRange:ScrollTop moveBolck:^(BOOL value) {
        self.canMove = value;
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyPayTypeInfoCell bundle:nil] forCellReuseIdentifier:kBEnergyPayTypeInfoCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyStubDetailInfoCell bundle:nil] forCellReuseIdentifier:kBEnergyStubDetailInfoCell];
    
    
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.footerView.frame = CGRectMake(0, SCREENHEIGHT - 80 - kTopHeight, SCREENWIDTH, 80);
}

- (void)backBtnClicked {

    [self.navigationController popViewControllerAnimated:YES];
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc showSheetStylePickerViewWithLastText:@"类别"];
}

- (void)byEnergySetViewLayout {
    
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[[self.stubGroupViewModel.hnStubDetailsCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.stubGroupViewModel.result) {
            self.byStubGroupDetailModel = self.stubGroupViewModel.value;
            [self.byDetailHeadView fillDataWithDataModel:self.stubGroupViewModel.value];
            [BEnergyStubGroupDetailHeadView calculateTableHeaderViewHeightWithModel:self.byStubGroupDetailModel];
            self.byPriceFormView.datasArray = [[self.stubGroupViewModel.value priceDetails] mutableCopy];
            [self.byPriceFormView.tableView reloadData];
            [self updateMenu];
            if ([[self.stubGroupViewModel.value priceDetails] count] < 3) {
                self.byPriceFormView.height = [[self.stubGroupViewModel.value priceDetails] count] * 117 + 82;
            }
            self.footerView.gropDetailModel = self.stubGroupViewModel.value;
            [self.tableView reloadData];
        }
        [self.byRootScrollView endRefreshing];
    }];
    
    [[[self.stubGroupViewModel.hnStubDetailsCommand errors] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSError * _Nullable x) {
        [self.tableView endRefreshing];
    }];
    
    [[[self.byPriceFormView closeSubject] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        [RYCoverView hide];
    }];
    
    [[self.byDetailHeadView.focusIndexSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        kWeakSelf(self);
        if ([[self.stubGroupViewModel.value imgUrls] count] > 0) {
            [SCPermission authorizedWithType:SCPermissionType_Photos WithResult:^(BOOL granted) {
                if (granted) {
                    [ImageBrowserViewController show:self
                                                type:ImageBrowserVCTypeZoom
                                               index:[x intValue]
                                         imagesBlock:^NSArray *{
                        return [weakself.stubGroupViewModel.value imgUrls];
                    } completion:^(ImageBrowserViewController *browserVC) {
                        weakself.byBrowserViewVC = browserVC;
                        [browserVC setActionSheetWithTitle:@""
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         deleteButtonTitle:nil
                                         otherButtonTitles:@"保存至本地", nil];
                    }];
                }
            }];
        }
    }];
    
    kWeakSelf(self);
    self.byRootScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself fetchStubGroupDetailInfo];
    }];
    [self fetchStubGroupDetailInfo];
    
   
    [[[[self.stubGroupViewModel.hnStubChargingProgressCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        self.progressMoel = [SocProgressModel yy_modelWithJSON:x];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        
        if (self.progressMoel.frequence > 0 && !self.isStart) {
            self.isStart = YES;
            self.dispoable = [[[RACSignal interval:self.progressMoel.frequence onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDate * _Nullable x) {
                [self.stubGroupViewModel.hnStubChargingProgressCommand execute:@{@"stubGroupId":self.stubGroupID}];
            }];
        }
    }];
    
    [[[self.stubGroupViewModel.hnStubChargingProgressCommand errors] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.dispoable dispose];
    }];
    
     [self.stubGroupViewModel.hnStubChargingProgressCommand execute:@{@"stubGroupId":self.stubGroupID}];
    
}

#pragma mark -----TableViewDelegate && TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 2 : [[self.stubGroupViewModel.value stubList] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            return indexPath.row == 0 ? 150.0f : 126.0f;
            break;
        case 1:
            return 90.0f;
            break;
        default:
            return 90.0f;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 1 ? 48.0f : 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            BEnergyStubGroupDetailIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:kBEnergyStubGroupDetailIntegralCell];
            if (!cell) {
                cell = [[BEnergyStubGroupDetailIntegralCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:kBEnergyStubGroupDetailIntegralCell];
            }
            cell.formView = self.byPriceFormView;
            cell.model = self.stubGroupViewModel.value;
            return cell;
        }else {
            BEnergyPayTypeInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyPayTypeInfoCell];
            cell.model = self.stubGroupViewModel.value;
            return cell;
        }
    }else {
        BEnergyStubDetailInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyStubDetailInfoCell];
        [cell byEnergyFillCellDataWithModel:[[self.stubGroupViewModel.value stubList] objectAtIndex:indexPath.row]];
        cell.stubListModel = self.progressMoel.stubList[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"充电终端";
        label.font = ByEnergyRegularFont(16);
        label.textColor = [UIColor colorByEnergyWithBinaryString:@"#1D1D1D"];
        label.firstLineHeadIndent = 20;
        return label;
    }
    return [UIView new];
}

#pragma mark -----scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.canMove == YES) {
        self.scrollFollow.canMove = NO;
    }else{
        if (!self.animated) {
            [scrollView setContentOffset:CGPointMake(0, 0)];
        }
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        self.scrollFollow.canMove = YES;
        // 告诉其他滚动视图能滚动了
        self.canMove = NO;   // 自己不能滑动了
    }
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    if (scrollView == self.tableView) {
        if (scrollView.contentOffset.y >= TableSectionDistance) {
            [self.bySlideMenuView byEnergyslideSelectorItemDidClicked:1];
        }else {
            [self.bySlideMenuView byEnergyslideSelectorItemDidClicked:0];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.animated = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.animated = NO;
}

#pragma mark ----- Action
- (void)updateMenu {
    float top = ScrollTop;
    float headHeight = [BEnergyStubGroupDetailHeadView calculateTableHeaderViewHeightWithModel:self.byStubGroupDetailModel];
    //滚动大小
    self.byRootScrollView.contentSize = CGSizeMake(self.byRootScrollView.bounds.size.width, self.byRootScrollView.bounds.size.height + top);
    self.byHeadScrollView.frame = CGRectMake(0, 0, self.byRootScrollView.bounds.size.width, headHeight);
    self.byDetailHeadView.frame = self.byHeadScrollView.bounds;
    self.byHeadScrollView.contentSize = CGSizeMake(0, headHeight);
    self.scrollFollow.scrollRange = top;
    UIScrollView *scrollView = [self.byRootScrollView viewWithTag:1001011];
    scrollView.top = headHeight;
    scrollView.contentSize = CGSizeMake(0, self.byRootScrollView.bounds.size.height - (headHeight - top));
    self.tableView.frame = CGRectMake(0,CGRectGetHeight(self.bySlideMenuHeadView.frame), self.byRootScrollView.bounds.size.width,self.byRootScrollView.bounds.size.height - (headHeight - top) - CGRectGetHeight(self.bySlideMenuHeadView.frame));
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:NO];
    ByEnergySlideMenuModel *model = [[ByEnergySlideMenuModel alloc] init];
    model.titles = @[@"站点详情",NSStringFormat(@"终端列表(%zd)",[[self.stubGroupViewModel.value stubList] count])];
    self.bySlideMenuView.slideMenuModel = model;
}

#pragma mark-----ImageBrowserViewControllerDelegate
- (void)photoBrowser:(ImageBrowserView *)browser clickActionSheetIndex:(NSInteger)actionSheetindex currentImageIndex:(NSInteger)currentImageIndex {
    if (actionSheetindex == 0) {
        [browser saveImage];
    }
    
    //......
    coreGraphicsCustomView *vc = [coreGraphicsCustomView new];
    [vc pushWithDefalutView];
}

- (void)fetchStubGroupDetailInfo {
    NSMutableDictionary *tagInfo = [NSMutableDictionary dictionary];
    [tagInfo addEntriesFromDictionary:[BEnergyAppStorage sharedInstance].locationTagInfo];
    [tagInfo setObject:byEnergyClearNilStr(self.stubGroupID) forKey:@"id"];
    [self.stubGroupViewModel.hnStubDetailsCommand execute:tagInfo];
    
    
    //......
    coreGraphicsCustomView *vc = [coreGraphicsCustomView new];
    [vc pushWithDefalutView];
}

#pragma mark ----- lazyLoad
LCFLazyload(BEnergyStubGroupViewModel, stubGroupViewModel)
LCFLazyload(BEnergyStubGroupDetailModel, byStubGroupDetailModel)
LCFLazyload(SocProgressModel, progressMoel)

- (BEnergyStubGroupDetailFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle]loadNibNamed:@"BEnergyStubGroupDetailFooterView" owner:self options:nil]lastObject];
        _footerView.layer.shadowOffset = CGSizeMake(0, 2);
        _footerView.layer.shadowOpacity = 1.0;
        _footerView.layer.shadowRadius = 5;
        _footerView.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                                 green:0.0f/255.0f
                                                  blue:0.0f/255.0f
                                                 alpha:0.1].CGColor;
    }
    return _footerView;
}

- (UIView *)bySlideMenuHeadView {
    if (!_bySlideMenuHeadView) {
        _bySlideMenuHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 46)];
        _bySlideMenuHeadView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
        [_bySlideMenuHeadView addSubview:self.bySlideMenuView];
    }
    return _bySlideMenuHeadView;
}

- (BEnergyPriceFormView *)byPriceFormView {
    if (!_byPriceFormView) {
        _byPriceFormView = [[BEnergyPriceFormView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 436)];
    }
    return _byPriceFormView;
}

- (ByEnergySlideMenuView *)bySlideMenuView {
    if (!_bySlideMenuView) {
        ByEnergySlideMenuModel *model = [[ByEnergySlideMenuModel alloc] init];
        model.titles = @[@"站点详情",@"终端列表"];
        model.itemFont = ByEnergyBoldFont(16);
        model.indicatorImg = [UIImage imageWithColor:BYENERGYCOLOR(0x00BFE5)];
        model.showsHorizontalScrollIndicator = NO;
        model.itemUnselectedColor = [UIColor colorByEnergyWithBinaryString:@"#3b3b3b"];
        model.itemSelectedColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
        kWeakSelf(self);
        _bySlideMenuView = [[ByEnergySlideMenuView alloc] initWithFrame:CGRectMake(0, 6, SCREENWIDTH, 40)
                                               SlideMenuModel:model
                                                   completion:^(NSInteger index) {
            weakself.animated = YES;
            if (index == 1 && weakself.byRootScrollView.contentOffset.y < ScrollTop) {
                [weakself.byRootScrollView setContentOffset:CGPointMake(0, ScrollTop) animated:YES];
            }
            if ([[(BEnergyStubGroupDetailModel *)weakself.stubGroupViewModel.value stubList] count] == 0) {
                if (index == 0) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [weakself.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }else {
                    CGRect rect = [weakself.tableView rectForFooterInSection:2];
                    [weakself.tableView scrollRectToVisible:CGRectMake(rect.origin.x, rect.origin.y+15, rect.size.width, rect.size.height) animated:YES];
                }
            }else {
                weakself.canMove = index == 1 ? YES : NO;   // 自己不能滑动了
                [weakself.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index ? 1 : 0]
                                                animated:YES
                                          scrollPosition:UITableViewScrollPositionTop];
            }
        }];
        _bySlideMenuView.backgroundColor = [UIColor whiteColor];
    }
    return _bySlideMenuView;
}


@end
