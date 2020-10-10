//
//  ByEnergyScanManager.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/8/21.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyHomeChargeListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ByEnergyScanManager : NSObject

SINGLETON_FOR_HEADER(ByEnergyScanManager);

@property (nonatomic, assign) id controller;

@property (nonatomic, strong) BEnergyHomeChargeListModel *homeChargeListModel;;

- (void)checkScanQR;

/*支付*/
- (void)submitPay;

- (void)pushBEnergyScanQRViewController;
@end

NS_ASSUME_NONNULL_END
