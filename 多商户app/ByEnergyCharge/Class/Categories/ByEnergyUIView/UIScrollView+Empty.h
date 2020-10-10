//
//  UIScrollView+Empty.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJRefreshNormalHeader,MJRefreshAutoNormalFooter,ByEnergyBaseViewModel,MJRefreshComponent;
typedef enum : NSUInteger {
    /**默认*/
    SCLoadEmptyTypeDefalt,
    /**没有网络*/
    SCLoadEmptyTypeNoNetwork,
    /**请求接口 后台报错*/
    SCLoadEmptyTypeRequest,
    /**当前页面没有数据*/
    SCLoadEmptyTypeNoData,
    /**充电订单*/
    SCLoadEmptyTypeNoOrder,
    /**资金明细*/
    SCLoadEmptyTypeNoCapital,
    /**发票明细*/
    SCLoadEmptyTypeNoInvoice,
    /**开票金额选择*/
    SCLoadEmptyTypeNoInvoiceSelect,
    /**自定义*/
    SCLoadEmptyTypeNoCustomeView,
    /**默认2*/
    SCLoadEmptyTypeDefaltTwo,
    
} SCLoadEmptyType;

/** 默认 */
#define EmptyViewForDefault  @"noData_InvoiceSelect"
/** 默认2 */
#define EmptyViewForDefaultTwo  @"nomalEmpty"
/** 没网 */
#define EmptyViewForNetwork  @"noData_NetWork"
/** 充电订单 */
#define EmptyViewForOrder  @"noData_order"
/** 资金明细 */
#define EmptyViewForCapital  @"noData_Capital"
/** 发票明细 */
#define EmptyViewForInvoice  @"noData_Invoice"
/** 开票金额选择 */
#define EmptyViewForInvoiceSelect  @"noData_InvoiceSelect"
/** 当前页面没有数据 */
#define EmptyViewForNoData  @"noData_Datas"
/** 请求接口 后台报错 */
#define EmptyViewForRequest  @"noData_Request"

/** 默认 */
#define EmptyStrForDefault  @"空空如也~"
/** 没网 */
#define EmptyStrForNetwork  @"网络似乎离家出走喽～"
/** 充电订单 */
#define EmptyStrForOrder  @"似乎没有充电订单～"
/** 资金明细 */
#define EmptyStrForCapital  @"似乎没有资金明细～"
/** 发票明细 */
#define EmptyStrForInvoice  @"似乎没有开票明细～"
/** 开票金额选择 */
#define EmptyStrForInvoiceSelect  @"似乎没有金额可以选择～"
/** 当前页面没有数据 */
#define EmptyStrForNoData  @"似乎数据有点问题～"
/** 请求接口 后台报错 */
#define EmptyStrForRequest  @"似乎数据有点问题～"
typedef void(^RERefreshTableViewRefreshingBlock)(void);
@interface UIScrollView (Empty)

//***********************************无数据/无网络/错误处理显示页面***********************

/**
 *  设置页面显示的类型
 */
@property(nonatomic, assign) SCLoadEmptyType loadEmptyType;

/**
 *  设置页面显示的类型
 */
@property(nonatomic, assign) BOOL showNoNet;

/**
 *  自定义view
 */
@property(nonatomic, strong) UIView *customeEmptyView;

/**
 *  自定义view
 */
@property(nonatomic, copy) NSString *refreshFooternoMoreDataText;

/**
 *  绑定数据
 */
@property(nonatomic, strong) ByEnergyBaseViewModel *viewModel;

//************************************UITableView 刷新相关的*****************

/**
 *  表格头部刷新调用的Block
 */
@property(nonatomic, copy) RERefreshTableViewRefreshingBlock headerRefreshingBlock;

/**
 *  表格尾部刷新调用的Block
 */
@property(nonatomic, copy) RERefreshTableViewRefreshingBlock footerRefreshingBlock;

/**
 *  开始刷新
 */
- (void)beginRefreshing;

/**
 *  停止刷新
 */
- (void)endRefreshing;


@end
