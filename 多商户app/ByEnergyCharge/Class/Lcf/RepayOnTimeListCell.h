//
//  RepayOnTimeListCell.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepayOnTimeModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kRepayOnTimeListCell = @"RepayOnTimeListCell";
@interface RepayOnTimeListCell : UITableViewCell
@property (nonatomic, strong) RepayOnTimeModel *repayOntimeModel;
@property (nonatomic, strong) RepayOnTimeListModel *model;
@property (nonatomic, copy) void(^showRepayPlanBlock)(RepayOnTimeListModel *model);
@end

NS_ASSUME_NONNULL_END
