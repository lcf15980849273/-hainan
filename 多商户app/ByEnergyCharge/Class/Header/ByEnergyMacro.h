//
//  ByEnergyMacro.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/2/24.
//  Copyright © 2020年 newyea. All rights reserved.
//

#ifndef ByEnergyMacro_h
#define ByEnergyMacro_h

/*
    app项目的相关宏定义
 */

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= (version - 0.0001))

#define ECCityName      @"厦门"           ///城市名称
#define ECCityId        @"350200"              ///城市编号

#define ECChargeCntMax  6                                       ///一号多充最大次数
//每页数据加载数
#define PageSize 20

//未登录
#define isLogOut [[USER_DEFAULT objectForKey:@"token"] length] <= 0

/**
 定义cell取值
 */
#define byEnergyCellType                          @"cellType"
#define byEnergyCellTitle                         @"title"
#define byEnergyCellDetail                        @"detailText"
#define byEnergyCellPlaceholder                   @"placeholder"
#define byEnergyCellValue                         @"value"
#define byEnergyCellKey                           @"key"
#define byEnergyCellEnabled                       @"enabled"
#define byEnergyCellSelected                      @"selected"
#define byEnergyCellImageName                     @"imageName"
#define byEnergyCellNormalImageName               @"normalImageName"
#define byEnergyCellMaxInputLength                @"maxInputLength"
#define byEnergyCellValidate                      @"validate"
#define byEnergyCellAutoValidate                  @"autoValidate"
#define byEnergyCellNonEmpty                      @"nonEmpty"
#define byEnergyCellIsSecurity                    @"isSecurity"
#define byEnergyCellRequireValidNum               @"requireValidNum"
#define byEnergyCellDecimalCnt                    @"decimalCnt"
#define byEnergyCellIsArrowImg                    @"isArrowImyg"
#define byEnergyCellDisplayValue                  @"displayValue"
#define byEnergyCellArrayValue                    @"arrayValue"
#define byEnergyCellshowHidden                    @"showHidden"
#define byEnergyCellUnit                          @"unit"
#define byEnergyCellHeight                        @"height"
#define byEnergyCellWidth                         @"width"
#define byEnergyCellDisplayValueArray             @"displayValueArray"
#define byEnergyCellColor                         @"textColor"
#define byEnergyCellFont                          @"textFont"
#define byEnergyCellContentColor                  @"contentColor"
#define byEnergyCellContentFont                   @"contentFont"

#endif /* ByEnergyMacro_h */
