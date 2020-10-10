//
//  BDShopCounponInfoCell.h
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDShopCounponDetailModel.h"
static NSString *const kBDShopCounponInfoCell = @"BDShopCounponInfoCell";
@interface BDShopCounponInfoCell : UITableViewCell
@property (nonatomic,strong) BDShopCounponDetailModel *model;
@end
