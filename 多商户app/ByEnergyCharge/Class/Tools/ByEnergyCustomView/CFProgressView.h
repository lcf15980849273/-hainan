//
//  CFProgressView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface CFProgressView : UIView
@property (nonatomic, assign) CGFloat progress;

//进度条颜色
@property(nonatomic,strong) UIColor *progerssColor;
//进度条背景颜色
@property(nonatomic,strong) UIColor *progerssBackgroundColor;
//进度条的宽度
@property(nonatomic,assign) CGFloat progerWidth;
//进度数据字体大小
@property(nonatomic,assign)CGFloat percentageFontSize;

@property (nonatomic, strong) UILabel *socLabel;//百分比标签
@property (nonatomic, strong) UILabel *stateLabel;//状态
@end

NS_ASSUME_NONNULL_END
