//
//  BEnergyFocusViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/27.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

@interface BEnergyFocusViewModel : ByEnergyBaseViewModel
@property (nonatomic, strong) RACCommand *hnFocusCommand;
@property (nonatomic, strong) NSArray *focusList;
@property (nonatomic, strong) NSArray *focusData;
@property (nonatomic, assign) CGSize focusViewSize;
@end
