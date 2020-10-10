//
//  BEnergyScanQRViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "LBXScanViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface BEnergyScanQRViewController : LBXScanViewController
@property (nonatomic, assign) BOOL ispushCharging;//是否push到准备充电页面，为了防止导航栏问题


+ (LBXScanViewStyle*)ScanViewStyle;
@end

NS_ASSUME_NONNULL_END
