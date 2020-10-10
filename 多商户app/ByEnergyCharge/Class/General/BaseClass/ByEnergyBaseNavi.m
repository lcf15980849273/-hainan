//
//  ByEnergyBaseNavi.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseNavi.h"
#import "ByEnergyBaseWebVc.h"
#import "BEnergyMyCouponsViewController.h"
#import "BEnergyBalanceRechargeViewController.h"

@interface ByEnergyBaseNavi ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *vcArray;//需要禁止侧滑返回的页面
@end

@implementation ByEnergyBaseNavi

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak ByEnergyBaseNavi *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])  {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
    
  
    //导航栏颜色渐变
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH,64)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)BYENERGYCOLOR(0x527ead).CGColor, (__bridge id)BYENERGYCOLOR(0xedeee).CGColor, (__bridge id)BYENERGYCOLOR(0xbfdffe).CGColor];
    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0,0);
    gradientLayer.endPoint = CGPointMake(1.0,0);
    gradientLayer.frame = backView.frame;
    [backView.layer addSublayer:gradientLayer];
    
//    [self.navigationBar setBackgroundImage:[self convertViewToImage:backView] forBarMetrics:UIBarMetricsDefault];
    
}

- (UIImage*)convertViewToImage:(UIView*)v {
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s,YES, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return image;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //判断是否是根控制器，如果是就不显示返回按钮,不是根控制器跳转隐藏tabar
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //这个方法是在当前控制器执行push的时候，禁止手势右划返回，避免出现crash的现象，（也可以不实现好像也没什么影响）
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    //判断上一个控制器和现在的控制器是不是同一个，如果是，返回。如果不是push到当前控制器，这就有效避免了同一个控制器连续push的问题
    if (![viewController isMemberOfClass:[ByEnergyBaseWebVc class]] && ![viewController isMemberOfClass:[BEnergyMyCouponsViewController class]] && ![viewController isMemberOfClass:[BEnergyBalanceRechargeViewController class]]) {
        if ([self.topViewController isMemberOfClass:[viewController class]]) {
            return;
        }
    }
    [super pushViewController:viewController animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        NSString *vcStr = NSStringFromClass([viewController class]);
        self.interactivePopGestureRecognizer.enabled = ![self.vcArray containsObject:vcStr];
    }
}


#pragma mark ----- LazyLoad
- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[@"BEnergyChargingTableViewController",@"BEnergyChargeOrderDetailTableController"];
    }
    return _vcArray;
}

@end
