//
//  BDProblemFeedbackCell.h
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "BDProblemFeedbackModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kBDProblemFeedbackReplyCell = @"BDProblemFeedbackReplyCell";

@interface BDProblemFeedbackReplyCell : BEnergyBaseTableViewCell

@property (nonatomic, strong) BDProblemFeedbackModel *model;

@property (nonatomic, copy) void(^clickFullBtnBlock)(BDProblemFeedbackReplyCell *cell);


@property (nonatomic, copy) void(^clickFullReplyBtnBlock)(BDProblemFeedbackReplyCell *cell);

@end

NS_ASSUME_NONNULL_END
