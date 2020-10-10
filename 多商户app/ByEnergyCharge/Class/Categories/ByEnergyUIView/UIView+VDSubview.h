//
//  UIView+VDSubview.h
//

#import <UIKit/UIKit.h>

@interface UIView (VDSubview)

#pragma mark Public Method
/**
 *  添加子view
 *
 *  @param scaleToFill YES表示子view大小充满父view，利用AutoLayout实现
 *
 *  @return constraints
 */
- (NSArray *)vd_addSubview:(UIView *)view scaleToFill:(BOOL)scaleToFill NS_DEPRECATED_IOS(5_0, 5_0, "user vd_addSubviewSpread or vd_addSubviewSpreadWithConstraints");

/**
 *  移除所有子view
 */
- (void)vd_removeAllSubviews;

/**
 *  添加填充子view，利用KVO实现
 */
- (void)vd_addSubviewSpread:(UIView *)view;

/**
 *  添加填充子view，利用AutoLayout实现
 *
 *  @return constraints
 */
- (NSArray *)vd_addSubviewSpreadAutoLayout:(UIView *)view;

@end
