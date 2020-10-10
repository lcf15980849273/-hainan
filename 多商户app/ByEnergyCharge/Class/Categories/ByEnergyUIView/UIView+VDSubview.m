//
//  UIView+VDSubview.m
//

#import "UIView+VDSubview.h"

@implementation UIView (VDSubview)

#pragma mark Public Method
- (NSArray *)vd_addSubview:(UIView *)view scaleToFill:(BOOL)scaleToFill {
    if (!view
        || [self.subviews containsObject:view]) {
        return nil;
    }
    
    if (scaleToFill) {
        return [self vd_addSubviewSpreadAutoLayout:view];
    }
    else {
        [self addSubview:view];
    }
    
    return nil;
}

- (void)vd_removeAllSubviews {
    for (UIView *view in [self.subviews copy]) {
        [view removeFromSuperview];
    }
}

- (void)vd_addSubviewSpread:(UIView *)view {
    if (!view
        || [self.subviews containsObject:view]) {
        return;
    }
    
    [self addSubview:view];
    view.frame = self.bounds;
}

- (NSArray *)vd_addSubviewSpreadAutoLayout:(UIView *)view {
    if (!view
        || [self.subviews containsObject:view]) {
        return nil;
    }
    
    [self addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[vdsubview]-0-|" options:0 metrics:nil views:@{@"vdsubview" : view} ] ];
    [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[vdsubview]-0-|" options:0 metrics:nil views:@{@"vdsubview" : view} ] ];
    
    NSArray *constraints = [NSArray arrayWithArray:array];
    
    [self addConstraints:constraints];
    
    return constraints;
}

@end
