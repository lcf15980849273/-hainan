//
//  NSObject+Swizzling.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/29.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)
+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END
