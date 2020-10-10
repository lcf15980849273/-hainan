//
//  BEnergyStubGroupViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

@interface BEnergyStubGroupViewModel : ByEnergyBaseViewModel
@property (nonatomic, assign) int type;// 桩群类型0、全国  3、地区
@property (nonatomic, strong) RACCommand *hnStubGroupCommand;// 充电桩群列表汇总
@property (nonatomic, strong) RACCommand *hnHomeStubListCommand;// 首页充电桩群列表查询
@property (nonatomic, strong) RACCommand *hnStubListCommand;// 电站列表
@property (nonatomic, strong) RACCommand *hnStubDetailsCommand;// 充电桩群详情
@property (nonatomic, strong) RACCommand *hnStubChargingProgressCommand;// 充电桩进度查询
@end
