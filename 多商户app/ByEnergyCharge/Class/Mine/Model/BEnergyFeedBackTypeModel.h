//
//  BEnergyFeedBackTypeModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyFeedBackTypeModel : BEnergyBaseModel

@property(nonatomic, assign)BOOL select;
@property (nonatomic, copy) NSString *title;
@property(nonatomic, assign)int value;
@property (nonatomic, copy) NSString *remark;

@end

NS_ASSUME_NONNULL_END
