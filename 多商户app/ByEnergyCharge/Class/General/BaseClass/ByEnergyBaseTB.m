//
//  ByEnergyBaseTB.m
//  byCF
//
//  Created by 刘辰峰 on 2020/4/16.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import "ByEnergyBaseTB.h"
#import "ByEnergyBaseNavi.h"
#import "BEnergyHomeVc.h"
#import "BEnergyStubViewController.h"
#import "MineTableViewController.h"
#import "BEnergyChargeOrderViewController.h"
#import "ByEneryCustomTaBar.h"
#import "BEnergyScanQRViewController.h"
#import "BEnergyChargeViewModel.h"
#import "BEnergyPrepareChargeTableController.h"
@interface ByEnergyBaseTB ()<UITabBarControllerDelegate,UITabBarDelegate,CustomTabBarDelegate>
@property (nonatomic, strong) ByEnergyBaseNavi *homeNavi;
@property (nonatomic, strong) ByEnergyBaseNavi *mineNavi;
@property (nonatomic, strong) ByEnergyBaseNavi *stubListNavi;
@property (nonatomic, strong) ByEnergyBaseNavi *chargeOrderNavi;
@property (nonatomic, strong) BEnergyHomeVc *BEnergyHomeVc;
@property (nonatomic, strong) BEnergyStubViewController *stubListViewController;
@property (nonatomic, strong) BEnergyChargeOrderViewController *chargeOrderListViewController;
@property (nonatomic, strong) MineTableViewController *mineViewController;
@property (nonatomic, strong) BEnergyChargeViewModel *chargeViewModel;
@end

@implementation ByEnergyBaseTB


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configTabbar];
    
    [self addControllers];
    
    [self addObserver];
    
    [self fetchBadgeCount];
    
    ByEnergyWeakSekf
    ByEnergyReceivedNotification(kByEnergyUpdateBadge, ^{
        ByEnergyStrongSelf
        [self fetchBadgeCount];
    }());
    
    ByEnergyReceivedNotification(ByEnergyLogout, ^{
        ByEnergyStrongSelf
        //登录逻辑修改
//        [ByEnergyTopVC.navigationController popToRootViewControllerAnimated:NO];
        [self logoutSelectTabaIndex];
    }());
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - privateMetohd

+ (instancetype)shareInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (void)configTabbar {
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    ByEneryCustomTaBar *tabbar = [[ByEneryCustomTaBar alloc] init];
    tabbar.myDelegate = self;
    self.delegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [[UITabBar appearance]setBackgroundColor:[UIColor whiteColor]];//设置tabBar的背景颜色(需要结合translucent属性)
//    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;//tabBar的透明度
//    [[UITabBar appearance]setBackgroundImage:[[UIImage alloc]init]];//tabBar的背景图片
   /*
    注意：
    这里设置tabBar的半透明属性translucent设置为NO，默认为YES,若保留半透明效果，设置的颜色会与正常的颜色有色差;
    */
    [tabbar layoutIfNeeded];
    
    //修改tabar顶部线条颜色
//    CGRect rect = CGRectMake(0.0f, 0.0f, SCREENWIDTH, 0.5);
//    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor colorByEnergyWithBinaryString:@"#ffffff"].CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.tabBar setShadowImage:image];
//    [self.tabBar setBackgroundImage:[UIImage new]];

   
}

- (void)fetchBadgeCount {
//    ByEnergyWeakSekf
//    [[[[self.chargeViewModel.hnOdderListCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
//        ByEnergyStrongSelf
//        NSArray *array = x;
//        if (array.count != 0) {
//            [self.tabBar showOrHidenBadgeViewWithIndex:3 Flag:YES Count:array.count];
//        }else {
//            [self.tabBar hideBadgeOnItemIndex:3];
//        }
//    }];
//    [self.chargeViewModel.hnOdderListCommand execute:nil];
}

- (void)logoutSelectTabaIndex {
    [self hnByEnergyAfter:0.5 action:^{
        // 退出登录后切换到首页
        [self setSelectedIndex:0];
    }];
}

#pragma mark - CustomTabBarDelegate
- (void)tabBarPlusBtnClick:(ByEneryCustomTaBar *)tabBar {
    
    //登录逻辑修改前
    if (isLogOut) {
        [BEnergyLoginManger ByEnergyPresentLoginViewController];return;
    }//
    
    BEnergyScanQRViewController *vc = [BEnergyScanQRViewController new];
    vc.style = [BEnergyScanQRViewController ScanViewStyle];
    vc.isOpenInterestRect = YES;
    vc.libraryType = SLT_Native;
    vc.scanCodeType = SCT_QRCode;
    vc.isNeedScanImage = YES;
    NSDictionary *objc = @{@"viewShowState":@(YES),@"delayTime":@(0.15)};
    ByEnergySendNotification(ByEnergyUpdateRemoveMapPopView, objc);
    vc.ispushCharging = NO;
    [ByEnergyTopVC.navigationController pushViewController:vc animated:YES];
        
}

- (void)addControllers {
    [self addChildViewController:self.homeNavi];
//    [self addChildViewController:self.stubListNavi];
//    
//    [self addChildViewController:self.chargeOrderNavi];
    [self addChildViewController:self.mineNavi];

    if (@available(iOS 13.0, *)) {
         UITabBarAppearance *appearance = UITabBarAppearance.new;
        NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc]init];
        par.alignment = NSTextAlignmentCenter;
        UITabBarItemStateAppearance *normal = appearance.stackedLayoutAppearance.normal;
        if (normal) {
             normal.titleTextAttributes = @{NSForegroundColorAttributeName:BYENERGYCOLOR(0x626262),NSParagraphStyleAttributeName : par};
        }
        UITabBarItemStateAppearance *selected = appearance.stackedLayoutAppearance.selected;
        if (selected) {
            selected.titleTextAttributes = @{NSForegroundColorAttributeName:BYENERGYCOLOR(0x007896),NSParagraphStyleAttributeName : par};
        }
        self.tabBar.standardAppearance = appearance;
    }else {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:BYENERGYCOLOR(0x007896) forKey:NSForegroundColorAttributeName];
        [_homeNavi.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
        [_stubListNavi.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
        [_chargeOrderListViewController.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
        [_mineNavi.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    }


}

- (void)addObserver {
    
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //判断消息或者我的模块在没有登录的时候跳转到登录页面
    
    //登录逻辑修改
    if (isLogOut) {
        [BEnergyLoginManger ByEnergyPresentLoginViewController];
        return NO;
    }else {
        return YES;
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    // 选中viewController后执行的Action
}

#pragma mark - UItabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    //用户选中某个UITabBarItem
    NSInteger index = [self.tabBar.items indexOfObject:item];
    //根据哪个模块切换过来的时候需要隐藏badgeView
    if (index == 1) {
//        [self.tabBar showOrHidenBadgeViewWithIndex:index Flag:NO];
    }
    NSDictionary *objc = @{@"viewShowState":@(index == 0 ? NO : YES),@"delayTime":@(0)};
    ByEnergySendNotification(ByEnergyUpdateRemoveMapPopView, objc);
}

/*
 以下4个代理方法为是当Items>=6个时，当进入More页面时，开始或结束Item编辑状态的相关回调
 */
- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray<UITabBarItem *> *)items {
    
}

- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray<UITabBarItem *> *)items {
    
}

- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed {
    
}

- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed {
    
}

#pragma mark - Lazyload

- (BEnergyChargeViewModel *)chargeViewModel {
    if (!_chargeViewModel ){
        _chargeViewModel = [[BEnergyChargeViewModel alloc] init];
        _chargeViewModel.type = 1;
        _chargeViewModel.page.PageIndex = 1;
    }
    return _chargeViewModel;
}

- (ByEnergyBaseNavi *)homeNavi {
    if (!_homeNavi) {
        ByEnergyBaseNavi *controller = [[ByEnergyBaseNavi alloc] initWithRootViewController:self.BEnergyHomeVc];
        _homeNavi = controller;
    }
    return _homeNavi;
}

- (ByEnergyBaseNavi *)stubListNavi {
    if (!_stubListNavi) {
        ByEnergyBaseNavi *controller = [[ByEnergyBaseNavi alloc] initWithRootViewController:self.stubListViewController];
        _stubListNavi = controller;
    }
    return _stubListNavi;
}

- (ByEnergyBaseNavi *)chargeOrderNavi {
    if (!_chargeOrderNavi) {
        ByEnergyBaseNavi *controller = [[ByEnergyBaseNavi alloc] initWithRootViewController:self.chargeOrderListViewController];
        _chargeOrderNavi = controller;
    }
    return _chargeOrderNavi;
}


- (ByEnergyBaseNavi *)mineNavi {
    if (!_mineNavi) {
        ByEnergyBaseNavi *controller = [[ByEnergyBaseNavi alloc] initWithRootViewController:self.mineViewController];
        _mineNavi = controller;
    }
    return _mineNavi;
}



- (BEnergyHomeVc *)BEnergyHomeVc {
    if (!_BEnergyHomeVc) {
        _BEnergyHomeVc = [BEnergyHomeVc new];
        _BEnergyHomeVc.tabBarItem.title = @"地图";
        _BEnergyHomeVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -2.0f);
        _BEnergyHomeVc.tabBarItem.image = [[UIImage imageNamed:@"homeNomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _BEnergyHomeVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"homeSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _BEnergyHomeVc;
}

- (BEnergyStubViewController *)stubListViewController {
    if (!_stubListViewController) {
        _stubListViewController = [BEnergyStubViewController new];
        _stubListViewController.tabBarItem.title = @"列表";
        _stubListViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -2.0f);
        _stubListViewController.tabBarItem.image = [[UIImage imageNamed:@"stubNomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _stubListViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"stubSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _stubListViewController;
}

- (BEnergyChargeOrderViewController *)chargeOrderListViewController {
    if (!_chargeOrderListViewController) {
        _chargeOrderListViewController = [BEnergyChargeOrderViewController new];
        _chargeOrderListViewController.tabBarItem.title = @"订单";
        _chargeOrderListViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -2.0f);
        _chargeOrderListViewController.tabBarItem.image = [[UIImage imageNamed:@"orderNomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _chargeOrderListViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"orderSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _chargeOrderListViewController;
}

- (MineTableViewController *)mineViewController {
    if (!_mineViewController) {
        _mineViewController = [MineTableViewController new];
        _mineViewController.tabBarItem.title = @"我的";
        _mineViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0.0, -2.0f);
        _mineViewController.tabBarItem.image = [[UIImage imageNamed:@"mineNomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _mineViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"mineSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return _mineViewController;
}



#pragma mark - delloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
