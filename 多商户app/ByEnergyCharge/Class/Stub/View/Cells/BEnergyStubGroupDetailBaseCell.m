//
//  BEnergyStubGroupDetailBaseCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubGroupDetailBaseCell.h"

@interface BEnergyStubGroupDetailBaseCell()
@property (nonatomic, strong) UILabel *byTitleLabel;
@property (nonatomic, strong) UILabel *byContentLabel;
@property (nonatomic, assign) BEnergyStubGroupDetailBaseCellType type;
@end

@implementation BEnergyStubGroupDetailBaseCell


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (instancetype)initWithType:(BEnergyStubGroupDetailBaseCellType)type reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super init]) {
        self.type = type;
        [self byEnergyInitViews];
    }
    return self;
}

- (void)byEnergyInitViews {
    kWeakSelf(self);
    [self addSubview:self.byTitleLabel];
    [self.byTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(12);
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.height.mas_offset(22);
    }];
    
    if (_type == BaseCellTypeForText) {
        [self addSubview:self.byContentLabel];
        [self.byContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.byTitleLabel.mas_bottom).mas_offset(8);
            make.left.mas_offset(20);
            make.right.mas_offset(-20);
            make.bottom.mas_offset(-16);
        }];
        
    }else {
        _byTitleLabel.text = @"支付平台";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"海控充电APP" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#FFAA36"] forState:UIControlStateNormal];
        [button setBackgroundImage:IMAGEWITHNAME(@"emphasize_StubDetail") forState:UIControlStateNormal];
        button.enabled = NO;
        button.titleLabel.font = ByEnergyRegularFont(14);
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.byTitleLabel.mas_bottom).mas_offset(13);
            make.left.mas_offset(20);
            make.size.mas_equalTo(CGSizeMake(91, 22));
        }];
    }
}

#pragma mark ----- LazyLoad
- (UILabel *)byTitleLabel {
    if (!_byTitleLabel) {
        _byTitleLabel = [[UILabel alloc] init];
        _byTitleLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#1D1D1D"];
        _byTitleLabel.font = ByEnergyRegularFont(16);
    }
    return _byTitleLabel;
}

- (UILabel *)byContentLabel {
    if (!_byContentLabel) {
        _byContentLabel = [[UILabel alloc] init];
        _byContentLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#787878"];
        _byContentLabel.font = ByEnergyRegularFont(14);
        _byContentLabel.numberOfLines = 0;
    }
    return _byContentLabel;
}


- (void)configUIWithTitle:(NSString *)title Content:(NSString *)content {
    self.byTitleLabel.text = byEnergyClearNilStr(title);
    self.byContentLabel.text = byEnergyClearNilStr(content);
}



@end
