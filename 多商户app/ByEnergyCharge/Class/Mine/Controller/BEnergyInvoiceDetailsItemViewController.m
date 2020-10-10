
//
//  BEnergyInvoiceDetailsItemViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceDetailsItemViewController.h"
#import "BEnergyInvoiceDetailsItemChilderVC.h"
#import "ByEnergySlideMenuViewTool.h"

@interface BEnergyInvoiceDetailsItemViewController ()
@property (nonatomic,strong) ByEnergySlideMenuView *slideMenuView;
@property (nonatomic,strong) NSMutableArray *controllers;
@end

@implementation BEnergyInvoiceDetailsItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self byEnergyInitViews];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergyInitViews {
    self.navigationItem.title = @"开票明细";
    self.controllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i ++) {
        BEnergyInvoiceDetailsItemChilderVC *vc = [[BEnergyInvoiceDetailsItemChilderVC alloc] init];
        switch (i) {
            case 0:
                vc.statusType = InvoiceStatusTypeForChecking;
                break;
            case 1:
                vc.statusType = InvoiceStatusTypeForAlready;
                break;
            case 2:
                vc.statusType = InvoiceStatusTypeForLose;
                break;
            default:
                break;
        }
        [self addChildViewController:vc];
        [_controllers addObject:vc];
    }
    ByEnergySlideMenuModel *model = [[ByEnergySlideMenuModel alloc] init];
    model.titles = @[@"审核中",@"已开票",@"已失效"];
    model.controllers = _controllers;
    model.itemFont = ByEnergyRegularFont(16);
    model.indicatorImg = [UIImage imageWithColor:BYENERGYCOLOR(0x00BFE5)];
    model.showsHorizontalScrollIndicator = NO;
    model.itemUnselectedColor = [UIColor colorByEnergyWithBinaryString:@"#979797"];
    model.itemSelectedColor = BYENERGYCOLOR(0x00BFE5);
    ByEnergyWeakSekf
    _slideMenuView = [[ByEnergySlideMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40) SlideMenuModel:model completion:^(NSInteger index) {
        ByEnergyStrongSelf;
        BEnergyInvoiceDetailsItemChilderVC *vc  = self.controllers[index];
        [vc.tableView beginRefreshing];
    }];
    _slideMenuView.indicatorType = SlideMenuIndicatorTypeStrechAndMove;
    [self.view addSubview:_slideMenuView];
}


@end
