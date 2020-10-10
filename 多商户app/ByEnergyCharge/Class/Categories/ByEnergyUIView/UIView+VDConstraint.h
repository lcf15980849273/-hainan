//
//  UIView+VDConstraint.h
//

#import <UIKit/UIKit.h>

@interface UIView (VDConstraint)

#pragma mark Properties
@property (nonatomic, assign, readonly) CGFloat vd_constraintTop;
@property (nonatomic, assign, readonly) CGFloat vd_constraintBottom;
@property (nonatomic, assign, readonly) CGFloat vd_constraintLeading;
@property (nonatomic, assign, readonly) CGFloat vd_constraintTrailing;
@property (nonatomic, assign, readonly) CGFloat vd_constraintWidth;
@property (nonatomic, assign, readonly) CGFloat vd_constraintHeight;
@property (nonatomic, assign, readonly) CGFloat vd_constraintAspectRatio;

@end
