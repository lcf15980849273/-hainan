//
//  UITableViewHeaderFooterView+Attribute.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/11.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "UITableViewHeaderFooterView+Attribute.h"
#import <objc/runtime.h>

@implementation UITableViewHeaderFooterView (Attribute)

- (void)setTableView:(UITableView *)tableView {
    SEL selector = @selector(tableView);
    [self willChangeValueForKey:NSStringFromSelector(selector)];
    objc_setAssociatedObject(self, selector, tableView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:NSStringFromSelector(selector)];
}

- (UITableView *)tableView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSection:(NSUInteger)section {
    SEL selector = @selector(section);
    [self willChangeValueForKey:NSStringFromSelector(selector)];
    objc_setAssociatedObject(self, selector, @(section), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:NSStringFromSelector(selector)];
}

- (NSUInteger)section {
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}


@end
