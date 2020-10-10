//
//  BDProblemFeedbackController.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDRunOrderController.h"
#import "BDBaseRunOrderController.h"
#import "BDAskQuestionController.h"
#import "BDRunOrderComplainController.h"


//#import "TYTabButtonPagerController.h"
@interface BDRunOrderController ()
//@property (nonatomic, strong) TYTabButtonPagerController *pagerController;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *subVCArray;

@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation BDRunOrderController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initDataAndViews];
    
}

- (void)initDataAndViews {
    
    self.title = @"跑单投诉";
   
}


#pragma mark - Action

//- (void)handleSaveButtonTaped {
//    DLog(@"点击投诉按钮");
//    BDRunOrderComplainController *vc = [[BDRunOrderComplainController alloc] init];
//    [TopestNavigationController pushViewController:vc animated:YES];
//}

//#pragma mark - <TYPagerControllerDataSource>
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
//
//#pragma mark - Lazy Load
//
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

- (NSMutableArray<BDBaseRunOrderController *> *)subVCArray {
    if (!_subVCArray) {
        _subVCArray = [NSMutableArray new];
        for (int i = 0; i < 2;  i++) {
            BDBaseRunOrderController * vc = [[BDBaseRunOrderController alloc] init];
            vc.type = i;
            [_subVCArray addObject:vc];
        }
    }
    return _subVCArray;
}



#pragma mark - Lazy Load

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton =  [UIButton zm_buttonWithTitle:@"投诉"
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
