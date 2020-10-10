//
//  BDAskQuestionController.h
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//  问题反馈（右上角提问控制器）

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDAskQuestionController : UITableViewController

@property (nonatomic, copy) void(^askSuccessBlock)(); // 提问成功回调

@end

NS_ASSUME_NONNULL_END
