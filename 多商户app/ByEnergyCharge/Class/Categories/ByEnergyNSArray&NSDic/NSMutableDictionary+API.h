//
//  NSMutableDictionary+API.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (API)
/**
 设置页码
 */
@property (nonatomic,assign) NSInteger pageIndex;

//消息中心字段改成了page 和pagecount
@property (nonatomic,assign) NSInteger page;
- (NSMutableDictionary *)api;
@end
