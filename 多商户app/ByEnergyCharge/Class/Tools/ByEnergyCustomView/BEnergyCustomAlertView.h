//
//  BEnergyCustomAlertView.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/23.
//  Copyright © 2020 mac. All rights reserved.
//  自定义弹出框 代替系统的弹出框

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BEnergyCustomAlertView;

typedef void(^BDAlertViewOperationBlock)(BEnergyCustomAlertView *target, NSInteger buttonIndex);

typedef NS_ENUM(NSUInteger, BDAlertViewAlignment) {
    BDAlertViewAlignmentDefault,  /**< 文字居中：默认 */
    BDAlertViewAlignmentLeft,  /**< 文字居左：提示更新APP时 */
    BDAlertViewTitleCenter,   //标题居中，detail居左
};
@interface BEnergyCustomAlertView : BEnergyBaseView

@property (nonatomic, strong) UIView  *frameView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView  *buttonsView;
@property (nonatomic, strong) UIColor *sureBtnTitleColor;
@property (nonatomic, strong) UIColor *otherBtnTitleColor;

@property (nonatomic, assign) BDAlertViewAlignment alignment;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, strong) NSArray<__kindof NSString *> *buttonsTitleArray;
@property (nonatomic, copy) BDAlertViewOperationBlock operationAction;

@property (nonatomic, assign) BOOL dismissWhenTouchOutside; /**< 是否点击alert外部消除alert, 默认为NO */
@property (nonatomic, assign) BOOL disableDismissWhenOperationButtonTap;  /**< 是否禁用点击任意按钮消除alert, 默认为NO */

- (instancetype)initWithAlignment:(BDAlertViewAlignment)alignment
                            title:(NSString *)title
                           detail:(NSString *)detail
                buttonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray
                  operationAction:(BDAlertViewOperationBlock)operationAction
          dismissWhenTouchOutside:(BOOL)dismissWhenTouchOutside;

- (void)show;
- (void)dismiss;

+ (void)dismissAll;

+ (instancetype)showAlertViewWithTitle:(NSString *)title
                           buttonArray:(NSArray<__kindof NSString *> *)buttons
                                 block:(BDAlertViewOperationBlock)block;

/**
 自己用
 */
+ (instancetype)showAlertViewWithTitle:(NSString *)title
                                detail:(NSString *)detail
                     buttonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray
                       operationAction:(BDAlertViewOperationBlock)operationAction;

+ (instancetype)showAlertViewWithAlignment:(BDAlertViewAlignment)alignment
                                     title:(NSString *)title
                                    detail:(NSString *)detail
                         buttonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray
                           operationAction:(BDAlertViewOperationBlock)operationAction
                   dismissWhenTouchOutside:(BOOL)dismissWhenTouchOutside;


/**
 显示弹窗提示
 
 @param alignment 标题内容对齐选项
 @param title 标题
 @param detail 内容
 @param buttonsTitleArray 按钮文字数组
 @param operationAction 点击按钮回调
 @param dismissWhenTouchOutside 是否点击弹窗外部时关闭弹窗
 @param autoDismissDelay 没有按钮时自动消失延时
 @return 弹窗实例
 */
+ (instancetype)showAlertViewWithAlignment:(BDAlertViewAlignment)alignment
                                     title:(NSString *)title
                                    detail:(NSString *)detail
                         buttonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray
                           operationAction:(BDAlertViewOperationBlock)operationAction
                   dismissWhenTouchOutside:(BOOL)dismissWhenTouchOutside
                          autoDismissDelay:(NSTimeInterval)autoDismissDelay;

+ (instancetype)showSuccessWithTitle:(NSString *)title;
+ (instancetype)showSuccessWithTitle:(NSString *)title delay:(NSTimeInterval)delay;

+ (instancetype)showErrorWithTitle:(NSString *)title;
+ (instancetype)showErrorWithTitle:(NSString *)title delay:(NSTimeInterval)delay;
@end

NS_ASSUME_NONNULL_END
