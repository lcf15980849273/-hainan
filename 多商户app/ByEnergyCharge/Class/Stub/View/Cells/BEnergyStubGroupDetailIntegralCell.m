
//
//  BEnergyStubGroupDetailIntegralCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubGroupDetailIntegralCell.h"
#import "UIButton+Layout.h"
#import "RYCoverView.h"
@interface BEnergyStubGroupDetailIntegralCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *dqTimeTextLabel;// 当前时段文本
@property (nonatomic, strong) UILabel *dqTimeLabel;// 当前时段
@property (nonatomic, strong) UILabel *byTotalPriceLabel;// 总价
@property (nonatomic, strong) UILabel *byElectricPriceTitleLabel;
@property (nonatomic, strong) UILabel *byServicePriceTitleLabel;
@property (nonatomic, strong) UILabel *byElectricPriceLabel;// 电费
@property (nonatomic, strong) UILabel *byServicePriceLabel;// 服务费

@end

@implementation BEnergyStubGroupDetailIntegralCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.dqTimeTextLabel];
    [self addSubview:self.dqTimeLabel];
    [self addSubview:self.byTotalPriceLabel];
    [self addSubview:self.byElectricPriceLabel];
    [self addSubview:self.byServicePriceLabel];
    [self.contentView addSubview:self.scheduleBtn];
    [self addSubview:self.byElectricPriceTitleLabel];
    [self addSubview:self.byServicePriceTitleLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    ByEnergyWeakSekf
    [[self.scheduleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        [RYCoverView translucentBottomCoverFrom:ByEnergyAppWindow
                                        content:self.formView
                                       animated:YES
                                      showBlock:nil
                                      hideBlock:nil];
    }];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.dqTimeLabel.mas_centerY).mas_offset(0);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.scheduleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(73, 23));
    }];
    
    [self.dqTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.equalTo(weakself.dqTimeTextLabel.mas_right).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.dqTimeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.equalTo(weakself.iconImageView.mas_right).mas_offset(6);
        make.right.equalTo(weakself.dqTimeLabel.mas_left).mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.byTotalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.dqTimeLabel.mas_bottom).mas_offset(18);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(25);
    }];
    
    [self.byElectricPriceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.byTotalPriceLabel.mas_bottom).mas_offset(16);
        make.left.equalTo(self).mas_offset(20);
        make.height.mas_equalTo(13);
    }];
    
    [self.byServicePriceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.byElectricPriceLabel.mas_bottom).mas_offset(16);
        make.leading.equalTo(self.byElectricPriceTitleLabel);
        make.height.mas_equalTo(13);
    }];
    
    [self.byElectricPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.byElectricPriceTitleLabel);
        make.right.equalTo(self).mas_offset(-15);
        make.height.mas_equalTo(13);
    }];
    
    [self.byServicePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.byServicePriceTitleLabel);
        make.leading.equalTo(self.byElectricPriceLabel);
        make.height.mas_equalTo(13);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scheduleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.scheduleBtn.titleLabel.right+5, 0, 0);
}

#pragma mark ----- setter
- (void)setModel:(BEnergyStubGroupDetailModel *)model {
    _model = model;
    self.dqTimeTextLabel.text = @"当前时段";
    self.dqTimeLabel.text = byEnergyClearNilStr(_model.currentTime);
    self.byTotalPriceLabel.text = NSStringFormat(@"%0.4f元/度",_model.totalFee);
    self.byElectricPriceLabel.text = NSStringFormat(@"%0.4f元/度",_model.electricFee);
    self.byServicePriceLabel.text = NSStringFormat(@"%0.4f元/度",_model.serviceFee);
    
    NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:NSStringFormat(@"%.4f 元/度",_model.totalFee)];
    NSRange contentRange = [[totalStr string] rangeOfString:@"元/度"];
    [totalStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"#717171"] range:contentRange];
    [totalStr addAttribute:NSFontAttributeName value:ByEnergyRegularFont(12) range:contentRange];
    self.byTotalPriceLabel.attributedText = totalStr;
}


- (void)configUIWithPricedetailsModel:(Pricedetails *)model {
    self.iconImageView.image = IMAGEWITHNAME(@"icon_point_StubDetail");
    self.scheduleBtn.hidden = YES;
    self.dqTimeTextLabel.text = @"时间段";
    kWeakSelf(self);
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    
    [self.dqTimeTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.iconImageView.mas_right).mas_offset(6);
    }];
    
    [self.scheduleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    
    self.dqTimeLabel.textAlignment = NSTextAlignmentRight;
    self.dqTimeLabel.text = byEnergyClearNilStr(model.priceTime);
    self.byElectricPriceLabel.text = NSStringFormat(@"电费 %0.4f元/度",model.electricFee);
    self.byServicePriceLabel.text = NSStringFormat(@"服务费 %0.4f元/度",model.serviceFee);
    
    
}


#pragma mark ----- LazyLoad

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = IMAGEWITHNAME(@"icon_time_StubDetail");
    }
    return _iconImageView;
}

- (UILabel *)dqTimeTextLabel {
    if (!_dqTimeTextLabel) {
        _dqTimeTextLabel = [[UILabel alloc] init];
        _dqTimeTextLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#212121"];
        _dqTimeTextLabel.font = ByEnergyRegularFont(14);
        _dqTimeTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _dqTimeTextLabel;
}

- (UILabel *)dqTimeLabel {
    if (!_dqTimeLabel) {
        _dqTimeLabel = [[UILabel alloc] init];
        _dqTimeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#212121"];
        _dqTimeLabel.font = ByEnergyRegularFont(14);
        _dqTimeLabel.textAlignment = NSTextAlignmentLeft;
        _dqTimeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _dqTimeLabel;
}

- (UILabel *)byTotalPriceLabel {
    if (!_byTotalPriceLabel) {
        _byTotalPriceLabel = [[UILabel alloc] init];
        _byTotalPriceLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
        _byTotalPriceLabel.font = ByEnergyBoldFont(24);
        _byTotalPriceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byTotalPriceLabel;
}

- (UILabel *)byElectricPriceLabel {
    if (!_byElectricPriceLabel) {
        _byElectricPriceLabel = [[UILabel alloc] init];
        _byElectricPriceLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#787878"];
        _byElectricPriceLabel.font = ByEnergyRegularFont(14);
        _byElectricPriceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byElectricPriceLabel;
}

- (UILabel *)byServicePriceLabel {
    if (!_byServicePriceLabel) {
        _byServicePriceLabel = [[UILabel alloc] init];
        _byServicePriceLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#787878"];
        _byServicePriceLabel.font = ByEnergyRegularFont(14);
        _byServicePriceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byServicePriceLabel;
}

- (UIButton *)scheduleBtn {
    if (!_scheduleBtn) {
        _scheduleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scheduleBtn setTitle:@"价格详情" forState:UIControlStateNormal];
        _scheduleBtn.backgroundColor = BYENERGYCOLOR(0x00BFE5);
        _scheduleBtn.layer.cornerRadius = 11.5;
        _scheduleBtn.layer.masksToBounds = YES;
        [_scheduleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _scheduleBtn.titleLabel.font = ByEnergyRegularFont(13);
        _scheduleBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _scheduleBtn;
    
}

- (UILabel *)byElectricPriceTitleLabel {
    if (!_byElectricPriceTitleLabel) {
        _byElectricPriceTitleLabel = [[UILabel alloc] init];
        _byElectricPriceTitleLabel.font = ByEnergyRegularFont(14);
        _byElectricPriceTitleLabel.text = @"电费";
        _byElectricPriceTitleLabel.textColor = BYENERGYCOLOR(0x717171);
    }
    return _byElectricPriceTitleLabel;
}

- (UILabel *)byServicePriceTitleLabel {
    if (!_byServicePriceTitleLabel) {
        _byServicePriceTitleLabel = [[UILabel alloc] init];
        _byServicePriceTitleLabel.font = ByEnergyRegularFont(14);
        _byServicePriceTitleLabel.text = @"服务费";
        _byServicePriceTitleLabel.textColor = BYENERGYCOLOR(0x717171);
    }
    return _byServicePriceTitleLabel;
}
@end
