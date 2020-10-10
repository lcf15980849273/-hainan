//
//  CFProgressView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "CFProgressView.h"

@interface CFProgressView () {

}
@end

@implementation CFProgressView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    //默认进度条宽度
    self.progerWidth = 4;


    [self addSubview:self.stateLabel];
    [self addSubview:self.socLabel];
    
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-12);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.height.mas_offset(9);
    }];
    
    [self.socLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.stateLabel.mas_top).offset(-5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.height.mas_offset(10);
    }];
    
    
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    _socLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //路径
    UIBezierPath *backgroundPath = [[UIBezierPath alloc] init];
    //线宽
    backgroundPath.lineWidth = self.progerWidth;
    //颜色
    [self.progerssBackgroundColor set];
    //拐角
    backgroundPath.lineCapStyle = kCGLineCapRound;
    backgroundPath.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - self.progerWidth) * 0.5;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [backgroundPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2  clockwise:YES];
    //连线
    [backgroundPath stroke];
    //路径
    UIBezierPath *progressPath = [[UIBezierPath alloc] init];
    //线宽
    progressPath.lineWidth = self.progerWidth;
    //颜色
    [self.progerssColor set];
    //拐角
    progressPath.lineCapStyle = kCGLineCapRound;
    progressPath.lineJoinStyle = kCGLineJoinRound;

    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [progressPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * _progress clockwise:YES];
    //连线
    [progressPath stroke];
}

#pragma mark ----- LazyLoad
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = ByEnergyBoldFont(9);
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.text = @"充电中";
    }
    return _stateLabel;
}

- (UILabel *)socLabel {
    if (!_socLabel) {
        _socLabel = [[UILabel alloc] init];
        _socLabel.font = ByEnergyBoldFont(12);
        _socLabel.textAlignment = NSTextAlignmentCenter;
         _socLabel.text = @"79%";
    }
    return _socLabel;
}

@end
