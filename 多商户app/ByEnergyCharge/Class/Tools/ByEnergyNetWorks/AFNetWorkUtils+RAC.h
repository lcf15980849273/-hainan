//
//  AFNetWorkUtils+RAC.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "AFNetWorkUtils.h"
#import "ByEnergyNetWorkModel.h"

@interface NSErrorHelper : NSObject

+ (NSError *)createErrorWithUserInfo:(NSDictionary *)userInfo domain:(NSString *)domain;
@end

@interface AFNetWorkUtils (RAC)

/**
 RAC POST请求

 @param url 请求地址
 @param parameters 请求参数
 @param responseClass 请求返回数据类型
 @param netWorksModel 参数设置
 @return 带请求结果（对象）的信号
 */
+ (RACSignal *)RequestPOSTWithURL:(NSString *)url
                    parameters:(NSDictionary *)parameters
                 responseClass:(Class)responseClass
                 netWorksModel:(ByEnergyNetWorkModel *)netWorksModel;

/**
 上传图片
 
 @param url 请求地址
 @param params 请求参数
 @param filePaths 多图路径
 @param netWorksModel 参数设置
 @return 带请求结果（对象）的信号
 */
+ (RACSignal *)RequestUploadImagesWithURL:(NSString *)url
                               params:(NSDictionary *)params
                            filePaths:(NSArray*)filePaths
                        netWorksModel:(ByEnergyNetWorkModel *)netWorksModel;


/**
RAC GET请求

@param url 请求地址
@param parameters 请求参数
@param responseClass 请求返回数据类型
@param netWorksModel 参数设置
@return 带请求结果（对象）的信号
*/
+ (RACSignal *)RequestGETWithURL:(NSString *)url
                   parameters:(NSDictionary *)parameters
                responseClass:(Class)responseClass
                netWorksModel:(ByEnergyNetWorkModel *)netWorksModel;

@end
