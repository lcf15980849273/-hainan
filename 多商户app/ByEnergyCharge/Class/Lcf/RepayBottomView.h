//
//  RepayBottomView.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class RepayBottomViewModel;
@protocol RepayBottomViewDelegate <NSObject>

- (void)commitRepayWithModel:(RepayBottomViewModel *)model;

@end

@interface RepayBottomView : UIView
@property (nonatomic , weak) id <RepayBottomViewDelegate> delegate;
@property (nonatomic, strong) RepayBottomViewModel *model;

- (void)ViewShow;
- (void)ViewHiden;
@end

@interface RepayBottomViewModel : NSObject
@property (nonatomic, copy) NSString *term;
@property (nonatomic, copy) NSString *type;//操作类型 1-到期还款 2-逾期还款 3-合计还款 4-提前还款
@property (nonatomic, assign) double amount;
@property (nonatomic, copy) NSString *bank;
@property (nonatomic, copy) NSString *loan_id;

//本地新增
@property (nonatomic, copy) NSString *repayType;//回传后端
@end

NS_ASSUME_NONNULL_END
