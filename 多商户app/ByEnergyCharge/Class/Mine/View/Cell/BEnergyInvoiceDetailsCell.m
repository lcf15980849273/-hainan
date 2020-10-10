//
//  BEnergyInvoiceDetailsCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/11.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceDetailsCell.h"

@interface BEnergyInvoiceDetailsCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation BEnergyInvoiceDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self byEnergyInitViews];
//        [self byEnergySetViewLayout];
//    }
//    return self;
//}

- (void)byEnergyInitViews {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.equalTo(weakself.titleLabel.mas_right).mas_offset(8);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-14);
    }];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    BEnergyStartChargeCellModel *model = (BEnergyStartChargeCellModel *)baseModel;
    self.titleLabel.text = model.title;
    self.contentLabel.text = byEnergyClearNilStr(model.value);
}


#pragma mark ----- LazyLoad
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#252525"];
        _titleLabel.font = ByEnergyRegularFont(14);
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _contentLabel.font = ByEnergyRegularFont(14);
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}

@end
