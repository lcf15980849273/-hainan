//
//  BEnergyPriceFormView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyPriceFormView : BEnergyBaseView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) RACSubject *closeSubject;
@end

NS_ASSUME_NONNULL_END
