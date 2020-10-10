//
//  RecordListViewCell.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/5/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, tableViewType) {
    tableViewTypeLoan,
    tableViewTypeRepay, 
};
static NSString *const kRecordListViewCell = @"RecordListViewCell";
@interface RecordListViewCell : UITableViewCell
@property (nonatomic, assign) tableViewType type;
@property (nonatomic, strong) RecordListModel *model;
@end

NS_ASSUME_NONNULL_END
