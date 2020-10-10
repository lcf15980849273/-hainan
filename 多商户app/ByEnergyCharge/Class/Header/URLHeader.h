//
//  URLMacro.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/2/24.
//  Copyright © 2020年 newyea. All rights reserved.
//

#ifndef URLHeader_h
#define URLHeader_h

/* 
 API请求路径
这里通过宏定义来切换你当前的服务器类型,
将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
如下:现在的状态为开发服务器
这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
*/
#define DevelopSever    1
#define TestSever       0
#define ProductSever    0
#if DevelopSever
/**开发服务器*/    
#define URL_BASE @"https://testnapp.xmnewyea.com/newyea-admin/"
#elif TestSever
/**预环境服务器*/
#define URL_BASE @"https://napp2.xmnewyea.com/newyea-admin/"
#elif ProductSever
/**生产服务器*/
#define URL_BASE @"https://napp.xmnewyea.com/newyea-admin/"

#endif
#define URL_API(api) [NSString stringWithFormat:@"%@api/%@",URL_BASE,api]

/*------------系统-------------*/
#define ApiAdsPageDetailUrl                          @"apiAdsPage"//获取广告页图片及详情
#define ApiAdsPagingDetailUrl                        @"apiAdsPaging"//消息中心
#define FocusListUrl                                 @"apiFocusList"//焦点图列表
#define SystemInfoUrl                                @"apiSystemInfo"//系统信息接口

/*------------桩群-------------*/
#define StubGroupAggregateUrl                        @"apiStubGroupAggregate"//充电桩群列表汇总
#define StubGroupListUrl                             @"apiStubGroupList"//充电桩群列表查询
#define StubGroupDetailsUrl                          @"apiStubGroupDetails"//桩群详情
#define StubListSocUrl                               @"apiStubListDetail"//桩群详情soc查询
#define ApiStubInfoUrl                               @"apiStubInfo"//充电桩详情查询
#define ApiStubCheckUrl                              @"apiStubCheck"//检测充电枪有没有插好

/*------------登录注册-------------*/
#define ApiGetTokenUrl                               @"apiGetToken"//验证token
#define ApiGetVerifyCodeUrl                          @"apiGetVerifyCode"//获得短信验证码
#define ApiRemoveTokenUrl                            @"apiRemoveToken"//移除token
#define ApiUserLoginUrl                              @"apiUserLogin"//登录接口

/*------------个人信息-------------*/
#define ApiGetUserInfoUrl                            @"apiGetUserInfo"//用户信息详情
#define ApiModifyUrl                                 @"apiModify"//用户完善/修改信息

/*------------文件上传-------------*/
#define UploadFileUrl                                @"apiUploadFile"//文件上传

/*------------充值-------------*/
#define ApiMoneyChargeUrl                            @"apiMoneyCharge"//用户充值/实时支付
#define ApiPayOrderUpdateUrl                         @"apiPayOrderUpdate"//在线支付-更新订单
#define ApiGetInfoByRechargeIdUrl                    @"apiGetInfoByRechargeId"//查询订单号
#define ApiUserAmountDetailUrl                       @"apiUserAmountDetail"//资金明细
#define ApiUserWalletBalanceUrl                      @"apiUserWalletBalance"//获取用户账号总余额

/*------------充电及订单-------------*/
#define ApiCarChargeStartUrl                         @"apiCarChargeStart"//开始充电
#define ApiCarChargeEndUrl                           @"apiCarChargeEnd"//停止充电
#define ApiChargeDetailUrl                           @"apiChargeDetail"//充电中记录详情
#define ApiChargeListUrl                             @"apiChargeList"//充电中记录
#define ApiStubChargeDetailsUrl                      @"apiStubChargeDetails"//设备开始充电详情
#define ApiNewChargeLogListUrl                       @"apiNewChargeLogList"//充电历史记录
#define ApiChargeTypeUrl                             @"apiChargeType"//获取即充即退支付方式
#define ApiChargeLogDetailUrl                        @"apiChargeLogDetail"//充电已完成订单详情
#define ApiInvoiceSumChoiceUrl                       @"apiInvoiceSumChoice"//用户开票金额选择
#define ApiInvoiceSumUrl                             @"apiInvoiceSum"//获取用户开票与未开票金额
#define ApiInvoiceDetailUrl                          @"apiInvoiceDetail"//发票详情
#define ApiInvoiceSortUrl                            @"apiInvoiceSort"//发票分类
#define ApiInvoiceApplyUrl                           @"apiInvoiceApply"//用户开票提交申请
#define ApiInvoiceTipsUrl                            @"apiInvoiceTips"//开票提交申请温馨提示
#define ApiHomeChargeListUrl                         @"apiHomeChargeList"//首页snack bar判断订单数量

/*------------H5相关-------------*/
//#define AppToServiceAgreementUrl                     @"apptoServiceAgreement.do"//服务协议
#define AppToServiceAgreementUrl                     @"/anonPage/chargeAgreement.htm?appkey=wxcd8b4156f432f8ea"//服务协议
//#define AppPrivacyStatementUrl                       @"appPrivacyStatement.do"//用户政策
#define AppPrivacyStatementUrl                       @"anonPage/privacyStatement.htm?appkey=wxcd8b4156f432f8ea"//用户政策
//#define AppHelpCenterUrl                             @"appHelpCenter.do"//帮助中心
#define AppHelpCenterUrl                             @"anonPage/appHelpCenter.htm?appkey=wxcd8b4156f432f8ea"//帮助中心

#define AdsDetailUrl                                 @"adsDetail.do"//焦点图富文本信息
#define ApiUnionPayDetailUrl                         @"appUnionPayDetail.do"//云闪付优惠详情
#define ApiAppUserShareUrl                           @"anonPage/appUserShare.html"//分享送优惠券H5活动页


#define ApiGetCarNumberUrl                           @"apiGetCarNumber"//获得车牌信息
#define ApiGetCarNumberNewUrl                        @"apiGetCarNumberNew"//获得车牌信息（更新）
#define ApiAddCarNumberUrl                           @"apiAddCarNumber"//添加车牌信息
#define ApiDelCarNumberUrl                           @"apiDelCarNumber"//删除车牌信息
#define ApiUpdateCarNumberUrl                        @"apiUpdateCarNumber"//编辑车牌信息
#define ApiCouponCountUrl                            @"apiCouponCount"//优惠券待使用数目
#define ApiCouponListUrl                             @"apiCouponList"//待使用、失效优惠券列表
#define ApiUserCashInfoUrl                           @"apiUserCashInfo"//提现页信息
#define ApiUserCashApplyUrl                          @"apiUserCashApply"//提现申请
#define ApiNewHomeChargeListUrl                      @"apiNewHomeChargeList"//首页数据接口
#define ApiChargeOrderListUrl                        @"apiChargeOrderList"//充电订单列表（包含充电中、已完成、待支付）
#define ApiSettleUnpaidOrderUrl                      @"apiSettleUnpaidOrder"//待支付订单结算
#define ApiUnpaidDetailUrl                           @"apiUnpaidDetail"//待支付详情

/*------------用户反馈-------------*/
#define ApiFeedbackCategorylUrl                      @"apiFeedbackCategory"//反馈问题列表
#define ApiFeedbackListForUserUrl                    @"apiFeedbackListForUser"//我的反馈
#define ApiFeedbackSolveUrl                          @"apiFeedbackSolve"//反馈已解决
#define ApiFeedbackLogListUrl                        @"apiFeedbackLogList"//用户反馈信息列表带回复
#define ApiFeedbackAddUrl                            @"apiFeedbackAdd"//新增反馈
#define ApiFeedbackAppendUrl                         @"apiFeedbackAppend"//追加反馈

/*------------请求白名单 不受错误影响-------------*/
#define Whitelist @[ApiGetTokenUrl,ApiGetVerifyCodeUrl,ApiRemoveTokenUrl,ApiUserLoginUrl]

/*------------分享--------------*/
#define ApiShareCouponProjectUrl                     @"shareCouponProject"//获取分享优惠券活动信息


#define shareWithTitleImageUrl(stubGroupId)          [NSString                       stringWithFormat:@"http://app.xmnewyea.com/appShareStubGroupDetail.do?id=%@",stubGroupId]//图文链接分享，用于微信朋友圈和QQ


#define shareWeChat_lineWithCupon(Url,phoneId)          [NSString                       stringWithFormat:@"%@anonPage/appUserShareReceive.html?userShareId=%@",URL_BASE,phoneId]//分享朋友圈送优惠券
#define shareWithProgramImageUrl(phoneId)        [NSString stringWithFormat:@"pages/userShareGive/userShareGive?shareUserId=%@",phoneId]//小程序分享，用于微信
#endif /* URLMacro_h */
