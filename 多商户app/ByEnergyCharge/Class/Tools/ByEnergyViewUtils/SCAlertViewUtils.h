//
//  SCAlertViewUtils.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SCAlertType) {
    SCAlertTypeAlert,       //alert
    SCAlertTypeActionSheet  //actionsheet
};

typedef NS_ENUM(NSInteger, SCAlertButtonType) {
    SCAlertButtonTypeCancel,        //取消
    SCAlertButtonTypeDestructive,   //destructive
    SCAlertButtonTypeOther          //other
};

typedef void (^SCAlertCompletionHandler)(SCAlertButtonType buttonType, NSUInteger buttonIndex);


@interface SCAlertViewUtils : NSObject

SINGLETON_FOR_HEADER(SCAlertViewUtils);
/**
 类方法，ios8及以上适用UIAlertController，以下适用UIAlertView
 @param     alertType               alert类型，分为alert和actionsheet
 @param     title                   标题
 @param     message                 消息
 @param     cancelButtonTitle       取消按钮的标题
 @param     destructiveButtonTitle  默认红色按钮
 @param     otherButtonTitles       其他按钮数组
 @param     completionHandler       选中按钮后的回调block
 @return    SCAlertViewUtils实例
 */
+ (instancetype)showAlertWithType:(SCAlertType)alertType
                            title:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                otherButtonTitles:(NSArray *)otherButtonTitles
                completionHandler:(SCAlertCompletionHandler)completionHandler;

+ (instancetype)showActionSheetWithType:(SCAlertType)alertType
                                  title:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles
                      completionHandler:(SCAlertCompletionHandler)completionHandler;

+ (instancetype)showSystemActionSheetWithTitle:(NSString *)title
                             cancelButtonTitle:(NSString *)cancelButtonTitle
                        destructiveButtonTitle:(NSString *)destructiveButtonTitle
                             otherButtonTitles:(NSArray *)otherButtonTitles
                             completionHandler:(SCAlertCompletionHandler)completionHandler;
/**
 手动触发，消去Alert
 @param     buttonIndex     触发的buttonIndex
 @return    void
 */
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex;

@end
