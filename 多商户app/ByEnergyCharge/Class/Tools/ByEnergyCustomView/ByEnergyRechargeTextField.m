//
//  ByEnergyRechargeTextField.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyRechargeTextField.h"

@implementation ByEnergyRechargeTextField
//文本框 显示 时的 位置 及 显示范围
- (CGRect)textRectForBounds:(CGRect)bounds{
    //    return CGRectInset(bounds, -10, 0);
    CGRect rect = [super textRectForBounds:bounds];
    return CGRectMake(0, rect.origin.y, self.width - 50, rect.size.height);
}

//文本框 编辑 时的 位置 及 显示范围
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    return CGRectMake(0, rect.origin.y, self.width - 65 , rect.size.height);
}

//文本框 清除按钮 的 位置 及 显示范围
- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    return CGRectOffset(rect, -37, 0);
}

//文本框 左视图 的 位置 及 显示范围
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];
    return CGRectOffset(rect, self.width-40, 0);
}


@end
