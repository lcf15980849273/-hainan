//
//  BEnergyBaseTableViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/12/31.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyBaseTableViewController : UITableViewController<BEnergyViewControllerProtocol>
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;//修改状态栏颜色
@property (nonatomic, assign) BOOL isShowLiftBack; //是否显示返回按钮,默认情况是YES
@property (nonatomic, assign) BOOL isPopViewController; //是否返回至指定界面
@property (nonatomic, assign) BOOL isGrouped;//设置tableview为UITableViewStyleGrouped

@property (nonatomic, strong) UIButton *backBtn; //调用类方法后，可以直接访问新建的左边按钮
@property (nonatomic, strong) UIButton *rightBtn; //调用类方法后，可以直接访问新建的右边按钮


//导航栏标题
@property (nonatomic, copy) NSString *titleStr;
//获得在当前UINavigationController中的parentVC，要么为自己，要么为parentViewController
- (UIViewController *)parentVcInNav;

/**
 *  点击返回键的事件
 */
- (void)backBtnClicked;

/**
 导航栏添加文本按钮
 
 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)byEnergyNavItemWitnTitles:(NSArray *)titles
                             isLeft:(BOOL)isLeft
                             target:(id)target
                             action:(SEL)action
                               tags:(NSArray *)tags;

/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)byEnergyNavItemWithImgeNames:(NSArray *)imageNames
                                 isLeft:(BOOL)isLeft
                                 target:(id)target
                                 action:(SEL)action
                                   tags:(NSArray *)tags;

/**
 导航栏添加图标按钮 可添加高亮状态图片
 
 @param imageNames 图标数组
 @param lightedImages 高亮图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)byEnergyNavItemWithImgeNames:(NSArray *)imageNames
                            Highlighted:(NSArray *)lightedImages
                                 isLeft:(BOOL)isLeft
                                 target:(id)target
                                 action:(SEL)action
                                   tags:(NSArray *)tags;


/**
 导航栏添加文本按钮(单个)
 
 @param title 文本
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tag 回调区分用
 */
- (UIBarButtonItem *)byEnergyNavItemWithTitle:(NSString *)title
                                      isLeft:(BOOL)isLeft
                                      target:(id)target
                                      action:(SEL)action
                                        tags:(NSInteger)tag;
/**
 导航栏添加图标按钮(单个)
 
 @param imageName 图片名称
 @param lightedImage 高亮图标名称
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tag 回调区分用
 */
- (UIBarButtonItem *)byEnergyNavItemWithImgeName:(NSString *)imageName
                                     Highlighted:(NSString *)lightedImage
                                          isLeft:(BOOL)isLeft
                                          target:(id)target
                                          action:(SEL)action
                                            tags:(NSInteger)tag;


/**
 pop到指定界面，并释放掉中间所有界面
 */
- (void)popToPointViewController:(NSString *)class;

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
