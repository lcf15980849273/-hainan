//
//  UIViewController+ByEnergyHierarchy.h
//

#import <UIKit/UIKit.h>

@interface UIViewController (ByEnergyHierarchy)

#pragma mark Public Method
+ (UIViewController*)ByEnergy_topVC;

// 当前controller的最上层的parentViewController, 通常为被present的controller或nav中的controller或tab中的controller
- (UIViewController *)vd_superiorViewController;

- (void)vd_addChildViewController:(UIViewController *)controller toView:(UIView *)view;

@end
