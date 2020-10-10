//
//  BEnergyChargeOrderDetailsCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/15.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargeOrderDetailsCell.h"

@interface BEnergyChargeOrderDetailsCell ()
@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, strong) UIImageView *arrowImg;
@end

@implementation BEnergyChargeOrderDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)byEnergyInitViews {
    
    [self addSubview: _nameLabel];
    [self addSubview: _contentLabel];
    [self addSubview: self.typeBtn];
    self.arrowImg = [[UIImageView alloc] init];
    [self addSubview:self.arrowImg];
    
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.right.mas_lessThanOrEqualTo(weakself.contentLabel.mas_left);
    }];
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.nameLabel.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(9, 6));
        make.right.mas_equalTo(-20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.nameLabel.mas_centerY).mas_offset(0);
        make.left.mas_greaterThanOrEqualTo(weakself.nameLabel.mas_right);
        make.right.mas_equalTo(weakself.arrowImg.mas_left).mas_offset(-3);
    }];
    
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.nameLabel.mas_centerY).mas_offset(0);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(70, 25));
    }];
    
    [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    BEnergyStartChargeCellModel *model = (BEnergyStartChargeCellModel *)baseModel;
    self.nameLabel.text = byEnergyClearNilStr(model.title);
    self.contentLabel.text = NSStringFormat(@"%@%@",byEnergyClearNilStr(model.value),byEnergyClearNilStr(model.unit));
    if ([model.displayValue floatValue]) {
        self.contentLabel.font = [FontFitTool FontWithType:FontTypeHN_Medium size:[model.displayValue floatValue]];
    }else {
        self.contentLabel.font = ByEnergyRegularFont(14);
    }
    if (model.cellType == ByEnergyChargeCellType_PIC) {
        [self.typeBtn setTitle:byEnergyClearNilStr(model.value) forState:UIControlStateNormal];
    }
    if (model.isArrowImg) {
        self.arrowImg.hidden = NO;
        self.arrowImg.image = IMAGEWITHNAME(model.displayValue);
    }else {
        self.arrowImg.hidden = YES;
        [self.arrowImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-8);
        }];
    }
    self.typeBtn.hidden = model.cellType == ByEnergyChargeCellType_PIC?NO:YES;
    self.contentLabel.hidden = model.cellType == ByEnergyChargeCellType_PIC?YES:NO;
}

#pragma mark ----- LazyLoad
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
        _contentLabel.hidden = YES;
    }
    return _contentLabel;
}

- (UIButton *)typeBtn {
    if (!_typeBtn) {
        _typeBtn = [[UIButton alloc] init];
        [_typeBtn setBackgroundImage:IMAGEWITHNAME(@"emphasize_OrdereDetails") forState:UIControlStateNormal];
        _typeBtn.titleLabel.font = ByEnergyRegularFont(14);
        [_typeBtn setTitleColor:[UIColor colorByEnergyWithBinaryString:@"FFAA36"] forState:UIControlStateNormal];
        _typeBtn.adjustsImageWhenHighlighted = NO;
        _typeBtn.hidden = YES;
    }
    return _typeBtn;
}
@end
