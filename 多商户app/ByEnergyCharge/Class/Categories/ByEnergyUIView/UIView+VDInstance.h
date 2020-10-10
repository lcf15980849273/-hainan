//
//  UIView+VDInstance.h
//

#import <UIKit/UIKit.h>

@interface UIView (VDInstance)

#pragma mark Constructor
+ (instancetype)vd_viewFromNib;
+ (instancetype)vd_viewFromNibWithNibName:(NSString *)nibName;

@end
