//
//  BEnergyMyInformationViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyMyInformationViewModel : ByEnergyBaseViewModel

@property (nonatomic, strong) RACCommand *hnUploadUserIconCommand;

@property (nonatomic, strong) RACCommand *hnEditUserInfoCommand;

@end

NS_ASSUME_NONNULL_END
