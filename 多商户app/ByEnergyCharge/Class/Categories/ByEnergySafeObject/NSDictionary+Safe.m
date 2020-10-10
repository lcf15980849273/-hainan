//
//  NSDictionary+Safe.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/29.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import <objc/runtime.h>
#import "NSObject+ImpChangeTool.h"

@implementation NSDictionary (Safe)
+ (void)load{
    [self SwizzlingMethod:@"initWithObjects:forKeys:count:" systemClassString:@"__NSPlaceholderDictionary" toSafeMethodString:@"initWithObjects_st:forKeys:count:" targetClassString:@"NSDictionary"];
}
-(instancetype)initWithObjects_st:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!(keys[i] && objects[i])) {
            NSLog(@"[%s %@] NIL object or key at index{%lu}.",
                  class_getName(self.class),
                  NSStringFromSelector(_cmd),
                  (unsigned long)i);
            break;
        }else{
            rightCount++;
        }
    }
    self = [self initWithObjects_st:objects forKeys:keys count:rightCount];
    return self;
}

- (void)sc_setObject:(id)object forKey:(NSString *)key{
    if(!object){
        @try{
            [self sc_setObject:object forKey:key];
        } @catch(NSException *exception){
            NSLog(@"---------- %s 字典添加为空 %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            object = [NSString stringWithFormat:@""];
            [self sc_setObject:object forKey:key];
        } @finally{
            
        }
    }else{
        [self sc_setObject:object forKey:key];
    }
}

@end
