//
//  BDShopInfoViewController.h
//  bydeal
//
//  Created by chenfeng on 2018/12/22.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BEnergyBaseViewController.h"

@interface BDShopInfoViewController : BEnergyBaseViewController
@property (nonatomic,copy) NSString *shopID;
@property (nonatomic,copy) void(^fetchShopId)(NSString *shopId);
@property (nonatomic,assign) BOOL isJumpRoot;
@end
