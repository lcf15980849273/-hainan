//
//  BEnergyAddCarNumberViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"
#import "BEnergyCarListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyAddCarNumberViewController : BEnergyBaseViewController
@property (nonatomic, assign) BOOL isAddPlateNo;//是否新增车牌号
@property (nonatomic, copy) NSString *carNumber;
@property (nonatomic, strong) NSArray *carNumberList;
@property (nonatomic, strong) RACSubject *updateSubject;


@property (nonatomic, strong) BEnergyCarListModel *listModel;
@end

NS_ASSUME_NONNULL_END
