//
//  BDRecommendationViewController.h
//  bydeal
//
//  Created by chenfeng on 2018/12/27.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BEnergyBaseTableViewController.h"
//#import "BDGoodsModel.h"
@interface BDRecommendationViewController : BEnergyBaseTableViewController
//@property (nonatomic,strong) BDGoodsModel *model;
@property (nonatomic,copy) void(^refreshShopList)();
@end
