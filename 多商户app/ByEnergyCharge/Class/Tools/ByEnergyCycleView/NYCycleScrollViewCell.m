//
//  NYCycleScrollViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/25.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "NYCycleScrollViewCell.h"
#import <AVFoundation/AVFoundation.h>

@implementation NYCycleScrollViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
-(void)layoutSubviews
{
    self.imageView.frame = self.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imageView.bounds cornerRadius:self.imgCornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    _imageView.layer.mask = maskLayer;
}

-(UIImageView *)imageView
{
    if(_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
@end
