

//
//  ArraysUtils.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ArraysUtils.h"

@implementation ArraysUtils

+ (NSMutableArray *)groupAction:(NSArray *)arr {
    
    NSArray *serviceTypes = [arr valueForKeyPath:@"@distinctUnionOfObjects.timeMonth"];
    
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES]];
    
    NSArray *sortSetArray = [serviceTypes sortedArrayUsingDescriptors:sortDesc];
    
    __block NSMutableArray *groupArr = [NSMutableArray array];
    
    [sortSetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeMonth = %@", obj];
        
        NSArray *tempArr = [NSArray arrayWithArray:[arr filteredArrayUsingPredicate:predicate]];
        
        [groupArr addObject:tempArr];
        
    }];
    return groupArr;
}

@end
