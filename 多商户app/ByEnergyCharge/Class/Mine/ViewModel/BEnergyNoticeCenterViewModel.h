//
//  BEnergyNoticeCenterViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyNoticeCenterViewModel : ByEnergyBaseViewModel
@property (nonatomic, strong) RACCommand *hnNoticeCenterCommand;
@property (nonatomic, strong) RACCommand *hnSystemNoticeCommand;
@property (nonatomic, strong) RACCommand *hnActivityCommand;
@end



NS_ASSUME_NONNULL_END
