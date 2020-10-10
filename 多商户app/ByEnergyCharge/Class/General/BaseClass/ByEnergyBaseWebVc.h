//
//  ByEnergyBaseWebVc.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/3.
//  Copyright © 2020年 newyea. All rights reserved.
//


#import "BEnergyBaseViewController.h"



@interface ByEnergyBaseWebVc : BEnergyBaseViewController

typedef NS_ENUM(NSInteger,shareButtonType){
    shareButtonTypeweChat = 1,            //分享到微信
    shareButtonTypeweChat_line  = 2,      //分享到微信朋友圈
};

@property (nonatomic, copy) NSString *urlStr;         //web url
@property (nonatomic, copy) NSString *filePath;       //本地文件路径
@property (nonatomic, assign) BOOL byEnergyHideProgress;        //是否隐藏加载进度条
@property (nonatomic, assign) BOOL byEnergyHideLoading;        //是否隐藏加载进度条
@property (nonatomic, assign) BOOL byEnergyAutoLoadDisabled;    //是否禁止自动加载url
@property (nonatomic, assign) BOOL byEnergyNeedRefreshTitle;    //刷新title，使用js获取html的title
@property (nonatomic, assign) BOOL byEnergyRefreshEnabled;      //是否允许下拉刷新
@property (nonatomic, assign) BOOL byEnergyRefreshWhenAppear;   //每次出现都重新加载
@property (nonatomic, assign) BOOL byEnergyPageFitEnabled;      //是否允许内容缩放
@property (nonatomic, assign) BOOL byEnergyDetectNumDisabled;   //是否禁止检测号码
@property (nonatomic, readwrite, assign) BOOL shouldDisableWebViewClose; //是否取消关闭按钮。默认是不取消，default is NO
@property (nonatomic, assign) BOOL isElastic;   //是否需要回弹效果
@property (nonatomic, copy) void(^shareButtonWithButtonType)(shareButtonType type);


/**
类方法，快速生成H5页面
@param     path     uriStr，比如mobile.do
@param     params      参数字典，url中以key1=value1&key2=value2形式拼接
@param     baseUrl     基url
@param     title    导航栏标题
@return    GDBasicH5ViewController实例
*/
+ (ByEnergyBaseWebVc *)byEnergyWebViewControllerWithPath:(NSString *)path
                                               title:(NSString *)title
                                             baseUrl:(NSString *)baseUrl
                                              params:(NSDictionary *)params;
                                             
                                               
/**
 类方法，设置加载进度条的背景颜色
 @param     bgColor     背景颜色
 */
+ (void)byEnergySetWebViewProgressViewBackgroundColor:(UIColor *)bgColor;

/**
 初始化H5页面
 @param     pathStr     uriStr，比如mobile.do
 @param     params      参数字典，url中以key1=value1&key2=value2形式拼接
 @param     baseUrl     基url
 @param     titleStr    导航栏标题
 @return    GDBasicH5ViewController实例
 */
- (instancetype)initWithPath:(NSString *)pathStr
                      params:(NSDictionary *)params
                     baseUrl:(NSString *)baseUrl
                    titleStr:(NSString *)titleStr;

/**
 加载页面，如果是本地文件，调用loadLocalFile:, 否则调用loadPageWithURLStr
 */
- (void)loadPage;

/**
 js调用frameShowAlert的实现方法，默认是显示一个aldert，点击即消息
 如果想自定义这个实现方法，只需要在子类中重新该方法即可
 @param     params      js传过来的参数
 @param     callback    js传过来的回调函数名
 */
- (void)frameShowAlert:(NSDictionary *)params
              callback:(NSString *)callback;

/**
 js调用本地方法的分发方法
 @param     method      方法名
 @param     params      参数字典
 @param     callback    回调方法
 */
- (void)distributePrivateMethodWithName:(NSString *)method
                                 params:(NSDictionary *)params
                               callback:(NSString *)callback;

/**
 清除缓存&Cookie
 */
+ (void)cleanCacheAndCookie;
@end
