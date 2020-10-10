 //
//  BEnergySystemInfoModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

@class OptionModel,AboutInfo,appAuthModel,chargeTypeModel,rechargeAmountStatusModel,versionUpdateModel,cashStatusModel,invoiceStatusModel,umspayStatusModel,alipayStatusModel,wxpayStatusModel,shareActivityModel;

@interface BEnergySystemInfoModel : BEnergyBaseModel
@property (nonatomic, strong) NSArray<OptionModel *> *cityList; //城市选项列表
@property (nonatomic, strong) NSArray<OptionModel *> *chargeList; //充值选项列表
@property (nonatomic) int updateEnabled; //是否开启提示 0不提示 1提示但不强制 2提示并强制更新
@property (nonatomic, copy) NSString *payType; //支付方式
@property (nonatomic, strong) AboutInfo *aboutInfo; //关于我们内容
@property (nonatomic, strong) appAuthModel *auth; //是否开启余额充值页面(0:关闭余额,1:开启余额)
@property (nonatomic, copy) NSString *telephone; //客服电话


@end

@interface OptionModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *code; //选项代码
@property (nonatomic, copy) NSString *name; //选项值
@end

@interface AboutInfo : BEnergyBaseModel
@property (nonatomic, copy) NSString *officialURL; //官网
@property (nonatomic, copy) NSString *weChat; //微信公众号
@property (nonatomic, copy) NSString *business; //商务邮箱
@end

@interface appAuthModel : BEnergyBaseModel
@property (nonatomic, copy) chargeTypeModel *chargeType;
@property (nonatomic, copy) rechargeAmountStatusModel *rechargeAmountStatus;
@property (nonatomic, copy) versionUpdateModel *versionUpdate;
@property (nonatomic, copy) cashStatusModel *cashStatus;
@property (nonatomic, copy) invoiceStatusModel *invoiceStatus;
@property (nonatomic, strong) umspayStatusModel *umspayStatus;/*银联支付开关*/
@property (nonatomic, strong) alipayStatusModel *alipayStatus;/*支付宝支付开关*/
@property (nonatomic, strong) wxpayStatusModel *wxpayStatus;/*微信支付开关*/
@property (nonatomic, strong) shareActivityModel *shareCouponStatus; //分享送优惠券开关
@end

/*充电准备页面显示充电方式*/
@interface chargeTypeModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *value;//（0即充即退和余额 1即充即退 2 余额）
@property (nonatomic, copy) NSString *valueDec;
@end

/*我的页面控制展示钱包*/
@interface rechargeAmountStatusModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *value;//（0关闭余额 1开启余额）
@property (nonatomic, copy) NSString *valueDec;
@end

/*app更新开关*/
@interface versionUpdateModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) int value;
@property (nonatomic, copy) NSString *valueDec;
@end


/*我钱包页面提现按钮开关*/
@interface cashStatusModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *value; //提现开关(0:开,1:关)
@property (nonatomic, copy) NSString *valueDec;
@end

/*打开发票申请入口开关*/
@interface invoiceStatusModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *value; //提现开关(0:开,1:关)
@property (nonatomic, copy) NSString *valueDec;
@end

/*银联支付开关*/
@interface umspayStatusModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *valueDec;
@end

/*支付宝支付开关*/
@interface alipayStatusModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *valueDec;
@end

/*微信支付开关*/
@interface wxpayStatusModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *valueDec;
@end

//分享送优惠券开关
@interface shareActivityModel : BEnergyBaseModel
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *valueDec;

@end
