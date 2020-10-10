//
//  BEnergyShareTool.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/18.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>
NS_ASSUME_NONNULL_BEGIN
@class ShareModel;



typedef NS_ENUM(NSInteger,byEnergySharePageType){
    byEnergySharePageTypeMine = 1,            //从我的页面分享
    byEnergySharePageTypeSubDetail = 2,     //从桩群详情分享
};

typedef NS_ENUM(NSInteger,useImgeType){
    useImgeTypeNomal = 1,            //外面指定图片
    useImgeTypeUrls  = 2,            //外面模型赋值中的imageurl中取值
};

typedef NS_ENUM(NSInteger,shareType){
    shareMiniProgram = 1,            //小程序
    shareWebPage  = 2,               //网页
    shareImage = 3,                  //图片
    shareImageAndText = 4,           //图文
    shareText = 5,                   //纯文本
};

@interface BEnergyShareTool : NSObject

/**
* 分享内容contentModel
*platform指定分享的平台
根据platform指定分享的平台直接分享，不弹出选择面板
*/
+ (void)shareWithContentModel:(ShareModel *)contentModel
                     platform:(UMSocialPlatformType)platformType
                 useImageType:(useImgeType)useImageType fromType:(byEnergySharePageType)fromType;

/**
* 分享内容contentModel
* 支持弹出分享面板
 type 分享方式
*/
+ (void)shareWithContentModel:(ShareModel *)contentModel
                 useImageType:(useImgeType)useImageType
                    shareType:(shareType)type fromType:(byEnergySharePageType)fromType;


/**
 分享网页
* 分享内容contentModel
 type 分享方式
*/
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                 shareContentModel:(ShareModel *)contentModel;
@end


@interface   ShareModel : NSObject
@property (nonatomic, copy) NSString *shareTitle;//标题
@property (nonatomic, copy) NSString *describ;//描述
@property (nonatomic, copy) NSString *thumImage; //各种分享方式的缩略图
@property (nonatomic, copy) NSString *linkId;//打开webView链接后面拼接的ID ,小程序分享的pathId
@property (nonatomic, copy) NSString *programKey;//小程序key
@property (nonatomic, strong) NSData *hdImageData;//小程序预览图
@property (nonatomic, strong) NSArray<NSString *> *imgUrls;
@property (nonatomic, strong) NSArray *platformsArray;//支持的平台platforms
@property(nonatomic, strong)UIViewController *controller;
@property (nonatomic, copy) NSString *shareContent;//文本分享所需文本
@property (nonatomic, copy) NSString *shareImage;//图片分享所需图片  (必须是url链接)
@property (nonatomic, copy) NSString *text; //图文分享所需文本
@property (nonatomic, copy) NSString *webpageUrl;//网页分享所需网址

@property (nonatomic, strong) NSData *miniImageData;


@end
NS_ASSUME_NONNULL_END
