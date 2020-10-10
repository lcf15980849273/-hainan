//
//  RecordListModel.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/5/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecordListModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, copy) NSString *loanid;
@property (nonatomic, copy) NSString *period;
@property (nonatomic, copy) NSString *quota;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *term;
@property (nonatomic, copy) NSString *plan_id;
@property (nonatomic, assign) double amount;
@end

NS_ASSUME_NONNULL_END
