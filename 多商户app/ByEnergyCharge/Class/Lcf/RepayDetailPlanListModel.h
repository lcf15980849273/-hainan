//
//  RepayDetailPlanListModel.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepayDetailPlanListModel : NSObject

@property (nonatomic, copy) NSString *plan_id;
@property (nonatomic, copy) NSString *term;
@property (nonatomic, copy) NSString *total_term;
@property (nonatomic, copy) NSString *state;//
@property (nonatomic, assign) double interest;
@property (nonatomic, copy) NSString *overdue_days;
@property (nonatomic, assign) double overdue_fine;
@property (nonatomic, assign) double amount;
@property (nonatomic, assign) NSTimeInterval planned_repayment_at;

@property (nonatomic, strong) UIColor *color;
@end

NS_ASSUME_NONNULL_END
