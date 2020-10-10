//
//  YPNavigationController+configure.m
//  CocoaAsyncSocket
//
//  Created by newyea on 2020/5/29.
//

#import "YPNavigationController+configure.h"

@implementation YPNavigationController (configure)

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return YPNavigationBarStyleBlack | YPNavigationBarBackgroundStyleTranslucent | YPNavigationBarBackgroundStyleNone;
}

- (UIColor *) yp_navigationBarTintColor {
    return [UIColor whiteColor];
}

@end
