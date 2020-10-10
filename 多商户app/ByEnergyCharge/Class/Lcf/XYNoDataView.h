//
//  XYNoDataView.h
//  XinYongXingQiu
//
//  Created by 刘辰峰 on 2020/3/22.
//  Copyright © 2020 夏立群. All rights reserved.
//

#import "XYDataStateView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYNoDataView : XYDataStateView
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIView *noDataView;

@property (nonatomic, copy) void(^didClickBtnBlock)(UIButton *btn);
@end

NS_ASSUME_NONNULL_END
