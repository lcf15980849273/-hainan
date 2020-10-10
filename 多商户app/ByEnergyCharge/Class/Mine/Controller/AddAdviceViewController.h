//
//  AddAdviceViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"
#import "BEnergyMyFeedBackListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddAdviceViewController : BEnergyBaseViewController

@property (nonatomic, copy) NSString *feedBackId;
@property(nonatomic, strong)BEnergyMyFeedBackListModel *model;
@property (nonatomic, copy) void(^refreshFeedBackListDataBlock)(void);
@end

NS_ASSUME_NONNULL_END
