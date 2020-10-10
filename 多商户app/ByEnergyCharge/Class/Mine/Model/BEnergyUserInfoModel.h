//
//  BEnergyUserInfoModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/5.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

@interface BEnergyUserInfoModel : BEnergyBaseModel

@property (nonatomic, copy) NSString *id;         //编号
@property (nonatomic, copy) NSString *pId;        //主账户ID(数值0/1为普通用户，其他为子账户)
@property (nonatomic, copy) NSString *account;    //用户账号（手机号码）
@property (nonatomic, copy) NSString *verify;     //秘钥信息
@property (nonatomic, copy) NSString *headImg;    //头像
@property (nonatomic, copy) NSString *headImgUrl; //头像路径
@property (nonatomic, copy) NSString *nickName;   //昵称
@property (nonatomic, copy) NSString *email;      //邮箱
@property (nonatomic, copy) NSString *totalAmount;//子帐号余额
@property (nonatomic, copy) NSString *amount;//帐号余额
@property (nonatomic, copy) NSString *businessAmount;//主账户余额
@property (nonatomic, copy) NSString *lvIcon;     //等级图片
@property (nonatomic, copy) NSString *discount;   //折扣
@property (nonatomic, copy) NSString *cardId;     //卡ID
@property (nonatomic) int integral;                 //积分
@property (nonatomic) int voucherCnt;               //抵用券张数
@property (nonatomic) int favouriateCnt;            //收藏数
@property (nonatomic) int msgCnt;                   //消息数
@property (nonatomic) int msgUnreadCnt;             //未读消息数
@property (nonatomic) int completedFlag;            //0 用户信息不完整 1 用户信息完整
@property (nonatomic) BOOL isRoleGroup;             //是否为商户 是：true 否：false
@property (nonatomic) int usePayPassword;           //是否使用支付密码  1:开启 0：关闭
@property (nonatomic) int hasPayPassword;           //是否设置过支付密码  1:已设置 0：未设置
@property (nonatomic, copy) NSString *formatDate; //生日
@property (nonatomic) int sex;                        //2:女；1：男
@property (nonatomic, copy) NSString *occupation;    //职业：政府部门、事业单位、企业员工、私营业主、个体户、自由职业、 农民、学生、退休、其他
@property (nonatomic, copy) NSString *carNumber;//车牌号信息
@property (nonatomic, assign) int couponCount;//优惠券数量

@end
