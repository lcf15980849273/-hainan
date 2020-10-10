//
//  NSObject+VDExtraData.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "NSObject+VDExtraData.h"
#import <objc/runtime.h>
@implementation NSObject (VDExtraData)
- (VDExtraData *)vd_extraDataForKey:(NSString *)key {
    VDExtraData * data = [[self vd_extraDataDictionary] objectForKey:key];
    if (!data) {
        data = [VDExtraData new];
        [[self vd_extraDataDictionary] setObject:data forKey:key];
    }
    
    return data;
}

- (VDExtraData *)vd_extraDataForSelector:(SEL)selector {
    return [self vd_extraDataForKey:NSStringFromSelector(selector)];
}

- (NSMutableDictionary *)vd_extraDataDictionary {
    NSMutableDictionary * dictionary = objc_getAssociatedObject(self, @selector(vd_extraDataDictionary));
    if (!dictionary) {
        dictionary = [NSMutableDictionary new];
        objc_setAssociatedObject(self, @selector(vd_extraDataDictionary), dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dictionary;
}

@end

@implementation VDExtraData

@end
