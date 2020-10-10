//
//  BEnergyCarNumberTableViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyCarNumberTableViewCell.h"
#import "UIButton+HitRec.h"

@interface BEnergyCarNumberTableViewCell ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *defaultCarImageView;
@end

@implementation BEnergyCarNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.contentLabel];
    [self addSubview:self.moreBtn];
    [self addSubview:self.defaultCarImageView];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2.5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-2.5);
    }];
    
    [self.defaultCarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView).offset(5);
        make.right.equalTo(self.bgImageView).offset(-36);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY).mas_offset(0);
        make.right.equalTo(weakself.bgImageView.mas_right).mas_offset(-25);
        make.size.mas_equalTo(CGSizeMake(18, 4));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY).mas_offset(0);
        make.right.equalTo(weakself.moreBtn.mas_left).mas_offset(-5);
        make.left.mas_equalTo(63);
        make.height.mas_equalTo(36);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.moreBtn.hitEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -25);
}

#pragma mark ----- setter
- (void)setCarListModel:(BEnergyCarListModel *)carListModel {
    _carListModel = carListModel;
    self.contentLabel.text = _carListModel.carNumber;
    self.defaultCarImageView.hidden = !_carListModel.defaultFlag;
}


#pragma mark ----- LazyLoad

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = IMAGEWITHNAME(@"PlateNo_BG_Green");
    }
    return _bgImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = ByEnergyRegularFont(25);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setBackgroundImage:IMAGEWITHNAME(@"PlateNo_more") forState:UIControlStateNormal];
        _moreBtn.adjustsImageWhenHighlighted = NO;
    }
    return _moreBtn;
}

- (UIImageView *)defaultCarImageView {
    if (!_defaultCarImageView) {
        _defaultCarImageView = [[UIImageView alloc] init];
        _defaultCarImageView.image = IMAGEWITHNAME(@"DefalutCar");
    }
    return _defaultCarImageView;
}
@end
