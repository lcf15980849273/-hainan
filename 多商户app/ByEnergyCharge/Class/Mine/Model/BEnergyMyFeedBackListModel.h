//
//  BEnergyMyFeedBackListModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyMyFeedBackListModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *categoryTitle;
@property (nonatomic, copy) NSString *categoryRemark;
@property (nonatomic, copy) NSString *info;
@property(nonatomic, assign)int status;//状态0:已删除; 1:未回复; 2:客服已读 3: 已回复; 4:用户已读 5:已解决.
@property (nonatomic, copy) NSString *createTimeStr;

@end

NS_ASSUME_NONNULL_END
