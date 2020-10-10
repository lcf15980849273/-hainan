//
//  BEnergyMyCouponsTableViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyMyCouponsTableViewCell.h"
#import "BEnergyCouponsModel.h"

@interface BEnergyMyCouponsTableViewCell ()
@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeOutLabel;
@property (nonatomic, strong) UILabel *conditionLabel;
@property (nonatomic, strong) UILabel *scopeLabel;
@property (nonatomic, strong) UILabel *discountAmountLabel;
@property (nonatomic, strong) UIImageView *signImageView;
@end

@implementation BEnergyMyCouponsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)byEnergyInitViews {
    
    
    [self addSubview:self.bgImg];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeOutLabel];
    [self addSubview:self.conditionLabel];
    [self addSubview:self.scopeLabel];
    [self addSubview:self.discountAmountLabel];
    [self addSubview:self.signImageView];
}

- (void)byEnergySetViewLayout {
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(127);
    }];
    
    [self.discountAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.right.mas_equalTo(-40);
        make.size.mas_equalTo(CGSizeMake(80, 46));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(32);
        make.right.mas_equalTo(-32);
        make.height.mas_equalTo(22);
    }];
    
    [self.timeOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).mas_offset(6);
        make.left.mas_equalTo(32);
        make.right.equalTo(self.discountAmountLabel.mas_left).mas_offset(-6);
        make.height.mas_equalTo(14);
    }];
    
    [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeOutLabel.mas_bottom).mas_offset(3);
        make.left.mas_equalTo(32);
        make.right.equalTo(self.discountAmountLabel.mas_left).mas_offset(-6);
        make.height.mas_equalTo(14);
    }];
    
    [self.scopeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.conditionLabel.mas_bottom).mas_offset(3);
        make.left.mas_equalTo(32);
        make.right.equalTo(self.discountAmountLabel.mas_left).mas_offset(-6);
        make.height.mas_equalTo(14);
    }];
    
    [self.signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.equalTo(self).offset(180);
        make.height.width.mas_offset(50);
    }];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    __block BEnergyCouponsModel *model = (BEnergyCouponsModel *)baseModel;
    self.bgImg.image = self.status?IMAGEWITHNAME(@"bg_lose_MyCoupons"):IMAGEWITHNAME(@"bg_valid_MyCoupons");
    self.nameLabel.text = model.name;
    self.signImageView.hidden = !self.status;
    self.timeOutLabel.text = NSStringFormat(@"有效期至 %@",byEnergyClearNilStr(model.invalidTime));
    self.conditionLabel.text = NSStringFormat(@"使用条件：%@",byEnergyClearNilStr(model.useConditionDec));
    self.scopeLabel.text = NSStringFormat(@"使用范围：%@",byEnergyClearNilStr(model.useRangeDec));
    if (model.discountWay == 0) {
        self.discountAmountLabel.attributedText = [self getDiscountAmount:NSStringFormat(@"%@折",byEnergyClearNilStr(model.discountAmount))];
    }else {
        self.discountAmountLabel.text = NSStringFormat(@"¥%@",byEnergyClearNilStr(model.discountAmount));
    }
    [self.scopeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.useRangeHeight);
    }];
    
}

- (NSMutableAttributedString *)getDiscountAmount:(NSString *)discountAmount {
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:discountAmount];
    NSInteger location = [discountAmount rangeOfString:@"."].location;
    if (location != NSNotFound) {
        [attributed addAttribute:NSFontAttributeName value:ByEnergyRegularFont(15) range:NSMakeRange(location, discountAmount.length-location)];
    }else {
        [attributed addAttribute:NSFontAttributeName value:ByEnergyRegularFont(15) range:NSMakeRange(discountAmount.length-1, 1)];
    }
    return attributed;
}

#pragma mark ----- LazyLoad
- (UIImageView *)signImageView {
    if (!_signImageView) {
        _signImageView = [[UIImageView alloc] initWithImage:IMAGEWITHNAME(@"failureCoupon")];
    }
    return _signImageView;;
}

- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] init];
    }
    return _bgImg;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#4E4A4A"];
        _nameLabel.font = ByEnergyRegularFont(16);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [_nameLabel setFont:[FontFitTool FontWithType:FontTypeHel_Bold size:16]];
    }
    return _nameLabel;
}

- (UILabel *)timeOutLabel {
    if (!_timeOutLabel) {
        _timeOutLabel = [[UILabel alloc] init];
        _timeOutLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#4E4A4A"];
        _timeOutLabel.font = ByEnergyRegularFont(10);
        _timeOutLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeOutLabel;
}

- (UILabel *)conditionLabel {
    if (!_conditionLabel) {
        _conditionLabel = [[UILabel alloc] init];
        _conditionLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#4E4A4A"];
        _conditionLabel.font = ByEnergyRegularFont(10);
        _conditionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _conditionLabel;
}

- (UILabel *)scopeLabel {
    if (!_scopeLabel) {
        _scopeLabel = [[UILabel alloc] init];
        _scopeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#4E4A4A"];
        _scopeLabel.font = ByEnergyRegularFont(10);
        _scopeLabel.textAlignment = NSTextAlignmentLeft;
        _scopeLabel.numberOfLines = 0;
    }
    return _scopeLabel;
}

- (UILabel *)discountAmountLabel {
    if (!_discountAmountLabel) {
        _discountAmountLabel = [[UILabel alloc] init];
        _discountAmountLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#4E4A4A"];
        _discountAmountLabel.font = ByEnergyRegularFont(33);
        _discountAmountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _discountAmountLabel;
}
@end
