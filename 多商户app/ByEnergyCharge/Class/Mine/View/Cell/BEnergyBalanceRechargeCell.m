//
//  BEnergyBalanceRechargeCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBalanceRechargeCell.h"

@interface BEnergyBalanceRechargeCell()
@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *ysfIconImageView;
@end


@implementation BEnergyBalanceRechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.typeImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.statusImageView];
    [self addSubview:self.ysfIconImageView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)byEnergySetViewLayout {
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [self.ysfIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.statusImageView.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(24, 18.5));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(self.typeImageView.mas_right).mas_offset(8);
        make.right.equalTo(self.statusImageView.mas_left).mas_offset(-10);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setModel:(RechargeModel *)model {
    _model = model;
    self.titleLabel.text = byEnergyClearNilStr(model.payTitle);
    self.typeImageView.image = IMAGEWITHNAME(byEnergyClearNilStr(model.imageName));
    if (model.selected) {
        self.statusImageView.image = IMAGEWITHNAME(@"check_selected_Balance");
    }else {
        self.statusImageView.image = IMAGEWITHNAME(@"check_selected_BalanceNomal");
    }
    
    if ([model.payKey isEqualToString:@"yunshanfu"]) {
        self.ysfIconImageView.hidden = NO;
    }else {
        self.ysfIconImageView.hidden = YES;
    }
}

#pragma mark ----- LazyLoad
- (UIImageView *)typeImageView {
    if (!_typeImageView) {
        _typeImageView = [[UIImageView alloc] init];
    }
    return _typeImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#3E3E3E"];
        _titleLabel.font = ByEnergyRegularFont(16);
    }
    return _titleLabel;
}

- (UIImageView *)statusImageView {
    if (!_statusImageView) {
        _statusImageView = [[UIImageView alloc] init];
        _statusImageView.image = IMAGEWITHNAME(@"select_nor_Balance");
    }
    return _statusImageView;
}

- (UIImageView *)ysfIconImageView {
    if (!_ysfIconImageView) {
        _ysfIconImageView = [[UIImageView alloc] init];
        _ysfIconImageView.image = IMAGEWITHNAME(@"unionPay");
    }
    return _ysfIconImageView;
}
@end

@implementation RechargeModel

@end
