//
//  XYNoDataView.m
//  XinYongXingQiu
//
//  Created by 刘辰峰 on 2020/3/22.
//  Copyright © 2020 夏立群. All rights reserved.
//

#import "XYNoDataView.h"

@implementation XYNoDataView
- (void)byEnergyInitSubView {
    [super byEnergyInitSubView];
    
    [self.wrapperView addSubview:self.noDataView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.noDataView.center = [self centerForSubviewInWrapperView];
    self.imageView.zm_centerX = self.noDataView.zm_halfWidth;
    self.button.frame = CGRectMake(self.noDataView.zm_width / 2 - 70.5, self.imageView.zm_bottom + 56.0f, 141.0f, 34.0f);
}

- (void)setNoDataTitle:(NSString *)noDataTitle {
    if (noDataTitle.length > 0) {
        self.titleLabel.text = noDataTitle;
    }
}


- (void)setNoDataSubTitle:(NSString *)noDataSubTitle {
    if (noDataSubTitle.length > 0) {
        self.subTitleLabel.text = noDataSubTitle;
    }
}

- (void)setNoDataImage:(NSString *)noDataImage {
//    if (noDataImage) {
//        _imageView.image = IMAGE_ANME(noDataImage);
//    }else {
//        _imageView.image = IMAGE_ANME(@"None");
//    }
//    [self setNeedsLayout];
}

- (void)setImageFrame:(CGRect)imageFrame {
    if (imageFrame.size.width > 0) {
        _imageView.frame = imageFrame;
        _titleLabel.frame = CGRectMake(0.0f, _imageView.zm_bottom + 15.0f, 290, 21.0f);
        _subTitleLabel.frame = CGRectMake(-0.0f, _titleLabel.zm_bottom + 10.0f, 290, 21.0f);
        
        [self setNeedsLayout];
    }
}

#pragma mark - Event

- (void)didClickBtn:(UIButton *)btn {
    if (self.didClickBtnBlock) {
        self.didClickBtnBlock(self.button);
    }
}

#pragma mark - Lazy Load

- (UIView *)noDataView {
    if (!_noDataView) {
        CGRect frame = CGRectMake(15.0f, 171.0f, 290.0f, 200.0f);
        UIView *obj = [[UIView alloc] initWithFrame:frame];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120, 120)];
//        _imageView.image = IMAGE_ANME(@"None");
        _imageView.zm_centerX = obj.zm_halfWidth;
        
//        _imageView.contentMode = UIViewContentModeCenter;
        
        [obj addSubview:_imageView];

        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, _imageView.zm_bottom + 15.0f, obj.zm_width, 21.0f)];
        _titleLabel.text = self.noDataTitle;
        _titleLabel.textColor = BYENERGYCOLOR(0xb1b1b1);
//        _titleLabel.font = ByEnergyRegularFont(15);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        [obj addSubview:_titleLabel];
        
        
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, _titleLabel.zm_bottom + 10.0f, obj.zm_width, 21.0f)];
        _subTitleLabel.text = self.noDataSubTitle;
        _subTitleLabel.textColor = BYENERGYCOLOR(0xb1b1b1);
//        _subTitleLabel.font = ByEnergyRegularFont(12);
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        [obj addSubview:_subTitleLabel];
        
        [self.button setTitle:self.buttonTitle forState:UIControlStateNormal];
        [obj addSubview:self.button];
        
        _noDataView = obj;
    }
    
    return _noDataView;
}


- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:self.buttonTitle forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _button.titleLabel.font = ByEnergyRegularFont(12);
        [_button addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.cornerRadius = 5;
        _button.layer.masksToBounds = YES;
        _button.layer.backgroundColor = BYENERGYCOLOR(0x40a5fb).CGColor;
        _button.hidden = YES;
    }
    return _button;
}


@end
