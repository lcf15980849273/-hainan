//
//  ByEnergyBaseViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"
//每页数据加载数
#define PageSize 20

@implementation ByEnergyBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    ByEnergyBaseViewModel *viewModel = [super allocWithZone:zone];
    [viewModel initialize];
    return viewModel;
}

- (instancetype) init {
    if (self = [super init]) {
        [self initialize];
        ByEnergyWeakSekf
        RAC(self, hasNoMoreData) = [RACChannelTo(self.page,SizeCount) map:^id _Nullable(id  _Nullable value) {
            ByEnergyStrongSelf
            if (self.page!= nil && [value integerValue] < PageSize) {
                return @YES;
            }
            return @NO;
        }];
    }
    return self;
}

- (void)initialize {}

- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}

- (Page *)page {
    if (!_page) {
        _page = [[Page alloc] init];
    }
    return _page;
}

@end

@implementation Page

@end
