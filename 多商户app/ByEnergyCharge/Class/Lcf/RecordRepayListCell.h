//
//  RecordRepayListCell.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordListModel.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const kRecordRepayListCell = @"RecordRepayListCell";

@interface RecordRepayListCell : UITableViewCell
@property (nonatomic, strong) RecordListModel *model;
@end

NS_ASSUME_NONNULL_END
