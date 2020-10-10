//
//  RepaymentViewController.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepaymentViewController.h"
//#import "TYTabButtonPagerController.h"
#import "RepayOnTimeViewController.h"
#import "RepayAdvanceViewController.h"
@interface RepaymentViewController ()
//@property (nonatomic, strong) TYTabButtonPagerController *pagerController;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *subVCArray;

@end

@implementation RepaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initDataAndViews];
}

- (void)initDataAndViews {
    
    self.title = @"";
//    [self addChildViewController:self.pagerController];
//    [self.view addSubview:self.pagerController.view];
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
//        _pagerController.normalTextColor = KCommonGrayTextColor;
//        _pagerController.normalTextFont = XYFontFromPixel(32);
//        _pagerController.selectedTextColor = kComminBlackTextColor;
//        _pagerController.selectedTextFont = XYFontFromPixel(32);
//        _pagerController.dataSource = self;
//        _pagerController.adjustStatusBarHeight = YES;
//        _pagerController.cellWidth = ScreenWidth/2;
//        _pagerController.progressColor = kCommonButtonBGColor;
//        _pagerController.progressWidth = 50;
//        _pagerController.progressHeight = 3;
//        _pagerController.contentTopEdging = GETHEIGHT(100);
//        _pagerController.pagerBarColor = APPGrayColor;
//        _pagerController.view.frame = CGRectMake(0.0f, 0.0f, ScreenWidth, self.view.zm_height - TabbarSafeBottomMargin);
//    }
//    return _pagerController;
//}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[];
    }
    return _titleArray;
}

- (NSArray *)subVCArray {
    if (!_subVCArray) {
        RepayOnTimeViewController *onTimevc = [RepayOnTimeViewController new];
        RepayAdvanceViewController *advancevc = [RepayAdvanceViewController new];
        onTimevc.loan_id = self.loan_id;
        advancevc.loan_id = self.loan_id;
        _subVCArray = @[onTimevc,advancevc];
    }
    return _subVCArray;
}


@end
