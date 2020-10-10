//
//  BEnergyMapCenterAnnotationView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/31.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyMapCenterAnnotationView.h"
#import <QuartzCore/QuartzCore.h>

#define kArrorHeight    5

@implementation BEnergyMapCenterAnnotationView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
    self.hintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.hintBtn setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#818181"] forState:UIControlStateNormal];
    self.hintBtn.titleLabel.font = ByEnergyRegularFont(13);
    self.hintBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:self.hintBtn];
}

- (void)layoutSubviews {
    [self.hintBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-8-kArrorHeight);
    }];
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect {
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context {
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1 green:1 blue:1 alpha:0.95].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context {
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
