//
//  ByEnergyUpateVersionTool.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/17.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergySystemInfoViewModel.h"
#import "BEnergyStubGroupViewModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^CompleteBlock)(void);
@interface ByEnergyUpateVersionTool : NSObject
@property (nonatomic, strong) BEnergySystemInfoViewModel *viewModel;
@property (nonatomic, strong) BEnergyStubGroupViewModel *stubGroupViewModel;

/**
 单例化
 @return    JPushTool实例
 */
+ (instancetype)sharedInstance;

- (void)checkAppStoreVesionWithCompleteBlock:(CompleteBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
