//
//  RecordRepayPlanListCell.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepayDetailPlanListModel.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const kRecordRepayPlanListCell = @"RecordRepayPlanListCell";
@interface RecordRepayPlanListCell : UITableViewCell

@property (nonatomic, strong) RepayDetailPlanListModel *model;
@end

NS_ASSUME_NONNULL_END
