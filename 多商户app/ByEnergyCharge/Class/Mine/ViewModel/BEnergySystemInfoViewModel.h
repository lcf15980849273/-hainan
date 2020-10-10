//
//  BEnergySystemInfoViewModel.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

@interface BEnergySystemInfoViewModel : ByEnergyBaseViewModel

@property (nonatomic, strong) RACCommand *hnSystemInfoCommand;
@property (nonatomic, strong) RACCommand *hnCheckAppStoreVersion;
@property (nonatomic, strong) RACCommand *hnGetTokenCommand;

@end
