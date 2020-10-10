//
//  coreGraphicsCustomView.m
//  byCF
//
//  Created by newyea on 2020/4/7.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import "coreGraphicsCustomView.h"

@implementation coreGraphicsCustomView

- (void)drawRect:(CGRect)rect {
    CGRect rectangle = CGRectMake(0, 0, 200, 200);
    //获取当前图形
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //添加区域到当前图形
    CGContextAddRect(ref, rectangle);
    
    //填充颜色
    CGContextSetFillColorWithColor(ref, [UIColor blueColor].CGColor);
    
    //绘制当前区域
    CGContextFillPath(ref);
    
}

- (void)pushWithDefalutView {
    
    
}
@end
