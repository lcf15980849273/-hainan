//
//  UIView+Empty.m
//  LYEmptyViewDemo
//
//  Created by liyang on 2018/5/10.
//  Copyright © 2018年 liyang. All rights reserved.
//

#import "UIView+Empty.h"
#import <objc/runtime.h>
#import "LYEmptyView.h"
#import "BEnergyAppStorage.h"

#pragma mark - ------------------ UIView ------------------



@implementation UIView (Empty)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

- (BOOL)hasReload {
    return [objc_getAssociatedObject(self, @selector(hasReload)) boolValue];
}

- (void)setHasReload:(BOOL)hasReload {
    objc_setAssociatedObject(self, @selector(hasReload), @(hasReload), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Setter/Getter
static char kly_EmptyViewKey;
static char kNoNetEmptyViewKey;
- (void)setLy_emptyView:(LYEmptyView *)ly_emptyView{
    if (ly_emptyView != self.ly_emptyView) {
        
        objc_setAssociatedObject(self, &kly_EmptyViewKey, ly_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if (view == objc_getAssociatedObject(self, &kly_EmptyViewKey)) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.ly_emptyView];
        self.ly_emptyView.hidden = YES;//添加时默认隐藏
    }
}
- (LYEmptyView *)ly_emptyView{
    return  objc_getAssociatedObject(self, &kly_EmptyViewKey);
}

- (void)setLy_noNetEmptyView:(LYEmptyView *)ly_noNetEmptyView {
    if (ly_noNetEmptyView != self.ly_noNetEmptyView) {
        objc_setAssociatedObject(self, &kNoNetEmptyViewKey, ly_noNetEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[LYEmptyView class]]) {
                
                if (view == objc_getAssociatedObject(self, &kNoNetEmptyViewKey)) {
                    [view removeFromSuperview];
                }
            }
        }
        [self addSubview:self.ly_noNetEmptyView];
        self.ly_noNetEmptyView.hidden = YES;//添加时默认隐藏
    }
}

- (LYEmptyView *)ly_noNetEmptyView {
    return  objc_getAssociatedObject(self, &kNoNetEmptyViewKey);
}

- (void)setEmptyView:(LYEmptyView *)emptyView {
    
}

- (LYEmptyView *)emptyView {
    if ([[BEnergyAppStorage sharedInstance] isNoNetContent]) {
        LYEmptyView *oldEmptyView = objc_getAssociatedObject(self, &kly_EmptyViewKey);
        oldEmptyView.hidden = YES;
        return  objc_getAssociatedObject(self, &kNoNetEmptyViewKey);
    }
    LYEmptyView *oldEmptyView = objc_getAssociatedObject(self, &kNoNetEmptyViewKey);
    oldEmptyView.hidden = YES;
    return  objc_getAssociatedObject(self, &kly_EmptyViewKey);
}

#pragma mark - Private Method (UITableView、UICollectionView有效)
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}
- (void)getDataAndSet{
    //没有设置emptyView的，直接返回
    if (!self.ly_emptyView) {
        return;
    }
    
    if ([self totalDataCount] == 0) {
        [self show];
    }else{
        [self hide];
    }
}
- (void)show{
    
    //当不自动显隐时，内部自动调用show方法时也不要去显示，要显示的话只有手动去调用 ly_showEmptyView
    if (!self.ly_emptyView.autoShowEmptyView) {
        self.emptyView.hidden = YES;
        return;
    }
    
    [self ly_showEmptyView];
}
- (void)hide{
    
    if (!self.ly_emptyView.autoShowEmptyView) {
        self.emptyView.hidden = YES;
        return;
    }
    
    [self ly_hideEmptyView];
}

#pragma mark - Public Method
- (void)ly_showEmptyView{
    
    [self.emptyView.superview layoutSubviews];
    self.emptyView.hidden = self.hasReload?NO:YES;
    self.hasReload = YES;
    //让 emptyBGView 始终保持在最上层
    [self bringSubviewToFront:self.emptyView];
}
- (void)ly_hideEmptyView{
    self.emptyView.hidden = YES;
}

- (void)ly_startLoading{
    self.emptyView.hidden = YES;
}
- (void)ly_endLoading{
    self.emptyView.hidden = [self totalDataCount];
}

@end

#pragma mark - ------------------ UITableView ------------------

@implementation UITableView (Empty)
+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(ly_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(ly_insertSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(ly_deleteSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:) method2:@selector(ly_reloadSections:withRowAnimation:)];
    
    ///row
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(ly_insertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(ly_deleteRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:) method2:@selector(ly_reloadRowsAtIndexPaths:withRowAnimation:)];
}
- (void)ly_reloadData{
    [self ly_reloadData];
    [self getDataAndSet];
}
///section
- (void)ly_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ly_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_deleteSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ly_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_reloadSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

///row
- (void)ly_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ly_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ly_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self ly_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}


@end

#pragma mark - ------------------ UICollectionView ------------------

@implementation UICollectionView (Empty)

+ (void)load{
    
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(ly_reloadData)];
    
    ///section
    [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(ly_insertSections:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(ly_deleteSections:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:) method2:@selector(ly_reloadSections:)];
    
    ///item
    [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(ly_insertItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(ly_deleteItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:) method2:@selector(ly_reloadItemsAtIndexPaths:)];
    
}
- (void)ly_reloadData{
    [self ly_reloadData];
    [self getDataAndSet];
}
///section
- (void)ly_insertSections:(NSIndexSet *)sections{
    [self ly_insertSections:sections];
    [self getDataAndSet];
}
- (void)ly_deleteSections:(NSIndexSet *)sections{
    [self ly_deleteSections:sections];
    [self getDataAndSet];
}
- (void)ly_reloadSections:(NSIndexSet *)sections{
    [self ly_reloadSections:sections];
    [self getDataAndSet];
}

///item
- (void)ly_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ly_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)ly_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ly_deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)ly_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self ly_reloadItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

@end

