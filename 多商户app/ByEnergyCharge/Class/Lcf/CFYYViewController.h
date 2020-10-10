//
//  CFYYViewController.h
//  byCF
//
//  Created by 刘辰峰 on 2020/4/18.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFYYViewController : UIViewController

@property (nonatomic, copy) void(^addSubscriptSuccessBlock)(void);
- (void)addtitle:(NSString *)str imageStr:(NSString *)imageStr;
@end

NS_ASSUME_NONNULL_END
