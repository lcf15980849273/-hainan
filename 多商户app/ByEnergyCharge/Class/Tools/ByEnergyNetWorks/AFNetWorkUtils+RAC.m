//
//  AFNetWorkUtils+RAC.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "AFNetWorkUtils+RAC.h"
#import "BEnergyBaseModel.h"
#import <objc/runtime.h>
#import "BEnergyAppStorage.h"
#import "SCPermission.h"
#import "ApplicationUtil.h"

static NSInteger const customErrorCode = 400;

static NSString *const customErrorInfoKey = @"customErrorInfoKey";

NSString *const netWorkUtilsDomain = @"请求失败";

NSString *const operationInfoKey = @"operationInfoKey";

NSString *const errorHelperDomain = @"请求错误";

NSString *const operationInfoCode = @"errorCode";

NSString *const errorShow = @"errorShow";

@implementation NSErrorHelper

+ (NSError *)createErrorWithUserInfo:(NSDictionary *)userInfo domain:(NSString *)domain {
    return [NSError errorWithDomain:domain code:0 userInfo:userInfo];
}

+ (NSString *)handleErrorMessage:(NSError *)error {
    NSString * result = error.description;
    switch (error.code) {
            
    }
    return result;
}
@end

@implementation AFNetWorkUtils (RAC)

+ (RACSignal *)RequestPOSTWithURL:(NSString *)url
                    parameters:(NSDictionary *)parameters
                         responseClass:(Class)responseClass
                 netWorksModel:(ByEnergyNetWorkModel *)netWorksModel {
    ByEnergyWeakSekf
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        ByEnergyStrongSelf
        if (byEnergyIsValidStr([USER_DEFAULT objectForKey:TokenFailure]) || !byEnergyIsValidStr([USER_DEFAULT objectForKey:@"token"])) {
            NSArray *array = [url componentsSeparatedByString:@"/"];
            if (![Whitelist containsObject:[array lastObject]]) {
                netWorksModel.isHidenAll = YES;
            }
        }
        if (!netWorksModel.isHidenHUD) {
            [HUDManager showLoadingHud:netWorksModel.loadingString];
        }
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        if (parameters.count > 0) {
            if (netWorksModel.isEncryption) {
                [params setObject:[parameters ext_encryptForBase64String:kpwd] forKey:@"param"];
                
                
            }else {
                [params addEntriesFromDictionary:parameters];
            }
        }
       
        [self POSTWithURL:url
               parameters:params
              cachePolicy:netWorksModel.cachePolicy
                 callback:^(id  _Nullable responseObject, BOOL isCache, NSError * _Nonnull error) {
            [HUDManager hidenHud];
//             NSLog(@"请求url%@\n请求参数%@\n请求结果%@",url,parameters,responseObject);
            if (error == nil) {
                [self handleResultWithSubscriber:subscriber responseObject:responseObject ModelName:NSStringFromClass(responseClass) netWorksModel:netWorksModel];
            }else {
                if (netWorksModel.isShowError) {
                    [self handleErrorResultWithSubscriber:subscriber error:error];
                }
            }
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }] replayLazily];
}


+ (RACSignal *)RequestGETWithURL:(NSString *)url
                    parameters:(NSDictionary *)parameters
                 responseClass:(Class)responseClass
                 netWorksModel:(ByEnergyNetWorkModel *)netWorksModel {
    ByEnergyWeakSekf
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        ByEnergyStrongSelf
        if (byEnergyIsValidStr([USER_DEFAULT objectForKey:TokenFailure]) || !byEnergyIsValidStr([USER_DEFAULT objectForKey:@"token"])) {
            NSArray *array = [url componentsSeparatedByString:@"/"];
            if (![Whitelist containsObject:[array lastObject]]) {
                netWorksModel.isHidenAll = YES;
            }
        }
        if (!netWorksModel.isHidenHUD) {
            [HUDManager showLoadingHud:netWorksModel.loadingString];
        }
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        if (parameters.count > 0) {
            if (netWorksModel.isEncryption) {
                [params setObject:[parameters ext_encryptForBase64String:kpwd] forKey:@"param"];
            }else {
                [params addEntriesFromDictionary:parameters];
            }
        }
//        NSLog(@"请求参数:%@\n%@",url,parameters);
        [self GETWithURL:url parameters:params cachePolicy:netWorksModel.cachePolicy callback:^(id  _Nullable responseObject, BOOL isCache, NSError * _Nonnull error) {
            [HUDManager hidenHud];
            if (error == nil) {
                [self handleResultWithSubscriber:subscriber responseObject:responseObject ModelName:NSStringFromClass(responseClass) netWorksModel:netWorksModel];
            }else {
                if (netWorksModel.isShowError) {
                    [self handleErrorResultWithSubscriber:subscriber error:error];
                }
                
            }
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }] replayLazily];
}

+ (RACSignal *)RequestUploadImagesWithURL:(NSString *)url
                               params:(NSDictionary *)params
                            filePaths:(NSArray *)filePaths
                        netWorksModel:(ByEnergyNetWorkModel *)netWorksModel{
    ByEnergyWeakSekf
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        ByEnergyStrongSelf
        if (!netWorksModel.isHidenHUD  && !netWorksModel.isHidenAll) {
            [HUDManager showLoadingHud:netWorksModel.loadingString];
        }
        [self uploadImageURL:url parameters:params images:filePaths name:@"" fileName:@"file" mimeType:@"" progress:^(NSProgress * _Nonnull progress) {
            
        } callback:^(id  _Nullable responseObject, BOOL isCache, NSError * _Nonnull error) {
            if (error == nil) {
                [self handleResultWithSubscriber:subscriber responseObject:responseObject ModelName:nil netWorksModel:netWorksModel];
            }else {
                if (netWorksModel.isShowError  && !netWorksModel.isHidenAll) {
                    [HUDManager showTextHud:byEnergyClearNilStr(error.description)];
                }
                [self handleErrorResultWithSubscriber:subscriber error:error];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }] setNameWithFormat:@"<%@: %p> -post2racWthURL: %@, params: %@", self.class, self, url, params];
}


+ (void)handleResultWithSubscriber:(id <RACSubscriber>)subscriber
                    responseObject:(id)responseObject
                             ModelName:(NSString *)modelName
                     netWorksModel:(ByEnergyNetWorkModel *)netWorksModel {
    
    NSDictionary *resultDict = responseObject;
    NSString *sucessKey       = resultDict[@"code"];//请求数据成功的字段
    NSString *messageKey      = byEnergyClearNilReturnStr(responseObject[@"msg"], @"");//请求数据的提示消息
    
//    NSLog(@"1111--------%@",responseObject);
    
    if ([sucessKey integerValue] == 200) {
        //获取数据体
        id data = resultDict[@"data"];
        NSError* err = nil;
        if ([data isKindOfClass:[NSArray class]] && byEnergyIsValidStr(modelName)) {
            NSMutableArray *dataList = [NSClassFromString(modelName) arrayOfModelsFromDictionaries:data error:&err];
            [subscriber sendNext:dataList];
        }else if ([data isKindOfClass:[NSDictionary class]]&& byEnergyIsValidStr(modelName)) {
          NSObject *objc = [[NSClassFromString(modelName) alloc] initWithDictionary:data error:&err];
            [subscriber sendNext:objc];
        } else {
           [subscriber sendNext:data];
        }
        netWorksModel.isHidenAll = NO;
        [subscriber sendCompleted];
    }else {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[operationInfoKey] = responseObject;
        userInfo[customErrorInfoKey] = messageKey;
        userInfo[operationInfoCode] = sucessKey;
        userInfo[errorShow] = NSStringFormat(@"%d",netWorksModel.isShowError);
        NSError * error = [NSErrorHelper createErrorWithUserInfo:userInfo domain:netWorkUtilsDomain];
        
        if ([sucessKey integerValue] == 2207 || [sucessKey integerValue] == 42003) {
            netWorksModel.isShowError = NO;
            ByEnergySendNotification(ByEnergyLogout, nil);
            [USER_DEFAULT setObject:@"" forKey:@"token"];
        }else if ([sucessKey integerValue] == 1002) {
            dispatch_async(dispatch_get_main_queue(), ^{
                netWorksModel.isShowError = YES;
                if (!byEnergyIsValidStr([USER_DEFAULT objectForKey:@"phoneNo"])) {
                    netWorksModel.isShowError = NO;
                }
                ByEnergySendNotification(ByEnergyLogout, nil);
                [USER_DEFAULT setObject:@"" forKey:@"token"];
            });
        }
        if (netWorksModel.isShowError && byEnergyIsValidStr(messageKey) && !netWorksModel.isHidenAll) {
            [HUDManager showTextHud:byEnergyClearNilStr(messageKey)];
        }
        netWorksModel.isHidenAll = NO;
        [subscriber sendError:error];
        [subscriber sendCompleted];
    }
}

+ (void)handleErrorResultWithSubscriber:(id <RACSubscriber>)subscriber
                                  error:(NSError *)error{
    [subscriber sendError:error];
    [self handleErrorMessage:error];
    [subscriber sendCompleted];
}

+ (NSString *)handleErrorMessage:(NSError *)error {
    NSString * result = nil;
     [HUDManager hidenHud];
    switch (error.code) {
        case kCFURLErrorTimedOut://-1001
           
            [HUDManager showStateHud:@"网络请求超时" state:HUDStateTypeFail];
            result = @"服务器连接超时";
            break;
        case kCFURLErrorBadServerResponse://-1011
            result = @"请求无效";
            break;
        case kCFURLErrorNotConnectedToInternet: //-1009 @"似乎已断开与互联网的连接。"
            [HUDManager hidenHud];
            ByEnergySendNotification(ByEnergyErrorNetWork, nil);
            if (![[BEnergyAppStorage sharedInstance] hasShowNoNetHint]) {
                [[BEnergyAppStorage sharedInstance] setHasShowNoNetHint:YES];
                [AlertViewTools showSystemAlertViewTitle:@"网络连接异常" Message:NSStringFormat(@"请检查您的网络连接，或进入“设置”中允许“%@”访问网络数据。",[ApplicationUtil appName]) Cancel:@"好" Submit:@"设置" completionHandler:^(NSUInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        [SCPermission displayAppPrivacySettings];
                    }
                }];
            }
        case kCFURLErrorCannotDecodeContentData://-1016 cmcc 解析数据失败
            result = @"网络好像断开了...";
            break;
        case kCFURLErrorCannotFindHost: //-1003 @"未能找到使用指定主机名的服务器。"
            result = @"服务器内部错误";
            break;
        case kCFURLErrorNetworkConnectionLost: //-1005
            result = @"网络连接已中断";
            break;
        default:
            result = @"其他错误";
            NSLog(@"其他错误 error:%@", error);
            break;
    }
    return result;
}

//// 网络请求频率很高，不必每次都创建\销毁一个hud，只需创建一个反复使用即可
//+ (MBProgressHUD *)shareNetHUD{
//    MBProgressHUD *hud = objc_getAssociatedObject(self, _cmd);
//    if (!hud) {
//        hud = [[MBProgressHUD alloc] initWithView:ByEnergyAppWindow];
//        hud.label.text = @"加载中...";
//        objc_setAssociatedObject(self, _cmd, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return hud;
//}
//
//+ (void)showLoadingText:(NSString *)text{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [self shareNetHUD];
//        [hud setRemoveFromSuperViewOnHide:YES];
//        hud.label.text = text?:@"加载中...";
//        hud.label.font = [UIFont boldSystemFontOfSize:16];
//        [ByEnergyAppWindow addSubview:hud];
//        [hud showAnimated:YES];
//    });
//}
//
//+ (void)hideHUD {
//    MBProgressHUD *hud = [self shareNetHUD];
//    [hud hideAnimated:YES];
//}

@end

