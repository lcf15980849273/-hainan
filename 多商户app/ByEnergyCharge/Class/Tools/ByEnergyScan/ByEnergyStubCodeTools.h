//
//  ByEnergyStubCodeTools.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyChargeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, StubCodeToolsType) {
    StubCodeToolsTypeDefault = 0,//扫码
    StubCodeToolsTypeTextField = 1,//输入编号
};

@interface ByEnergyStubCodeTools : NSObject
@property (nonatomic, copy) NSString *stubId;//桩编号
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) RACSubject *chargeSubject;
@property (nonatomic, strong) RACSubject *failSubject;
@property (nonatomic, strong) BEnergyChargeViewModel *viewModel;
@property (nonatomic, assign) StubCodeToolsType type;

//充电桩的对应ID  输入二维码时调用
- (void)inputStubInfomationWithStubId:(NSString *)stubId;
@property (nonatomic, copy) void(^resetScanBlock)(void);
@end

NS_ASSUME_NONNULL_END
