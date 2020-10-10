//
//  UIView+VDInstance.m
//

#import "UIView+VDInstance.h"

@implementation UIView (VDInstance)

#pragma mark Constructor
+ (instancetype)vd_viewFromNib {
    return [self vd_viewFromNibWithNibName:NSStringFromClass( [self class] ) ];
}

+ (instancetype)vd_viewFromNibWithNibName:(NSString *)nibName {
    UIView *instance = [[[self class] alloc] init];
    NSArray *nibViews = [ [NSBundle mainBundle] loadNibNamed:nibName owner:instance options:nil];
    instance = nibViews[0];
    return instance;
}

@end
