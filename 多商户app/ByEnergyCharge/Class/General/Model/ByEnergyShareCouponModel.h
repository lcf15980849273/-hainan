//
//  ByEnergyShareCouponModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/23.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ByEnergyShareCouponModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *shareDetailDescribe; //分享描述
@property (nonatomic, copy) NSString *shareCouponImg; //banner图Url
@property (nonatomic, copy) NSString *shareDetailRuleImage; //缩略图Url
@property (nonatomic, copy) NSString *shareCouponProjectTitle; //活动标题
@property (nonatomic, copy) NSString *shareCouponH5; //分享朋友圈的H5的url
@property (nonatomic, assign) int shareCouponProjectStatus; //状态(1活动开始，0活动关闭)
@end

NS_ASSUME_NONNULL_END
