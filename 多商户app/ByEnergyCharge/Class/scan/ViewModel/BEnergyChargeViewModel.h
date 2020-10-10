//
//  BEnergyChargeViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyChargeViewModel : ByEnergyBaseViewModel
@property (nonatomic, copy) NSString *stubId;// 桩ID
@property (nonatomic, assign) int voltageType;// 充电电压   电压类型0表示12v,1表示24v
@property (nonatomic, copy) NSString *orderId;// 订单编号
@property (nonatomic, copy) NSString *carNumber;// 车牌号
@property (nonatomic, copy) NSString *chargeId; //结束充电编号
@property (nonatomic, assign) NSInteger type;// 类型 1充电中、2待支付、3已完成
@property (nonatomic, assign) NSInteger payType;// 支付类型（1.余额，2云闪付）
@property (nonatomic, strong) RACCommand *hnStartChargeCommand;//开始充电
@property (nonatomic, strong) RACCommand *hnEndChargeCommand;// 结束充电
@property (nonatomic, strong) RACCommand *hnCheckStubInfoCommand;// 检测桩是否可用
@property (nonatomic, strong) RACCommand *hnchargeListCommand;// 充电中记录
@property (nonatomic, strong) RACCommand *hnchargingDetailCommand;// 充电中记录详情
@property (nonatomic, strong) RACCommand *hnNewChargeLogListCommand;// 充电历史记录
@property (nonatomic, strong) RACCommand *hnOrderFinshDetailCommand;// 充电完成订单详情
@property (nonatomic, strong) RACCommand *hnFetchChargesCommand;// 获取开始充电页面数据
@property (nonatomic, strong) RACCommand *homeChargeList;// 获取订单数量
@property (nonatomic, strong) RACCommand *hnOdderListCommand;// 充电订单列表（包含充电中、已完成、待支付）
@property (nonatomic, strong) RACCommand *hnsettleUnpaidOrder;// 待支付订单结算
@property (nonatomic, strong) RACCommand *hnUnpaidDetailCommand;// 待支付详情
@property (nonatomic, strong) RACCommand *hnChargeTypeCommand; //支付方式
@property (nonatomic, strong) RACCommand *hnCheckGusStausCommand; // 检测充电枪有没有插好
@end

NS_ASSUME_NONNULL_END
