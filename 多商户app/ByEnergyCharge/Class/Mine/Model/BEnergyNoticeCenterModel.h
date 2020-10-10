//
//  BEnergyNoticeCenterModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyNoticeCenterModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *imgUrl;//图片
@property (nonatomic, copy) NSString *info;//广告信息
@property (nonatomic, copy) NSString *orderId;//时间
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, copy) NSString *refId;//
@property(nonatomic, assign)int refType;//链接类型:0富文本1外链
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgPopupUrl;//弹窗图片
@property (nonatomic, copy) NSString *srcUrl;//跳转外链地址
@end

NS_ASSUME_NONNULL_END
