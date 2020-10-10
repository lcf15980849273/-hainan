
//
//  BEnergyChargeOrderDetailsNumberCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/8/21.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargeOrderDetailsNumberCell.h"

@interface BEnergyChargeOrderDetailsNumberCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *copynumBtn;
@end

@implementation BEnergyChargeOrderDetailsNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)byEnergyInitViews {

    [self addSubview: _nameLabel];
    [self addSubview: _contentLabel];
    [[self.copynumBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.contentLabel.text;
        [HUDManager showStateHud:@"复制成功" state:HUDStateTypeSuccess];
    }];
    [self addSubview: self.copynumBtn];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.right.mas_lessThanOrEqualTo(weakself.contentLabel.mas_left);
    }];
    
    [self.copynumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(50);
        make.height.equalTo(weakself.mas_height).mas_offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.nameLabel.mas_centerY).mas_offset(0);
        make.left.mas_greaterThanOrEqualTo(weakself.nameLabel.mas_right);
        make.right.mas_equalTo(weakself.copynumBtn.mas_left).mas_offset(-3);
    }];
    
    [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    BEnergyStartChargeCellModel *model = (BEnergyStartChargeCellModel *)baseModel;
    self.nameLabel.text = byEnergyClearNilStr(model.title);
    self.contentLabel.text = NSStringFormat(@"%@%@",byEnergyClearNilStr(model.value),byEnergyClearNilStr(model.unit));
}

#pragma mark ----- LazyLaod
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = ByEnergyRegularFont(14);
        _nameLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#252525"];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = ByEnergyRegularFont(14);
        _contentLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}

- (UIButton *)copynumBtn {
    if (!_copynumBtn) {
        _copynumBtn = [[UIButton alloc] init];
        _copynumBtn.titleLabel.font = ByEnergyRegularFont(14);
        _copynumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_copynumBtn setTitle:@"复制" forState:UIControlStateNormal];
        [_copynumBtn setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#4EA6FF"] forState:UIControlStateNormal];
    }
    return _copynumBtn;
}
@end
