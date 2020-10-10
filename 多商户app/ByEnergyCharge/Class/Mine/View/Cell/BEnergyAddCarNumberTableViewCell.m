//
//  BEnergyAddCarNumberTableViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyAddCarNumberTableViewCell.h"

@interface BEnergyAddCarNumberTableViewCell ()
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation BEnergyAddCarNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.addCarBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-(self.addCarBtn.imageView.width+5))];
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.bgImageView];
    [self.contentView addSubview:self.addCarBtn];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2.5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-2.5);
    }];
    
    [self.addCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(146, 44));
        make.centerX.equalTo(weakself.mas_centerX).mas_offset(0);
    }];
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = IMAGEWITHNAME(@"PlateNo_BG_White");
    }
    return _bgImageView;
}

- (UIButton *)addCarBtn {
    if (!_addCarBtn) {
        _addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCarBtn setImage:IMAGEWITHNAME(@"PlateNo_Add") forState:UIControlStateNormal];
        [_addCarBtn setTitle:@"添加车牌号" forState:UIControlStateNormal];
        [_addCarBtn setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#00BFE5"] forState:UIControlStateNormal];
        _addCarBtn.adjustsImageWhenHighlighted = NO;
        _addCarBtn.titleLabel.font = ByEnergyRegularFont(18);
    }
    return _addCarBtn;
}
@end
