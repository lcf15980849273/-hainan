//
//  BEnergyCouponsModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyCouponsModel : BEnergyBaseModel
/*折扣方式 [0.百分比折扣,1.固定金额折扣]*/
@property (nonatomic, assign) NSInteger discountWay;
/*使用条件 [0.订单金额大于优惠面额自动抵扣,1.满减,2.历史订单总额]*/
@property (nonatomic, assign) NSInteger useCondition;

@property (nonatomic, copy) NSString *thresholdAmount;

@property (nonatomic, copy) NSString *discountAmount;

@property (nonatomic, copy) NSString *useConditionDec;
/*使用范围 [0.全站通用,1.指定地区,2.指定站点]*/
@property (nonatomic, assign) NSInteger useRange;

@property (nonatomic, copy) NSString *useRangeDec;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *invalidTime;

@property (nonatomic, assign) CGFloat useRangeHeight;

@end

NS_ASSUME_NONNULL_END
