//
//  BEnergyFocusModel.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/23.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"
@class SCItemModel;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SCItemImageSourceType) {
    SCItemImageSourceTypeWebUrl,        //网络资源
    SCItemImageSourceTypeAppResource,   //App图片资源
    SCItemImageSourceTypeLocalFile,     //本地资源文件
    SCItemImageSourceTypeLocalData,     //本地资源data
};


@interface BEnergyFocusModel : BEnergyBaseModel
@property (strong, nonatomic) NSString *id;         ///图ID
@property (strong, nonatomic) NSString *imgUrl;     ///图片URL地址
@property (nonatomic) int refType;                  ///所属类型
@property (nonatomic, copy) NSString *refId;      ///所属的ID
@end

@interface SCItemModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *imageUrl;   //image的url，来源于web时是全路径，来源本地是图片名称
@property (nonatomic, copy) NSString *title;      //item的标题
@property (nonatomic, assign) BOOL showTitle;       //是否显示标题
@property (nonatomic, assign) SCItemImageSourceType imgSrcType;      //图片来源类型
@property (nonatomic, strong) NSData *imageData;    //图片数据
@property (nonatomic, copy) NSString *descript;   //描述

@end


NS_ASSUME_NONNULL_END
