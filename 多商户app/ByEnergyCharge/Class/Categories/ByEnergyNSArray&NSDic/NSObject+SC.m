
//
//  NSObject+SC.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/11.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "NSObject+SC.h"
#import <objc/runtime.h>

@implementation NSObject (SC)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(valueForUndefinedKey:);//原始方法
        SEL swizzledSelector = @selector(sc_valueForUndefinedKey:);// 要替换的方法
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

-(id)sc_valueForUndefinedKey:(NSString *)key{
    NSLog(@"__________未找到对应key______________");
    return nil;
}

@end
