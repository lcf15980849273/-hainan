//
//  ByEnergyPayHandler.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/26.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyTradeInfoModel.h"

typedef enum {
    GDPayPlatformAlipay,    ///支付宝
    GDPayPlatformWeiXin,    ///微信
    GDPayPlatformUPPay      ///银联
} GDPayPlatform;

typedef void (^GDPayCompletionBlock)(NSString *result, NSString *errorStr);

@interface ByEnergyPayHandler : NSObject
+ (id)sharedInstance;
///处理第三方支付App通过URL启动App时传递的数据
+ (BOOL)handleOpenURL:(NSURL *)url;

///支付调用接口
+ (void)payForOrder:(BEnergyTradeInfoModel *)order
           platform:(GDPayPlatform)platform
     viewController:(UIViewController*)viewController
          urlScheme:(NSString *)urlScheme
         completion:(GDPayCompletionBlock)completionBlock;

@end
