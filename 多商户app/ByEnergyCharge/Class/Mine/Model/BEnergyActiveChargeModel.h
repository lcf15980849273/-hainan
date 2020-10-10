//
//  BEnergyActiveChargeModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/3.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyActiveChargeModel : BEnergyBaseModel
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, copy) NSString *searchValue;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *params;
@property (nonatomic, copy) NSString *id; //活动id
@property (nonatomic, assign)  int type;
@property (nonatomic, copy) NSString *name; //活动名称
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *imgId;
@property (nonatomic, copy) NSString *conditionAmount; //活动充值条件金额
@property (nonatomic, copy) NSString *giveAmount; //活动赠送金额
@property (nonatomic, assign)  int status;
@property (nonatomic, assign)  int usageType;
@property (nonatomic, assign)  int usageTimes;
@property (nonatomic, assign)  int activeType;
@property (nonatomic, copy) NSString *activeTime;
@property (nonatomic, copy) NSString *invalidTime;
@property (nonatomic, copy) NSString *createAccount;
@property (nonatomic, copy) NSString *modifyTime;
@property (nonatomic, copy) NSString *modifyAccount;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *userRemainTimes; //活动剩余使用次数
@property (nonatomic, copy) NSString *appkey;
@property (nonatomic, copy) NSString *deleted;
@property (nonatomic, copy) NSString *limitType;
@property (nonatomic, copy) NSString *limitTimes;
@property (nonatomic, assign) BOOL joinFlag; //活动用户是否可以参与
@property (nonatomic, copy) NSString *h5RuleLink; //活动详情url
@end

NS_ASSUME_NONNULL_END
