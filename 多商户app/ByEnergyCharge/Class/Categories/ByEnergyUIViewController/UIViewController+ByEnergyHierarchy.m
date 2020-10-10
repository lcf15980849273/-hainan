//
//  UIViewController+ByEnergyHierarchy.m
//

#import "UIViewController+ByEnergyHierarchy.h"

#import "objcWindow.h"
#import "objcView.h"

@implementation UIViewController (ByEnergyHierarchy)

#pragma mark Public Method
+ (UIViewController *)ByEnergy_topVC {
    return [self vd_topViewControllerWithRootViewController:nil];
}

- (UIViewController *)vd_superiorViewController {
    UIViewController *superiorViewController = self;
    while (superiorViewController.parentViewController) {
        if (!superiorViewController.parentViewController.parentViewController
            && ([superiorViewController.parentViewController isKindOfClass:[UINavigationController class]]
                || [superiorViewController.parentViewController isKindOfClass:[UITabBarController class]])) {
                break;
            }
        
        superiorViewController = superiorViewController.parentViewController;
    }
    
    return superiorViewController;
}

- (void)vd_addChildViewController:(UIViewController *)controller toView:(UIView *)view {
    [self addChildViewController:controller];
    [view vd_addSubviewSpreadAutoLayout:controller.view];
}

#pragma mark Private Method
+ (UIViewController *)vd_topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if (!rootViewController) {
        rootViewController = VDWindow.rootViewController;
    }
    
    if (rootViewController.presentedViewController) {
        UIViewController *controller = rootViewController.presentedViewController;
        if (!controller ||
            controller == rootViewController) {
            return rootViewController;
        }
        return [self vd_topViewControllerWithRootViewController:controller];
    }
    else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *) rootViewController;
        UIViewController *controller = tabBarController.selectedViewController ? : tabBarController.viewControllers.firstObject;
        if (!controller ||
            controller == rootViewController) {
            return rootViewController;
        }
        return [self vd_topViewControllerWithRootViewController:controller];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *) rootViewController;
        UIViewController *controller = navigationController.visibleViewController ? : navigationController.viewControllers.firstObject;
        if (!controller ||
            controller == rootViewController) {
            return rootViewController;
        }
        return [self vd_topViewControllerWithRootViewController:controller];
    }
    else {
        return rootViewController;
    }
}

@end
