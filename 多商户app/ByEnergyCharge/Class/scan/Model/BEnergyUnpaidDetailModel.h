//
//  BEnergyUnpaidDetailModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/24.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class Unpaidtype, BEnergyChargeDetailModel;

@interface BEnergyUnpaidDetailModel : BEnergyBaseModel
/*订单详情*/
@property (nonatomic, strong) BEnergyChargeDetailModel *unpaidDetail;
/*支付*/
@property (nonatomic, strong) NSArray *unpaidType;

@end

@interface Unpaidtype : BEnergyBaseModel
/*支付ID*/
@property (nonatomic, copy) NSString *id;
/*支付名称*/
@property (nonatomic, copy) NSString *name;
/*支付说明*/
@property (nonatomic, copy) NSString *remark;

@end

NS_ASSUME_NONNULL_END
