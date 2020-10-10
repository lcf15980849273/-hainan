//
//  ArraysUtils.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArraysUtils : NSObject

/**
 数据进行区分筛选
 */
+ (NSMutableArray *)groupAction:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
