//
//  RepayAdvanceModel.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepayAdvanceModel : NSObject

@property (nonatomic, assign) double principal;
@property (nonatomic, copy) NSString *undue_cnt;
@property (nonatomic, assign) double fee;
@property (nonatomic, assign) double amount;
@property (nonatomic, copy) NSString *loan_id;
@property (nonatomic, assign) double prepayment_poundage_max;
@property (nonatomic, assign) double prepayment_poundage_rate;
@end

NS_ASSUME_NONNULL_END
