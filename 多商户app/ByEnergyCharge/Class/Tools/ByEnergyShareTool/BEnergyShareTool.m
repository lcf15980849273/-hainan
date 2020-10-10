//
//  BEnergyShareTool.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/18.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyShareTool.h"
@interface BEnergyShareTool ()
@property(nonatomic, strong)NSArray *platformsArray;//默认的分享平台数组
@end

@implementation BEnergyShareTool

+ (NSArray *)fetchPlatformsArray {
    return [[BEnergyShareTool class] fetchPlatformsArray];
}

+ (void)shareWithContentModel:(ShareModel *)contentModel
                 useImageType:(useImgeType)useImageType
                    shareType:(shareType)type fromType:(byEnergySharePageType)fromType {
    
    //设置需要分享的平台
    NSArray *array = contentModel.platformsArray.count > 0 ? contentModel.platformsArray : [BEnergyShareTool fetchPlatformsArray];
    [UMSocialUIManager setPreDefinePlatforms:array];
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        switch (type) {
            case shareMiniProgram:
                [BEnergyShareTool shareWithContentModel:contentModel platform:platformType useImageType:useImageType fromType:fromType];
                break;
            case shareWebPage:
                [BEnergyShareTool shareWebPageToPlatformType:platformType shareContentModel:contentModel];
                break;
            case shareImage:
                [BEnergyShareTool shareImageToPlatformType:platformType shareContentModel:contentModel];
                break;
            case shareImageAndText:
                [BEnergyShareTool shareImageAndTextToPlatformType:platformType shareContentModel:contentModel];
                break;
            case shareText:
                [BEnergyShareTool shareTextToPlatformType:platformType shareContentModel:contentModel];
                break;
            default:
                break;
        }
    }];
}

+ (void)shareWithContentModel:(ShareModel *)contentModel
                     platform:(UMSocialPlatformType)platformType
                 useImageType:(useImgeType)useImageType fromType:(byEnergySharePageType)fromType {
    
    id image;
    if (useImageType == useImgeTypeUrls) {
        image = contentModel.miniImageData.length > 0 ? contentModel.miniImageData : @"";
    }else {
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:contentModel.thumImage]]];
    }
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    if (platformType == UMSocialPlatformType_WechatTimeLine) {
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:contentModel.shareTitle
                                                                                 descr:contentModel.describ
                                                                             thumImage:image];
        if (fromType == byEnergySharePageTypeMine) {
            //            shareObject.webpageUrl =  shareWeChat_lineWithCupon(URL_BASE, contentModel.linkId);
            shareObject.webpageUrl =  [NSString stringWithFormat:@"%@%@&appkey=%@",contentModel.webpageUrl,contentModel.linkId,@"wxcd8b4156f432f8ea"];
            
        }else {
            shareObject.webpageUrl =  shareWithTitleImageUrl(contentModel.linkId);
        }
        messageObject.shareObject = shareObject;
    }
    else if (platformType == UMSocialPlatformType_QQ){
        NSString *title = [NSString stringWithFormat:@"%@-海控充电APP",contentModel.shareTitle];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title
                                                                                 descr:@""
                                                                             thumImage:image];
        shareObject.webpageUrl = shareWithTitleImageUrl(contentModel.linkId);
        messageObject.shareObject = shareObject;
    }
    else {
        //分享小程序
        UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:contentModel.shareTitle
                                                                                         descr:contentModel.describ
                                                                                     thumImage:image];
        shareObject.webpageUrl = URL_BASE;
        shareObject.userName = contentModel.programKey;
        shareObject.path = shareWithProgramImageUrl(contentModel.linkId);
        messageObject.shareObject = shareObject;
        shareObject.hdImageData = contentModel.hdImageData;
        shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 可选体验版和开发板
    }
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:contentModel.controller
                                           completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
        }
        [HUDManager showTextHud:message];
    }];
}

//分享纯文本
+ (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
              shareContentModel:(ShareModel *)contentModel {
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = contentModel.shareContent;
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:contentModel.controller
                                           completion:^(id data, NSError *error) {
        [self shareStatusWithError:error];
    }];
}

//分享图片
+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
               shareContentModel:(ShareModel *)contentModel {
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.thumbImage = [UIImage imageNamed:contentModel.thumImage];
    [shareObject setShareImage:contentModel.shareImage];
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:contentModel.controller
                                           completion:^(id data, NSError *error) {
        [self shareStatusWithError:error];
    }];
}

//分享图文
+ (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
                      shareContentModel:(ShareModel *)contentModel {
    
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = contentModel.text;
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:contentModel.thumImage];
    [shareObject setShareImage:contentModel.shareImage];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:contentModel.controller
                                           completion:^(id data, NSError *error) {
        [self shareStatusWithError:error];
    }];
}

//分享网页
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                 shareContentModel:(ShareModel *)contentModel {
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                         shareObjectWithTitle:contentModel.shareTitle
                                         descr:contentModel.describ
                                         thumImage:[UIImage imageNamed:contentModel.thumImage]];
    //设置网页地址
    shareObject.webpageUrl = contentModel.webpageUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:contentModel.controller
                                           completion:^(id data, NSError *error) {
        [self shareStatusWithError:error];
    }];
}

- (void)sahreWithPlatformType:(UMSocialPlatformType)platformType
                 contentModel:(ShareModel *)contentModel{
    
    
}

+ (void)shareStatusWithError:(NSError *)error {
    NSString *message = nil;
    if (!error) {
        message = [NSString stringWithFormat:@"分享成功"];
    } else {
        message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
    }
    
    [HUDManager showTextHud:message];
}


#pragma mark ----- Lazyload
- (NSArray *)platformsArray {
    if (!_platformsArray) {
        _platformsArray = @[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)];
    }
    return _platformsArray;
}
@end

@implementation ShareModel
- (NSString *)programKey {
    return @"gh_1c758a4a3ae1";
}

@end
