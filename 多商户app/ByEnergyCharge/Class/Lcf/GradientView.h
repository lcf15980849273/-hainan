//
//  GradientView.h
//  xinyanxiaodai
//
//  Created by mac on 2020/5/20.
//  Copyright © 2020 byl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientView : UIView

@property (nonatomic) IBInspectable UIColor *bgStartColor;

@property (nonatomic) IBInspectable UIColor *bgEndColor;

//起点
@property (nonatomic) IBInspectable CGFloat startValueX;
//起点
@property (nonatomic) IBInspectable CGFloat startValueY;
//终点
@property (nonatomic) IBInspectable CGFloat endValueX;
//终点
@property (nonatomic) IBInspectable CGFloat endValueY;

@end

NS_ASSUME_NONNULL_END
