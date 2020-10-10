//
//  RecordDetailModel.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/5/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecordDetailModel : NSObject


@property (nonatomic, copy) NSString *quota;
@property (nonatomic, copy) NSString *term;
@property (nonatomic, copy) NSString *bank;
@property (nonatomic, copy) NSString *lending_at;
@property (nonatomic, copy) NSString *delay_days;
@property (nonatomic, copy) NSString *end_at;
@property (nonatomic, copy) NSString *delay_state;
@property (nonatomic, copy) NSString *planned_repayment_at;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *repayment_at;
@property (nonatomic, assign) BOOL has_repay_detail;
@property (nonatomic, copy) NSString *repayDetailStr;

@property (nonatomic, copy) NSString *repayed_amount;
@property (nonatomic, assign) double repayment_amount;
@property (nonatomic, copy) NSString *repay_channel;
@property (nonatomic, copy) NSString *pay_way;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL isHiden;

@end

NS_ASSUME_NONNULL_END
