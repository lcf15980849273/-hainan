//
//  BEnergyFeedBackHeaderView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyFeedBackHeaderView.h"

@implementation BEnergyFeedBackHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BYENERGYCOLOR(0xf7f7f7);
        [self addSubview:self.titleLab];
        [self addSubview:self.chooseLabel];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.centerY.equalTo(self);
        }];
        
        [self.chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab.mas_right).offset(5);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

#pragma mark ----- lazlyLaod

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = ByEnergyRegularFont(14);
        _titleLab.textColor = BYENERGYCOLOR(0x676767);
        _titleLab.text = @"请选择您的反馈问题类型";
    }
    return _titleLab;
    
}

- (UILabel *)chooseLabel {
    if (!_chooseLabel) {
        _chooseLabel = [UILabel new];
        _chooseLabel.font = ByEnergyRegularFont(14);
        _chooseLabel.textColor = BYENERGYCOLOR(0x00BFE5);
        _chooseLabel.text = @"(必选)";
    }
    return _chooseLabel;
    
}
@end
