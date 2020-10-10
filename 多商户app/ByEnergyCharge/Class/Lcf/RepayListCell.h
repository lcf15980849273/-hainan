//
//  RepayListCell.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepayModel.h"
NS_ASSUME_NONNULL_BEGIN
static NSString *const kRepayListCell = @"RepayListCell";
@interface RepayListCell : UITableViewCell
@property (nonatomic, strong) RepayListModel *model;
@property (nonatomic, copy) void(^repayButtonBLock)(RepayListModel *model);
@end

NS_ASSUME_NONNULL_END
