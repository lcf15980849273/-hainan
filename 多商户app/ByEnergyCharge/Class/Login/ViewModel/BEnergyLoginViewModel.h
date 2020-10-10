//
//  BEnergyLoginViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/6.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyBaseViewModel.h"

@interface BEnergyLoginViewModel : ByEnergyBaseViewModel
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) BOOL isAgreement;
@property (nonatomic, assign) BOOL isDownTime;// 是否点击获取验证码
@property (nonatomic, strong) RACCommand *hnFechVerityCodeCommand;// 获取验证码
@property (nonatomic, strong) RACCommand *hnRemoveTokenCommand;// 退出登录移除token接口
@property (nonatomic, strong) RACCommand *hnLoginCommand;// 登录接口

@end
