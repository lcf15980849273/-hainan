//
//  XYDataStateView.h
//  XinYongXingQiu
//
//  Created by 刘辰峰 on 2020/3/21.
//  Copyright © 2020 夏立群. All rights reserved.
//

#import "BEnergyBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYDataStateView : BEnergyBaseView

/**< 没有数据显示的title */
@property (nonatomic, copy) NSString *noDataTitle;

/**< 没有数据显示的副标题title */
@property (nonatomic, copy) NSString *noDataSubTitle;

/**< 底部按钮标题title */
@property (nonatomic, copy) NSString *buttonTitle;

/**< 没有数据显示的占位图 */
@property (nonatomic, copy) NSString *noDataImage;

/**< 占位图的frame */
@property (nonatomic, assign) CGRect imageFrame;

/**< 不透明边距为edgeInsets的view */
@property (nonatomic, strong) UIView *wrapperView;

/**< 边距 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/**< 显示在哪个视图上，默认为nil */
@property (nonatomic, weak) UIView *attachSuperview;

/**< wrapperView中的处于屏幕中心的center */
- (CGPoint)centerForSubviewInWrapperView;

/**< 当前最深层父view */
- (UIView *)attachedRootView;
@end

NS_ASSUME_NONNULL_END
