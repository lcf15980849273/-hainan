//
//  BDShopCounponDetailModel.h
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDShopCounponDetailModel : NSObject
@property (nonatomic,copy) NSString *storeCardId;//小店优惠卡id
@property (nonatomic,copy) NSString *storeName;//小店店名
@property (nonatomic,copy) NSString *storeLogo;//小店logo
@property (nonatomic,copy) NSString *cardDistinct;//优惠卡享受折扣

@property (nonatomic,copy) NSString *businessName;//实体店名称
@property (nonatomic,copy) NSString *businessTel;//实体店联系电话
@property (nonatomic,copy) NSString *cobberRight;//合伙人权益

@property (nonatomic,copy) NSString *businessProvince;//省
@property (nonatomic,copy) NSString *businessCity;//市
@property (nonatomic,copy) NSString *businessCounty;//区
@property (nonatomic,copy) NSString *businessAddress;
@property (nonatomic,copy) NSString *storeAddress;
@property (nonatomic,copy) NSString *cardExp;

@property (nonatomic,assign) BOOL isMyshop;


//storeId:小店主键id
//storeCardId:优惠卡id
//userId:小店的所属用户
//userUuid:小店用户的uuid
//storeName:小店店名
//storeLogo:小店商标
//storeTel:小店电话
//province:小店省
//city:小店市
//county:小店区
//provinceKey:小店省key
//cityKey:小店市key
//countyKey:小店区key
//address:小店详细地址
//introduction:小店简介
//businessId:实体店id
//businessType:实体店类型
//businessName:实体店名称
//businessTel:实体店联系电话
//businessLogo:实体店logo
//businessProvince:省
//businessCity:市
//businessCounty:区
//businessProvinceKey:省key
//businessCityKey:市key
//businessCountyKey:区key
//businessAddress:详细地址
//cardDistinct:优惠卡享受折扣
//cardAwardRatio:优惠卡核销奖励比例
//cobberRight:合伙人权益

@end
