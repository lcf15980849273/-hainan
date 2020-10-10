//
//  ByEnergyBaseViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyViewModelProtocol.h"
#import "NSMutableDictionary+API.h"
#import "RACCommand+NetWorks.h"
@class Page;

#define sendError(obj,value)\
NSError * error = [NSErrorHelper createErrorWithUserInfo:obj domain:value];\
return [RACSignal error:error];\

@interface ByEnergyBaseViewModel : NSObject<BEnergyViewModelProtocol>
@property (nonatomic, assign) BOOL  result;
@property (nonatomic, assign) BOOL  error;
@property (nonatomic, strong) id  _Nullable value;
@property (nonatomic, strong) NSMutableArray *datasArray;
/**
 *  分页实体
 */
@property (nonatomic, strong) Page * _Nonnull page;

/**
 *  没有更多数据了
 */
@property (nonatomic, assign) BOOL hasNoMoreData;

@end

/**
 *  分页实体
 */
@interface Page : NSObject

/**
 *  总页数
 */
@property (nonatomic, assign) NSInteger PageCount;

/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger PageIndex;

/**
 *  每页总条数
 */
@property (nonatomic, assign) NSInteger SizeCount;

/**
 *  总记录数
 */
@property (nonatomic, assign) NSInteger RecordCount;


@end
