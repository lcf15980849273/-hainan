//
//  BEnergyChargeOrderViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargeOrderViewController.h"
#import "BEnergyChargeOrderChilderVC.h"
#import "ByEnergySlideMenuViewTool.h"
#import "ByEnergyScanManager.h"
#import "BEnergyHomeChargeListModel.h"

//......
#import "BEnergyStubViewController.h"
#import "CFCALayerViewController.h"
#import "coreGraphicsCustomView.h"
#import "SecondTableView.h"
#import "CFAutoCellHeightViewController.h"
@interface BEnergyChargeOrderViewController ()
@property (nonatomic,strong) ByEnergySlideMenuView *slideMenuView;
@property (nonatomic,strong) NSMutableArray *controllers;
@property (nonatomic,strong) NSDictionary *jsonDictionary;
@property (nonatomic,strong) NSMutableArray *datasArray;
@end

@implementation BEnergyChargeOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitDatas];
    
    [self byEnergyInitViews];
    
    kWeakSelf(self);
    ByEnergyReceivedNotification(ByEnergyChargeOrderRefresh, ^{
        for (BEnergyChargeOrderChilderVC *vc in weakself.controllers) {
            [vc refreshDatas];
        }
    }());
}

- (void)byEnergyInitDatas {
    BEnergyHomeChargeListModel *model = [[ByEnergyScanManager sharedByEnergyScanManager] homeChargeListModel];
    [self.datasArray addObject:@{@"充电中":@"1"}];
    if (model.isUnpaid) {
        [self.datasArray addObject:@{@"待支付":@"2"}];
    }
    [self.datasArray addObject:@{@"已完成":@"3"}];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergyInitViews {
    self.navigationItem.title = @"充电订单";
    for (int i = 0; i < [self.datasArray count]; i ++) {
        BEnergyChargeOrderChilderVC *vc = [[BEnergyChargeOrderChilderVC alloc] init];
//        NSDictionary *dic = [self.datasArray objectAtIndex:i];
//        vc.orderType = [[[dic allValues] objectAtIndex:0] integerValue];
        [self.controllers addObject:vc];
        [self addChildViewController:vc];
    }
    [self.view addSubview:self.slideMenuView];

    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}


#pragma mark -----懒加载-----

- (NSMutableArray *)controllers {
    if (!_controllers) {
        _controllers = [NSMutableArray new];
    }
    return _controllers;
}

- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [NSMutableArray new];
    }
    return _datasArray;;
}

- (ByEnergySlideMenuView *)slideMenuView {
    if (_slideMenuView == nil) {
        _slideMenuView = [[ByEnergySlideMenuView alloc] init];
        ByEnergySlideMenuModel *model = [[ByEnergySlideMenuModel alloc] init];
        model.titles = [[self.datasArray.rac_sequence.signal takeUntil:self.rac_willDeallocSignal] map:^id _Nullable(id  _Nullable value) {
            return  [[value allKeys] objectAtIndex:0];
        }].toArray;
        model.controllers = _controllers;
        model.itemFont = ByEnergyRegularFont(16);
        model.indicatorImg = [UIImage imageWithColor:BYENERGYCOLOR(0x00BFE5)];
        model.showsHorizontalScrollIndicator = NO;
        model.itemUnselectedColor = [UIColor colorByEnergyWithBinaryString:@"#0D131A"];
        model.itemSelectedColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
        ByEnergyWeakSekf
        _slideMenuView = [[ByEnergySlideMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45) SlideMenuModel:model completion:^(NSInteger index) {
            ByEnergyStrongSelf;
            BEnergyChargeOrderChilderVC *vc = [self.controllers objectAtIndex:index];
            vc.orderType = index == 0 ? ChargeOrderTypeForChargeing : ChargeOrderTypeForFinish;
            [vc.tableView beginRefreshing];
        }];
        _slideMenuView.indicatorType = SlideMenuIndicatorTypeStrechAndMove;
    }
    return _slideMenuView;
}


@end
