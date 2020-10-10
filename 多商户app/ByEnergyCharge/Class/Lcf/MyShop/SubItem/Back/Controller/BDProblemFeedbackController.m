//
//  BDProblemFeedbackController.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDProblemFeedbackController.h"
#import "BDBaseProblemFeedbackController.h"
#import "BDAskQuestionController.h"

@interface BDProblemFeedbackController ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray<BDBaseProblemFeedbackController *> *subVCArray;

@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation BDProblemFeedbackController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initDataAndViews];
    
}

- (void)initDataAndViews {
    
//    self.title = @"问题反馈";
//    //添加分页控制器
//    [self addChildViewController:self.pagerController];
//    //添加View
//    [self.view addSubview:self.pagerController.view];
//
//    /*pagerController 默认自动调用reloadData的时机，
//     是在viewWillAppear和viewWillLayoutSubviews
//     而viewDidLoad至此之前，所以需要手动调用reloadData*/
//    [_pagerController reloadData];
//    [_pagerController moveToControllerAtIndex:0 animated:NO];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
}


#pragma mark - Action

- (void)handleSaveButtonTaped {
//    DLog(@"点击提问按钮");
    
    BDAskQuestionController *vc = [[BDAskQuestionController alloc] init];
    ByEnergyWeakSekf;
    vc.askSuccessBlock = ^{
        ByEnergyStrongSelf;
        for (BDBaseProblemFeedbackController *vc in self.subVCArray) {
//            [vc refreshData];
        }
    };
//    [TopestNavigationController pushViewController:vc animated:YES];
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
//    }
//    return _pagerController;
//}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"待回复",@"已回复"];
    }
    return _titleArray;
}

- (NSMutableArray<BDBaseProblemFeedbackController *> *)subVCArray {
    if (!_subVCArray) {
        _subVCArray = [NSMutableArray new];
        for (int i = 0; i < 2;  i++) {
            BDBaseProblemFeedbackController * vc = [[BDBaseProblemFeedbackController alloc] init];
            vc.type = i;
            [_subVCArray addObject:vc];
        }
    }
    return _subVCArray;
}



#pragma mark - Lazy Load

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton =  [UIButton zm_buttonWithTitle:@"提问"
                                              frame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)
                                              image:nil
                                              color:APPGrayColor
                                               font:ByEnergyRegularFont(16.0f)];
        _saveButton.titleEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        [_saveButton addTarget:self
                        action:@selector(handleSaveButtonTaped)
              forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _saveButton;
}

@end
