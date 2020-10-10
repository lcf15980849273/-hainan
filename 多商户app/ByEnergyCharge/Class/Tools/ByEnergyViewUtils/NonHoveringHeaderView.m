
//
//  NonHoveringHeaderView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/11.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "NonHoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"

@implementation NonHoveringHeaderView

- (void)setFrame:(CGRect)frame {
    [super setFrame:[self.tableView rectForHeaderInSection:self.section]];
}


@end
