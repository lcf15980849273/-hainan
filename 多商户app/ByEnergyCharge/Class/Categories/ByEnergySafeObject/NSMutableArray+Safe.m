//
//  NSMutableArray+Safe.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/29.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSMutableArray (Safe)

#pragma mark --- init method

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换 objectAtIndex:
        NSString *tmpGetStr = @"objectAtIndex:";
        NSString *tmpSafeGetStr = @"safeMutable_objectAtIndex:";
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpGetStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeGetStr)];
        
        //替换 removeObjectsInRange:
        NSString *tmpRemoveStr = @"removeObjectsInRange:";
        NSString *tmpSafeRemoveStr = @"safeMutable_removeObjectsInRange:";
        
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpRemoveStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveStr)];
        
        
        //替换 insertObject:atIndex:
        NSString *tmpInsertStr = @"insertObject:atIndex:";
        NSString *tmpSafeInsertStr = @"safeMutable_insertObject:atIndex:";
        
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpInsertStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeInsertStr)];
        
        //替换 removeObject:inRange:
        NSString *tmpRemoveRangeStr = @"removeObject:inRange:";
        NSString *tmpSafeRemoveRangeStr = @"safeMutable_removeObject:inRange:";
        
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpRemoveRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveRangeStr)];
        
        
        // 替换 objectAtIndexedSubscript
        
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpSecondSubscriptStr = @"safeMutable_objectAtIndexedSubscript:";
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpSubscriptStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondSubscriptStr)];
        
        // 替换 objectAtIndexedSubscript
        
        NSString *tmpCountStr = @"count";
        NSString *tmpSecondCountStr = @"safeMutable_count";
        [NSObject exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpCountStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondCountStr)];
        
    });
    
}

#pragma mark --- implement method

/**
 取出NSArray 第index个 值
 
 @param index 索引 index
 @return 返回值
 */
- (id)safeMutable_objectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        NSLog(@"-------- %s 可变数组越界 %s -------\n",class_getName(self.class),__func__);
        return nil;
    }
    return [self safeMutable_objectAtIndex:index];
}

/**
 NSMutableArray 移除 索引 index 对应的 值
 
 @param range 移除 范围
 */
- (void)safeMutable_removeObjectsInRange:(NSRange)range {
    
    if (range.location > self.count) {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
              NSStringFromClass([self class]),
              NSStringFromSelector(_cmd),
              (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    if (range.length > self.count) {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
              NSStringFromClass([self class]),
              NSStringFromSelector(_cmd),
              (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
              NSStringFromClass([self class]),
              NSStringFromSelector(_cmd),
              (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    return [self safeMutable_removeObjectsInRange:range];
}


/**
 在range范围内， 移除掉anObject
 
 @param anObject 移除的anObject
 @param range 范围
 */
- (void)safeMutable_removeObject:(id)anObject inRange:(NSRange)range {
    if (range.location > self.count) {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
              NSStringFromClass([self class]),
              NSStringFromSelector(_cmd),
              (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    if (range.length > self.count) {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
              NSStringFromClass([self class]),
              NSStringFromSelector(_cmd),
              (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
              NSStringFromClass([self class]),
              NSStringFromSelector(_cmd),
              (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    if (!anObject){
        NSLog(@"[%@ %@], NIL object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    
    
    return [self safeMutable_removeObject:anObject inRange:range];
    
}

/**
 NSMutableArray 插入 新值 到 索引index 指定位置
 
 @param anObject 新值
 @param index 索引 index
 */
- (void)safeMutable_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
              NSStringFromClass([self class]),
              NSStringFromSelector(_cmd),
              (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return;
    }
    
    if (!anObject){
        NSLog(@"[%@ %@], NIL object.", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
        return;
    }
    
    [self safeMutable_insertObject:anObject atIndex:index];
}


/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param idx 索引 idx
 @return 返回值
 */
- (id)safeMutable_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count){
        NSLog(@"[%@ %@] index {%lu} beyond bounds [0...%lu].",
              NSStringFromClass([self class]),
              NSStringFromSelector(_cmd),
              (unsigned long)index,
              MAX((unsigned long)self.count - 1, 0));
        return nil;
    }
    return [self safeMutable_objectAtIndexedSubscript:idx];
}

- (NSInteger)safeMutable_count {
    
    if ([self isKindOfClass:[NSMutableArray class]] || [self isKindOfClass:[NSArray class]]) {
        return [self safeMutable_count];
    }
    return 0;
}
@end
