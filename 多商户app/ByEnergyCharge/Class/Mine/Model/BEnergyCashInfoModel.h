//
//  BEnergyCashInfoModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/8/22.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class Cashtips,Info,Cashreason;

@interface BEnergyCashInfoModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, strong) NSArray *cashReason;
@property (nonatomic, strong) Cashtips *cashTips;
@property (nonatomic, copy) NSString *cashAmountTips;//提示语
@end

@interface Cashtips : BEnergyBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *info;
@end

@interface Info : BEnergyBaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *value;
@end

@interface Cashreason : BEnergyBaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *value;

@end

NS_ASSUME_NONNULL_END
