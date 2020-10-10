//
//  BDShopCounponCell.h
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDShopCounponListModel.h"
static NSString *const kBDShopCounponCell = @"BDShopCounponCell";

@protocol BDShopCounponCellDelegate<NSObject>
- (void)buttonTapWithModel:(BDShopCounponListModel *)model isMyShop:(BOOL)isMyShop;
@end
@interface BDShopCounponCell : UITableViewCell
@property (nonatomic,strong) BDShopCounponListModel *model;
@property (nonatomic,assign) BOOL isMyShop;
@property (nonatomic,weak) id <BDShopCounponCellDelegate>delegate;
@end
