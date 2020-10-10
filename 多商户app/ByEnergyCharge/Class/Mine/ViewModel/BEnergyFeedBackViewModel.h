//
//  BEnergyFeedBackViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyFeedBackViewModel : ByEnergyBaseViewModel

@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *feedbackId;

@property(nonatomic, strong)RACCommand *hnFeedBackTypeCommand;//问题类型
@property(nonatomic, strong)RACCommand *hnMyFeedBackListCommand;//我的反馈
@property(nonatomic, strong)RACCommand *hnFeedBackResoveCommand;//反馈已解决

@property(nonatomic, strong)RACCommand *hnFeedBackAddCommand;//新增反馈
@property(nonatomic, strong)RACCommand *hnUploadFeedBackImageCommand;//新增反馈
@property(nonatomic, strong)RACCommand *hnFeedBackAdditionalCommand;//追加反馈
@property(nonatomic, strong)RACCommand *hnFeedBackCallListCommand;//反馈回复列表
@end

NS_ASSUME_NONNULL_END
