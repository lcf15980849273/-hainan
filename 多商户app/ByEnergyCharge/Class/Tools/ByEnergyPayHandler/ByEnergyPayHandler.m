//
//  ByEnergyPayHandler.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/26.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "ByEnergyPayHandler.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "UPPaymentControl.h"
#import "UMSPPPayUnifyPayPlugin.h"
@interface ByEnergyPayHandler ()<WXApiDelegate>
@property (nonatomic, copy) GDPayCompletionBlock competionBlock;
@end

@implementation ByEnergyPayHandler
static ByEnergyPayHandler* sharedObj = nil;

+ (id)sharedInstance {
    @synchronized (self) {
        if (sharedObj == nil) {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

//支付调用接口   通过点用这个方法判断支付第三发 并以对应的model 传参数
+ (void)payForOrder:(BEnergyTradeInfoModel *)order
           platform:(GDPayPlatform)platform
     viewController:(UIViewController*)viewController
          urlScheme:(NSString *)urlScheme
         completion:(GDPayCompletionBlock)completionBlock {
    [[ByEnergyPayHandler sharedInstance] payForOrder:order
                                      platform:platform
                                viewController:viewController
                                     urlScheme:urlScheme
                                    completion:completionBlock];
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    return [[ByEnergyPayHandler sharedInstance] handleOpenURL:url];
}

- (void)payForOrder:(BEnergyTradeInfoModel *)order
           platform:(GDPayPlatform)platform
     viewController:(UIViewController*)viewController
          urlScheme:(NSString *)urlScheme
         completion:(GDPayCompletionBlock)completionBlock {
    self.competionBlock = completionBlock;
    
    if (platform == GDPayPlatformAlipay) {
        [self payByAlipayWithOrderString:order.ali
                               schemeStr:urlScheme];
    }
    else if (platform == GDPayPlatformWeiXin) {
        [self payByWeiXinWithOrderString:order.weixinParam];//Param  参数
    }
    else if (platform == GDPayPlatformUPPay) {
        [self payByUPPayWithTradeNo:order.appPayRequest schemeStr:urlScheme viewController:viewController];
    }
}
#pragma  这里生成了 支付宝支付相关信息
- (void)payByAlipayWithOrderString:(NSString *)orderStr
                         schemeStr:(NSString *)schemeStr {
    [[AlipaySDK defaultService] payOrder:orderStr
                              fromScheme:schemeStr
                                callback:^(NSDictionary *resultDic) {
                                    if (byEnergyIsValidStr(resultDic[@"resultStatus"]) && [resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                                        [self paySuccess];
                                    }
                                    else {
                                        NSString *memo = resultDic[@"memo"];
                                        [self payFailed:byEnergyIsValidStr(memo)?memo:@"支付失败"];
                                    }
                                }];
}


#pragma  这里生成了 微信支付相关信息
- (void)payByWeiXinWithOrderString:(NSString *)orderStr {
    if (byEnergyIsValidStr(orderStr)==NO) {
        return;
    }
    @try {
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            NSData *data= [orderStr dataUsingEncoding:NSUTF8StringEncoding];
            if ([data length]>0) {
                NSError *error = nil;
                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if ([jsonObject isKindOfClass:[NSArray class]] && [jsonObject count]>0) {
                    NSDictionary *orderInfo = [jsonObject firstObject];
                    PayReq *req             = [[PayReq alloc] init];
                    req.openID              = orderInfo[@"appid"];
                    req.partnerId           = orderInfo[@"partnerid"];
                    req.prepayId            = orderInfo[@"prepayid"];
                    req.nonceStr            = orderInfo[@"noncestr"];
                    req.timeStamp           = [orderInfo[@"timestamp"] intValue];
                    req.package             = orderInfo[@"package"];
                    req.sign                = orderInfo[@"paySign"];
                    NSLog(@"weixin req:%@", req);
//                    [WXApi sendReq:req];
                    
                    [WXApi sendReq:req completion:^(BOOL success) {
                    }];
                }
            }
        }
        else { 
            [HUDManager showTextHud:@"请安装微信客户端"];
        }
    } @catch (NSException *exception) {
        [HUDManager showTextHud:@"微信支付订单生成失败！"];
    }
}

- (void)payByUPPayWithTradeNo:(NSString *)tradeNo
                    schemeStr:(NSString *)schemeStr
               viewController:(UIViewController *)viewController {
    if(byEnergyIsValidStr(tradeNo) == NO) {
        [HUDManager showTextHud:@"银联交易流水号生成失败"];
    }
    else {
        /*[[UPPaymentControl defaultControl] startPay:tradeNo
         fromScheme:schemeStr
         mode:@"00"
         viewController:viewController];*/
        
        [UMSPPPayUnifyPayPlugin cloudPayWithURLSchemes:schemeStr
                                               payData:tradeNo
                                        viewController:viewController
                                         callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            if([resultCode isEqualToString:@"0000"]) {
                [self paySuccess];
            }
            else if([resultCode isEqualToString:@"1000"]) {
                //交易取消
                [self payFailed:@"取消支付"];
            }
            else {
                //交易失败
                [self payFailed:@"支付失败"];
            }
        }];
    }
}

- (void)UPPayPluginResult:(NSString*)result {
    if ([result isEqualToString:@"success"]) {
        [self paySuccess];
    }
    else if ([result isEqualToString:@"cancel"]) {
        [self payFailed:@"取消支付"];
    }
    else {
        [self payFailed:@"支付失败"];
    }
}
#pragma  alipay之前的信息支付宝
//处理第三方支付App通过URL启动App时传递的数据 详情可见官方集成文档
- (BOOL)handleOpenURL:(NSURL *)url {
    NSLog(@"pay url:%@",url);
    
    if ([url.absoluteString rangeOfString:ByEnergyECWXAppId].length>0) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             if (byEnergyIsValidStr(resultDic[@"resultStatus"]) && [resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                 [self paySuccess];
             }
             else {
                 NSString *memo = resultDic[@"memo"];
                 [self payFailed:byEnergyIsValidStr(memo)?memo:@"支付失败"];
             }
         }];
    }
    else {
        /*[[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            //结果code为成功时，先校验签名，校验成功后做后续处理
            if([code isEqualToString:@"success"]) {
                [self paySuccess];
            }
            else if([code isEqualToString:@"cancel"]) {
                //交易取消
                [self payFailed:@"取消支付"];
            }
            else {
                //交易失败
                [self payFailed:@"支付失败"];
            }
        }];*/
        
        [UMSPPPayUnifyPayPlugin cloudPayHandleOpenURL:url];
    }
    
    return YES;
}

- (void)onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:
                [self paySuccess];
                break;
            case WXErrCodeUserCancel:
                [self payFailed:@"取消支付"];
                break;
            default:
                // TODO: 测试支付失败的时候，给出的errStr能否明确表达
                [self payFailed:byEnergyIsValidStr(resp.errStr)?resp.errStr:@"支付失败"];
                break;
        }
    }
}


- (void)paySuccess {
    if (self.competionBlock) {
        self.competionBlock(@"success", nil);
    }
    self.competionBlock = nil;
}

- (void)payFailed:(NSString *)failedReason {
    if (self.competionBlock) {
        self.competionBlock(@"fail", failedReason);
    }
    self.competionBlock = nil;
}

@end
