//
//  BDShopCounponListViewController.h
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BEnergyBaseViewController.h"
typedef NS_ENUM(NSInteger, BDShopCouponType) {
    BDShopCouponTypeCollect = 1, // 收藏
    BDShopCouponTypeDistribute = 2, // 分销
};
@interface BDShopCounponListViewController : BEnergyBaseViewController
@property (nonatomic,assign) BDShopCouponType type;
@property (nonatomic,assign) BOOL isMyshop;//是否是自己的小店YESS
@property (nonatomic,copy) NSString *shopId;//小店ID
@end
