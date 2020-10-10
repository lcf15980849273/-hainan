//
//  BDShopCounponDetailViewController.h
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BEnergyBaseViewController.h"
#import "BDShopCounponIntroduceCell.h"
typedef NS_ENUM(NSInteger, BDShopCardType) {
    BDShopCardSelf = 1, // 自己
    BDShopCardOther = 2, // 他人
};

@interface BDShopCounponDetailViewController : BEnergyBaseViewController
@property (nonatomic,copy) NSString *storeCardId;
@property (nonatomic,assign) BDShopCardType type;
@end
