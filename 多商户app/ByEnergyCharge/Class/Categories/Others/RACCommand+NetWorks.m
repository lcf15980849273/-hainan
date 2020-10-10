//
//  RACCommand+NetWorks.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "RACCommand+NetWorks.h"
#import <objc/runtime.h>

@implementation RACCommand (NetWorks)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(initWithSignalBlock:);//原始方法
        SEL swizzledSelector = @selector(sc_initWithSignalBlock:);// 要替换的方法
        Method originalMethod = class_getInstanceMethod([RACCommand class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([RACCommand class], swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (instancetype)sc_initWithSignalBlock:(RACSignal * (^)(id input))signalBlock {
    self.netWorksModel = [[ByEnergyNetWorkModel alloc] init];
   return [self sc_initWithSignalBlock:signalBlock];
}

- (void)setNetWorksModel:(ByEnergyNetWorkModel *)netWorksModel {
    SEL key = @selector(netWorksModel);
    objc_setAssociatedObject(self, key, netWorksModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ByEnergyNetWorkModel *)netWorksModel {
    ByEnergyNetWorkModel *model = objc_getAssociatedObject(self, _cmd);
    if (model) {
        return model;
    }
    return [[ByEnergyNetWorkModel alloc] init];
}

- (void)setResult:(BOOL)result {
    SEL key = @selector(result);
    objc_setAssociatedObject(self, key, [NSNumber numberWithBool:result], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)result {
    BOOL result = [objc_getAssociatedObject(self, _cmd) boolValue];
    return result;
}

- (void)setValue:(id)value {
    SEL key = @selector(value);
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)value {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDatasArray:(NSMutableArray *)datasArray {
    SEL key = @selector(datasArray);
    objc_setAssociatedObject(self, key, datasArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)datasArray {
    NSMutableArray *datasArray = objc_getAssociatedObject(self, _cmd);
    if (datasArray == nil) {
        datasArray = [[NSMutableArray alloc] init];
    }
    return datasArray;
}

@end
