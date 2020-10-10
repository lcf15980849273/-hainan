//
//  UIScrollView+Empty.m
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "UIScrollView+Empty.h"
#import "LYEmptyViewHeader.h"
#import <objc/runtime.h>
#import "ByEnergyBaseViewModel.h"

static char loadEmptyTypeKey;
static char showNoNet;
static char headerRefreshingBlockKey;
static char footerRefreshingBlockKey;

@implementation UIScrollView (Empty)

- (void)setLoadEmptyType:(SCLoadEmptyType)loadEmptyType {
    if (self.ly_emptyView) {
        return;
    }
    objc_setAssociatedObject(self, &loadEmptyTypeKey, @(loadEmptyType), OBJC_ASSOCIATION_ASSIGN);
    if (loadEmptyType == SCLoadEmptyTypeDefalt) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForDefault
                                                      titleStr:EmptyStrForDefault
                                                     detailStr:@""];
    }else if (loadEmptyType == SCLoadEmptyTypeDefaltTwo) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForDefaultTwo
                                                      titleStr:EmptyStrForDefault
                                                     detailStr:@""];
    }
    else if (loadEmptyType == SCLoadEmptyTypeNoNetwork) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForNetwork
                                                      titleStr:EmptyStrForNetwork
                                                     detailStr:@""];
    }else if (loadEmptyType == SCLoadEmptyTypeRequest) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForRequest
                                                      titleStr:EmptyStrForRequest
                                                     detailStr:@""];
    }else if (loadEmptyType == SCLoadEmptyTypeNoData) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForNoData
                                                      titleStr:EmptyStrForNoData
                                                     detailStr:@""];
    }
    else if (loadEmptyType == SCLoadEmptyTypeNoOrder) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForOrder
                                                      titleStr:EmptyStrForOrder
                                                     detailStr:@""];
    }
    else if (loadEmptyType == SCLoadEmptyTypeNoCapital) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForCapital
                                                      titleStr:EmptyStrForCapital
                                                     detailStr:@""];
    }
    else if (loadEmptyType == SCLoadEmptyTypeNoInvoice) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForInvoice
                                                      titleStr:EmptyStrForInvoice
                                                     detailStr:@""];
    }
    else if (loadEmptyType == SCLoadEmptyTypeNoInvoiceSelect) {
        self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForInvoiceSelect
                                                      titleStr:EmptyStrForInvoiceSelect
                                                     detailStr:@""];
    }else if (loadEmptyType == SCLoadEmptyTypeNoCustomeView) {
        if (self.customeEmptyView) {
          self.ly_emptyView = [LYEmptyView emptyViewWithCustomView:self.customeEmptyView];
            self.ly_emptyView.backgroundColor = [UIColor whiteColor];
        }
        
    }
}



- (SCLoadEmptyType)loadEmptyType {
  
    return [objc_getAssociatedObject(self, &loadEmptyTypeKey) integerValue];
}

- (void)setShowNoNet:(BOOL)showNoNet {
    if (showNoNet) {
        self.ly_noNetEmptyView = [LYEmptyView emptyViewWithImageStr:EmptyViewForNetwork
                                                           titleStr:EmptyStrForNetwork
                                                          detailStr:@""];
    }else {
        if (self.ly_noNetEmptyView) {
            [self.ly_noNetEmptyView removeFromSuperview];
        }
    }
    objc_setAssociatedObject(self, &showNoNet, @(showNoNet), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)showNoNet {
    
    return [objc_getAssociatedObject(self, &showNoNet) integerValue];
}


- (void)setCustomeEmptyView:(UIView *)customeEmptyView {
    SEL key = @selector(customeEmptyView);
    objc_setAssociatedObject(self, key, customeEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)customeEmptyView {
    UIView *view = objc_getAssociatedObject(self, _cmd);
    if (view) {
        return view;
    }
    return [UIView new];
}


#pragma mark - 刷新表格方法
#pragma mark- 设置上啦 下啦刷新
- (MJRefreshNormalHeader*)re_mj_header {
    __weak typeof(self) weakSelf = self;
    return [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.viewModel) {
            self.viewModel.page.PageIndex = 1;
            [self.viewModel.datasArray removeAllObjects];
        }
        !weakSelf.headerRefreshingBlock? :weakSelf.headerRefreshingBlock();
    }];
}

- (MJRefreshBackNormalFooter*)re_mj_footer {
    __weak typeof(self) weakSelf = self;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.viewModel) {
            self.viewModel.page.PageIndex ++;
        }
        !weakSelf.footerRefreshingBlock? :weakSelf.footerRefreshingBlock();
    }];
    footer.arrowView.image = [UIImage new];
    [footer setTitle:self.refreshFooternoMoreDataText forState:MJRefreshStateNoMoreData];
    return footer;
}

#pragma mark- 开始刷新
- (void)beginRefreshing {
    [self.mj_header beginRefreshing];
}

#pragma mark- 结束刷新
- (void)endRefreshing {
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
        if (self.mj_footer.state == MJRefreshStateNoMoreData) {
            [self.mj_footer resetNoMoreData];
        }
    }
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
    if (self.viewModel) {
        if (self.viewModel.hasNoMoreData) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
        self.mj_footer.hidden = self.viewModel.datasArray.count == 0?YES:NO;
    }
    if ([self isKindOfClass:[UITableView class]]) {
        [(UITableView *)self reloadData];
    }else if ([self isKindOfClass:[UICollectionView class]]) {
        [(UICollectionView *)self reloadData];
    }
}


- (void)setHeaderRefreshingBlock:(RERefreshTableViewRefreshingBlock)headerRefreshingBlock {
    if(!self.mj_header) {
        self.mj_header = [self re_mj_header];
        self.mj_header.automaticallyChangeAlpha = YES;
        
    }
    objc_setAssociatedObject(self, &headerRefreshingBlockKey, headerRefreshingBlock, OBJC_ASSOCIATION_COPY);
}

- (RERefreshTableViewRefreshingBlock)headerRefreshingBlock {
    RERefreshTableViewRefreshingBlock headerRefreshingBlock = objc_getAssociatedObject(self, &headerRefreshingBlockKey);
    return headerRefreshingBlock;
}

- (void)setFooterRefreshingBlock:(RERefreshTableViewRefreshingBlock)footerRefreshingBlock {
    if(!self.mj_footer){
        self.mj_footer = [self re_mj_footer];
    }
    objc_setAssociatedObject(self, &footerRefreshingBlockKey, footerRefreshingBlock, OBJC_ASSOCIATION_COPY);
}

- (RERefreshTableViewRefreshingBlock)footerRefreshingBlock {
    RERefreshTableViewRefreshingBlock footerRefreshingBlock = objc_getAssociatedObject(self, &footerRefreshingBlockKey);
    return footerRefreshingBlock;
}

- (void)setViewModel:(ByEnergyBaseViewModel *)viewModel {
    SEL key = @selector(viewModel);
    objc_setAssociatedObject(self, key, viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ByEnergyBaseViewModel *)viewModel {
    ByEnergyBaseViewModel *baseViewModel = objc_getAssociatedObject(self, _cmd);
    return baseViewModel;
}

- (void)setRefreshFooternoMoreDataText:(NSString *)refreshFooternoMoreDataText {
    SEL key = @selector(refreshFooternoMoreDataText);
    objc_setAssociatedObject(self, key, refreshFooternoMoreDataText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)refreshFooternoMoreDataText {
    NSString *string = objc_getAssociatedObject(self, _cmd);
    return string;
}

@end


