//
//  RACCommand+NetWorks.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "RACCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACCommand (NetWorks)
@property (nonatomic, strong) ByEnergyNetWorkModel *netWorksModel;
@property (nonatomic, assign) BOOL  result;
@property (nonatomic, strong) id  _Nullable value;
@property (nonatomic, strong) NSMutableArray *datasArray;
@end

NS_ASSUME_NONNULL_END
