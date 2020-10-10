//
//  NSObject+ByEnergyClass.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "NSObject+ByEnergyClass.h"

@implementation NSObject (ByEnergyClass)
+ (NSString *)hnByEnergyFetchClassName {
    return NSStringFromClass(self);
}

- (NSString *)hnByEnergyFetchClassName {
    return [[self class] hnByEnergyFetchClassName];
}
@end
