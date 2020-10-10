//
//  BDShopCounponViewController.m
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopCounponViewController.h"
#import "BDShopCounponListViewController.h"
//#import "TYTabButtonPagerController.h"
@interface BDShopCounponViewController ()
//@property (nonatomic, strong) TYTabButtonPagerController *pagerController;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *subVCArray;
@end

@implementation BDShopCounponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
}

- (void)initDataAndViews {
    
    self.title = @"小店优惠卡";
    //添加分页控制器
//    [self addChildViewController:self.pagerController];
//    //添加View
//    [self.view addSubview:self.pagerController.view];
//    /*pagerController 默认自动调用reloadData的时机，
//     是在viewWillAppear和viewWillLayoutSubviews
//     而viewDidLoad至此之前，所以需要手动调用reloadData*/
//    [_pagerController reloadData];
//    [_pagerController moveToControllerAtIndex:0 animated:NO];

    
}

#pragma mark - <TYPagerControllerDataSource>
//- (NSInteger)numberOfControllersInPagerController {
//    return self.subVCArray.count;
//}
//
//- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index {
//    return self.titleArray[index];
//}
//
//- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index {
//    return self.subVCArray[index];
//}

#pragma mark - Lazy Load
//- (TYTabButtonPagerController *)pagerController {
//    if (!_pagerController) {
//        _pagerController = [[TYTabButtonPagerController alloc] init];
//        _pagerController.normalTextColor = COLOR_666666;
//        _pagerController.normalTextFont = ByEnergyRegularFont(15);
//        _pagerController.selectedTextColor = COLOR_333333;
//        _pagerController.selectedTextFont = BDSemiboldFont(15);
//        _pagerController.dataSource = self;
//        _pagerController.adjustStatusBarHeight = YES;
//        _pagerController.cellWidth = ScreenWidth/2;
//        _pagerController.progressColor = COLOR_f8d64c;
//        _pagerController.progressWidth = 30;
//        _pagerController.view.frame = CGRectMake(0.0f, 0.0f, ScreenWidth, self.view.zm_height - (ViewSafeAreaInsets(self.view).bottom ));
//        _pagerController.contentView.scrollEnabled = NO;
//    }
//    return _pagerController;
//}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"我收藏的",@"我分销的"];
    }
    return _titleArray;
}

- (NSMutableArray<BDShopCounponListViewController *> *)subVCArray {
    if (!_subVCArray) {
        _subVCArray = [NSMutableArray new];
        for (int i = 1; i < 3;  i++) {
            BDShopCounponListViewController * vc = [[BDShopCounponListViewController alloc] init];
            vc.type = i;
            vc.isMyshop = YES;
            [_subVCArray addObject:vc];
        }
    }
    return _subVCArray;
}

@end
