//
//  UITableViewHeaderFooterView+Attribute.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/11.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  解决UITableViewStylePlain状态下section是否跟随滚动
 */

@interface UITableViewHeaderFooterView (Attribute)

@property (weak, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSUInteger section;

@end

NS_ASSUME_NONNULL_END
