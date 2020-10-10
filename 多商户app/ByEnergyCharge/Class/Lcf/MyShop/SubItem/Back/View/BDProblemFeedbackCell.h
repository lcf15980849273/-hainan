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

static NSString *const kBDProblemFeedbackCell = @"BDProblemFeedbackCell";

@interface BDProblemFeedbackCell : BEnergyBaseTableViewCell

@property (nonatomic, strong) BDProblemFeedbackModel *model;

@end

NS_ASSUME_NONNULL_END
