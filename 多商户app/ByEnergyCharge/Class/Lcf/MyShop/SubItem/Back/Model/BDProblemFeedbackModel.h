//
//  BDProblemFeedbackModel.h
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDProblemFeedbackModel : BDModel

@property (nonatomic, copy) NSString *goalName; // 供应商名称
@property (nonatomic, copy) NSString *goalPhone; // 供应商电话
@property (nonatomic, copy) NSString *goalImId; // 供应商imId
@property (nonatomic, copy) NSString *goalType; // 供应商类型
@property (nonatomic, copy) NSString *problemId; // 问题编号
@property (nonatomic, assign) long createTime; // 创建时间
@property (nonatomic, copy) NSString *content; // 反馈内容
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *typeContent; // 反馈类型
@property (nonatomic, copy) NSString *replyContent; // 回复内容
@property (nonatomic, assign) long replyTime; // 回复时间

@property (nonatomic, assign) BOOL isOpen; // 是否展开内容

@property (nonatomic, assign) BOOL isOpenReplyContent; // 是否展开回馈内容

@end

NS_ASSUME_NONNULL_END
