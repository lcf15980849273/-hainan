//
//  BEnergyTradeInfoModel.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

@interface BEnergyTradeInfoModel : BEnergyBaseModel

@property (nonatomic, copy) NSString *id;                 ///订单编号
@property (nonatomic, copy) NSString *price;              ///订单金额
@property (nonatomic, copy) NSString *tradeNo;            ///第三方交易号(银联交易使用)
@property (nonatomic, copy) NSString *ali;                ///支付宝的签名信息
@property (nonatomic, copy) NSString *weixinParam;        ///微信的签名信息

@property (nonatomic, copy) NSString *appPayRequest;     ///云闪付支付 2020.7.7新增

@end
