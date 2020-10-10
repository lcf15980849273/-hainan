//
//  BEnergyChargeOrderDetailTableController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/18.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyChargeOrderDetailTableController.h"
#import "BEnergyStubDetailViewController.h"
#import "BEnergyChargeOrderViewController.h"
#import "BEnergyHomeVc.h"
#import "BEnergyChargeOrderDetailsCell.h"
#import "BEnergyChargeOrderDetailsHeadView.h"
#import "BEnergyChargeViewModel.h"
#import "BEnergyChargeOrderDetailsNumberCell.h"
#import "BEnergyStubViewController.h"
#import "MineTableViewController.h"
#import "BEnergyChargeOrderViewController.h"
#import "BEnergyStubDetailViewController.h"
#import "BEnergyChargeDetailModel.h"

//......
#import "BEnergyStubViewController.h"
#import "CFCALayerViewController.h"
#import "coreGraphicsCustomView.h"
#import "SecondTableView.h"
#import "CFAutoCellHeightViewController.h"
#import "coreGraphicsCustomView.h"

@interface BEnergyChargeOrderDetailTableController ()
@property (nonatomic, strong) BEnergyChargeOrderDetailsHeadView *headView;
@property (nonatomic, strong) BEnergyChargeViewModel *chargeViewModel;
@property (nonatomic, assign) BOOL  isChargeOrderVC;
@property(nonatomic, strong)BEnergyChargeDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;//终端编号
@property (weak, nonatomic) IBOutlet UIButton *zdTypeButton;//终端类型
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//充电时长
@property (weak, nonatomic) IBOutlet UILabel *socLabel;//soc
@property (weak, nonatomic) IBOutlet UILabel *dlLabel;//充电量
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//充电电费
@property (weak, nonatomic) IBOutlet UILabel *prepareLabel;//预充金额
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLabel;//充电服务费
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;//支付方式
@property (weak, nonatomic) IBOutlet UILabel *xfPricelabel;//消费金额
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;//优惠券抵扣
@property (weak, nonatomic) IBOutlet UILabel *sfPriceLabel;//实付金额
@property (weak, nonatomic) IBOutlet UILabel *tkPriceLabel;//退款金额
@property (weak, nonatomic) IBOutlet UILabel *ddCodeLabel;//订单编号
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;//开始时间
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;//结束时间
@property (weak, nonatomic) IBOutlet UILabel *stubGroupNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *institutionsLabel;//机构

@end

@implementation BEnergyChargeOrderDetailTableController

- (instancetype)init {
    return [BEnergyChargeOrderDetailTableController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitViews];
    
    [self byEnergyInitViewModel];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
    
}

- (void)byEnergyInitViews {
    
    self.isPopViewController = YES;
    self.navigationBarHiddenM = YES;
    self.statusBarStyle = UIStatusBarStyleLightContent;
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    self.tableView.separatorColor = UIColor.byEnergyLineGray;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.tableView.tableHeaderView = self.headView;
    [self byEnergyNavItemWithImgeNames:@[@"btn_service_mine"] isLeft:NO target:self action:@selector(serviceBtnAct) tags:@[@(0)]];
    [self byEnergyNavItemWithImgeNames:@[@"btn_return_mine"] isLeft:YES target:self action:@selector(backBtnClicked) tags:@[@(0)]];
    
    for (UIViewController * vc in [self.navigationController viewControllers]) {
        if ([vc isKindOfClass:[BEnergyChargeOrderViewController class]]) {
            self.isChargeOrderVC = YES;
            [self popToPointViewController:NSStringFromClass([BEnergyChargeOrderViewController class])];
        }else if ([vc isKindOfClass:[BEnergyHomeVc class]]) {
            [self popToPointViewController:NSStringFromClass([BEnergyHomeVc class])];
        }else if ([vc isKindOfClass:[BEnergyStubViewController class]]) {
            [self popToPointViewController:NSStringFromClass([BEnergyStubViewController class])];
        }else if ([vc isKindOfClass:[MineTableViewController class]]) {
            [self popToPointViewController:NSStringFromClass([MineTableViewController class])];
        }else if ([vc isKindOfClass:[BEnergyChargeOrderViewController class]]) {
            [self popToPointViewController:NSStringFromClass([BEnergyChargeOrderViewController class])];
        }else if ([vc isKindOfClass:[BEnergyStubDetailViewController class]]) {
            [self popToPointViewController:NSStringFromClass([BEnergyStubDetailViewController class])];
        }
    }
    
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
    self.chargeViewModel.orderId = self.orderId;
    [[[[self.chargeViewModel.hnOrderFinshDetailCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        self.detailModel = x;
        [self confilgWithChargeDetailData];
    }];
    
    [[self.chargeViewModel.hnOrderFinshDetailCommand errors] subscribeNext:^(NSError * _Nullable x) {
        
    }];
    [self.chargeViewModel.hnOrderFinshDetailCommand execute:nil];
    
}

- (void)confilgWithChargeDetailData {
    self.headView.reasonLabel.text = NSStringFormat(@"结束原因:%@",byEnergyClearNilReturnStr([self.chargeViewModel.value fetchValueWithName:@"endInfo"], @"无"));
    self.codeLabel.text = self.detailModel.stubId;
    [self.zdTypeButton setTitle:self.detailModel.chargeTypeDesc forState:UIControlStateNormal];
    self.timeLabel.text = self.detailModel.timeDiff;
    self.socLabel.text = [NSString stringWithFormat:@"%@%%",self.detailModel.endsoc];
    self.dlLabel.text = [NSString stringWithFormat:@"%.2f度",self.detailModel.power];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元",self.detailModel.feeElectric];
    self.servicePriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.detailModel.feeService];
    self.payTypeLabel.text = self.detailModel.payDesc;
    self.xfPricelabel.text = [NSString stringWithFormat:@"%@元",self.detailModel.couponOrginalPrice];
    self.sfPriceLabel.text = [NSString stringWithFormat:@"%@元",self.detailModel.couponFinalPrice];
    self.ddCodeLabel.text = self.detailModel.id;
    self.startTimeLabel.text = self.detailModel.timeStart;
    self.endTimeLabel.text = self.detailModel.timeEnd;
    self.couponLabel.text = [NSString stringWithFormat:@"%@元",self.detailModel.couponDicountPrice];
    self.tkPriceLabel.text = [NSString stringWithFormat:@"%.2f元",self.detailModel.refundFee];
    self.stubGroupNameLabel.text = self.detailModel.stubGroupName;
    self.prepareLabel.text = [NSString stringWithFormat:@"%@元",self.detailModel.rechargeFee];;
    
    self.institutionsLabel.text = self.detailModel.organizationName;
    [self.tableView reloadData];
    
    //......
    coreGraphicsCustomView *vc = [coreGraphicsCustomView new];
    [vc pushWithDefalutView];
}

#pragma mark ----- tableViewDelegate Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return 60.0f;
        }else if (indexPath.row == 1) {
            return 20.0f;
        }else {
            return 50.0f;;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            return [self.detailModel.couponDicountPrice floatValue] <= 0 ? 0.0f : 50.0f;
        }else if (indexPath.row == 4) {
            return self.detailModel.refundFee <= 0 ? 0.0f : 50.0f;
        }else if (indexPath.row == 2) {
            return !self.detailModel.isRefund ? 0.0f : 50.0f;
        }else if (indexPath.row == 5) {
            return self.detailModel.startType == 16 ? 50.0f : 0.0f;
        }else {
            return 50.0f;
        }
    }else {
        return 50.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 9.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        /*
       BEnergyStubDetailViewController *vc = [[BEnergyStubDetailViewController alloc] init];
       vc.stubGroupID = byEnergyClearNilStr([self.chargeViewModel.value fetchValueWithName:@"stubGroupId"]);
       [self.navigationController pushViewController:vc animated:YES];*/
    }
}

#pragma mark ----- scrolerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat yOffset = scrollView.contentOffset.y; // 偏移的y值，还要考虑导航栏的64哦
//    if (yOffset < 20) {//向下拉是负值，向上是正
//        self.title = @"";
//        self.navigationBarHiddenM = YES;
//        [self.backBtn setImage:IMAGEWITHNAME(@"btn_return_mine") forState:UIControlStateNormal];
//        [self.rightBtn setImage:IMAGEWITHNAME(@"btn_service_mine") forState:UIControlStateNormal];
//    }else {
//        self.title = @"充电已完成";
//        self.navigationBarHiddenM = NO;
//        [self.backBtn setImage:IMAGEWITHNAME(@"btn_return") forState:UIControlStateNormal];
//        [self.rightBtn setImage:IMAGEWITHNAME(@"btn_service") forState:UIControlStateNormal];
//    }
}

#pragma mark ----- Action
- (void)serviceBtnAct {
    [AlertViewTools showServiceNumber];
}

- (IBAction)copyButtonClick:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.ddCodeLabel.text;
    [HUDManager showStateHud:@"复制成功" state:HUDStateTypeSuccess];
    
    //......
    coreGraphicsCustomView *vc = [coreGraphicsCustomView new];
    [vc pushWithDefalutView];
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyChargeViewModel, chargeViewModel)

- (BEnergyChargeOrderDetailsHeadView *)headView {
    if (!_headView) {
        _headView = [ByEnergyLoadViews loadViewFromNib:@"BEnergyChargeOrderDetailsHeadView"];
        _headView.frame = CGRectMake(0, 0, SCREENWIDTH, 88 + NavigationStatusBarHeight);
    }
    return _headView;
}

@end

