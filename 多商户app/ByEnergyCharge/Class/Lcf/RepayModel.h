//
//  RepayModel.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class RepayListModel;
@interface RepayModel : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) double total_amount;
@property (nonatomic, strong) NSMutableArray <RepayListModel *> *list;

@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, copy) NSString *total_amountSting;
@end

@interface RepayListModel : NSObject
@property (nonatomic, copy) NSString *loan_id;
@property (nonatomic, assign) double quota;
@property (nonatomic, copy) NSString *total_term;
@property (nonatomic, assign)NSInteger lending_at;
@property (nonatomic, copy) NSString *term;
@property (nonatomic, assign) double monthly;
@property (nonatomic, assign) double interest;
@property (nonatomic, assign) double principal;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, assign) BOOL isHidenState;

@end
NS_ASSUME_NONNULL_END
