//
//  RepayOnTimeModel.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RepayOnTimeListModel;
@interface RepayOnTimeModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) double amount;
@property (nonatomic, assign) double total_amount;
@property (nonatomic, copy) NSString *loan_term;

@property (nonatomic, copy) NSString *loan_id;

@end

@interface RepayOnTimeListModel : NSObject

@property (nonatomic, copy) NSString *plan_id;
@property (nonatomic, copy) NSString *loan_id;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, assign) double amount;
@property (nonatomic, copy) NSString *term;
@property (nonatomic, assign) NSTimeInterval planned_repayment_at;
@property (nonatomic, strong) UIColor *stateTextColor;

@property (nonatomic, copy) NSString *type;
@end
NS_ASSUME_NONNULL_END
