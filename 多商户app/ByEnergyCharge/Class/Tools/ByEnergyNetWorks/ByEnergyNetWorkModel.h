//
//  ByEnergyNetWorkModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkUtils.h"

@interface ByEnergyNetWorkModel : NSObject
/** *是否是加密请求,默认是YES*/
@property (nonatomic, assign) BOOL isEncryption;
/** *是否显示HUD,默认显示*/
@property (nonatomic, assign) BOOL isHidenHUD;
/** *是否隐藏HUD&错误信息,默认显示*/
@property (nonatomic, assign) BOOL isHidenAll;
/** *是否显示错误信息,默认显示*/
@property (nonatomic, assign) BOOL isShowError;
/** *是否是HTTPS请求,默认是NO*/
@property (nonatomic, assign) BOOL isHttpsRequest;
/** *缓存设置策略,默认是MCachePolicyIgnoreCache 不缓存*/
@property (nonatomic, assign) MCachePolicy cachePolicy;
/** *是否刷新数据;YES,刷新数据,重新缓存;NO,反之*/
@property (nonatomic, assign) BOOL isRefresh;
/** *是否读取缓存;YES:读取缓存;NO:反之*/
@property (nonatomic, assign) BOOL isReadCash;
/** *缓存时间*/
@property (nonatomic, assign) NSInteger cashTime;
/** *请求方式,默认POST请求*/
@property (nonatomic, assign) MRequestMethod requestStytle;
/** *验证json格式*/
@property (nonatomic, strong) id jsonValidator;
/** *提示文字*/
@property (nonatomic, copy) NSString *loadingString;

@end
