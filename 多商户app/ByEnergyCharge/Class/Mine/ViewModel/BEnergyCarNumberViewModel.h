//
//  BEnergyCarNumberViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyCarNumberViewModel : ByEnergyBaseViewModel
@property (nonatomic, copy) NSString *carNumber;// 车牌号
@property (nonatomic, strong) RACCommand *hnFetchCarNumberCommand;// 获得车牌信息
@property (nonatomic, strong) RACCommand *hnAddCarNumberCommand;// 添加车牌信息
@property (nonatomic, strong) RACCommand *hnDelCarNumberCommand;// 删除车牌信息
@property (nonatomic, strong) RACCommand *hnUpdateCarNumberCommand;// 编辑车牌信息
@end

NS_ASSUME_NONNULL_END
