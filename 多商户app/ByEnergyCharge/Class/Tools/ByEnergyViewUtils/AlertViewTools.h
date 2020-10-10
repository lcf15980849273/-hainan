//
//  AlertViewTools.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCAlertViewUtils.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^AlertToolsCompletionHandler)(NSUInteger buttonIndex);

@interface AlertViewTools : NSObject
SINGLETON_FOR_HEADER(AlertViewTools);
//拨打客服电话
+ (void)showServiceNumber;

+ (void)showAlertMessage:(NSString *)message
                  Cancel:(NSString *)cancel
                  Submit:(NSString *)submit
       completionHandler:(SCAlertCompletionHandler)completionHandler;

+ (UIAlertView *)showSystemAlertViewTitle:(NSString *)title
                                  Message:(NSString *)message
                                     Cancel:(NSString *)cancel
                                     Submit:(NSString *)submit
                          completionHandler:(AlertToolsCompletionHandler)completionHandler;
@end

NS_ASSUME_NONNULL_END
