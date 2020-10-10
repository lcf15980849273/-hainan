//
//  BEnergyFeedBackCallBackListModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/7.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class CategoryInfoModel,ListModel;

@interface BEnergyFeedBackCallBackListModel : BEnergyBaseModel
@property(nonatomic, strong)CategoryInfoModel *categoryInfo;
@property (nonatomic, copy) NSString *feedbackId;
@property(nonatomic, strong)NSArray <ListModel *> *list;
@property(nonatomic, assign)int status;
@end

@interface CategoryInfoModel : NSObject
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@end

@interface ListModel : NSObject

@property (nonatomic, copy) NSString *createTimeStr;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign)int logType;
@property (nonatomic, copy) NSString *nickName;
@end
NS_ASSUME_NONNULL_END
