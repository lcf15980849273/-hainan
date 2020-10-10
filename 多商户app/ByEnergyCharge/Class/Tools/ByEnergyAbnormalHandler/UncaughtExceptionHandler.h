//
//  UncaughtExceptionHandler.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/5.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject

/**
 是否展示错误信息
 */
@property (nonatomic, copy) UncaughtExceptionHandler*(^showExceptionInfor)(BOOL yesOrNo);

/**
 自定义Alert的message
 */
@property (nonatomic, copy) UncaughtExceptionHandler*(^message)(NSString *message);
 
/**
 点击Alert后续处理
 */
@property (nonatomic, copy) UncaughtExceptionHandler*(^didClick)(void (^click)(NSString *message));

/**
 自定义Alert的title
 */
@property (nonatomic, copy) UncaughtExceptionHandler*(^title)(NSString *title);

/**
 是否展示警告框
 */
@property (nonatomic, copy) UncaughtExceptionHandler*(^showAlert)(BOOL yesOrNo);

/**
 对日志文件的后续处理
 */
@property (nonatomic, copy) UncaughtExceptionHandler*(^logFileHandle)(void(^logHandle)(NSString *exceptionLogFilePath));

/**
 日志文件路径
 */
@property (nonatomic, retain, readonly) NSString *exceptionFilePath;

/**
 创建一个异常捕获类的单例
 */
+ (instancetype)shareInstance;

//void HandleException(NSException *exception);
//void SignalHandler(int signal);
UncaughtExceptionHandler* InstallUncaughtExceptionHandler(void);
void ExceptionHandlerFinishNotify(void);

@end
