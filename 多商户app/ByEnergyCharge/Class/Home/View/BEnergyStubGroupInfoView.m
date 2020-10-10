//
//  BEnergyStubGroupInfoView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubGroupInfoView.h"
#import "BEnergyStubGroupModel.h"
#import "StringForUnit.h"

@interface BEnergyStubGroupInfoView ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *byTitleLabel;
@property (nonatomic, strong) UILabel *byContentLabel;
@property (nonatomic, strong) UILabel *byDistanceLabel;
@property (nonatomic, strong) UILabel *byStubInfoLabel;

@end

@implementation BEnergyStubGroupInfoView

- (instancetype)init {
    if (self = [super init]) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer)]];
        [self byEnergyInitViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self byEnergyInitViews];
    }
    return self;
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.byTitleLabel];
    [self addSubview:self.byContentLabel];
    [self addSubview:self.byDistanceLabel];
    [self addSubview:self.loactionBtn];
    [self addSubview:self.byStubInfoLabel];
    [self byEnergySetViewLayout];
}

- (void)byEnergySetViewLayout {
    
    [self.byTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(20);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.loactionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    
    [self.byDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loactionBtn.mas_bottom).mas_offset(-10);
        make.centerX.equalTo(self.loactionBtn);
        make.height.mas_equalTo(17);
    }];
    
    [self.byContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(20);
         make.right.mas_offset(-15);
         make.top.equalTo(self.byStubInfoLabel.mas_bottom).offset(8);
         make.height.mas_equalTo(28);
     }];
    
    [self.byStubInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-10);
    }];
    
}


- (void)gestureRecognizer {
    [self.detailSubject sendNext:self.stubGroup];
}

- (void)fillDataWithDataModel:(BEnergyBaseModel *)baseModel {
    self.stubGroup = (BEnergyStubGroupModel *)baseModel;
    if (byEnergyIsValidStr(_stubGroup.name)) {
        self.byTitleLabel.height = _stubGroup.nameSize.height;
    }
    self.byTitleLabel.text = byEnergyClearNilStr(_stubGroup.name);
    self.byDistanceLabel.text = [StringForUnit getKmStrWithMeter:_stubGroup.distance unitStr:@"km"];
    
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:NSStringFormat(@"%.4f 元/度   ",_stubGroup.totalFee)];
    NSRange contentRange = [[contentStr string] rangeOfString:@"元/度"];
    NSRange moneyRange = [[contentStr string] rangeOfString:NSStringFormat(@"%.4f",_stubGroup.totalFee)];
    [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"00BFE5"] range:contentRange];
    [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"00BFE5"] range:moneyRange];
    [contentStr addAttribute:NSFontAttributeName value:ByEnergyRegularFont(12) range:contentRange];
    [contentStr addAttribute:NSFontAttributeName value:ByEnergyRegularFont(24) range:moneyRange];
    self.byContentLabel.attributedText = contentStr;
    

    NSMutableAttributedString *stubInfoStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"快充: 闲%d/共%d ｜ 慢充: 闲%d/共%d",_stubGroup.stubDcIdleCnt,_stubGroup.stubDcCnt,_stubGroup.stubAcIdleCnt,_stubGroup.stubAcCnt]];
    
    NSRange fastStubRange = [[stubInfoStr string] rangeOfString:[NSString stringWithFormat:@"%d",_stubGroup.stubDcIdleCnt]];
     NSRange flowStubRange = NSMakeRange(15 + [NSString stringWithFormat:@"%d",_stubGroup.stubDcIdleCnt].length + [NSString stringWithFormat:@"%d",_stubGroup.stubDcCnt].length, [NSString stringWithFormat:@"%d",_stubGroup.stubAcIdleCnt].length);
    [stubInfoStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"ff9c15"] range:fastStubRange];
    [stubInfoStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"ff9c15"] range:flowStubRange];
    self.byStubInfoLabel.attributedText = stubInfoStr;

}


#pragma mark ----- LazyLoad

- (RACSubject *)detailSubject {
    if (!_detailSubject) {
        _detailSubject = [RACSubject subject];
    }
    return _detailSubject;
}

- (RACSubject *)updataHeightSubject {
    if (!_updataHeightSubject) {
        _updataHeightSubject = [RACSubject subject];
    }
    return _updataHeightSubject;
}

- (UILabel *)byStubInfoLabel {
    if (!_byStubInfoLabel) {
        _byStubInfoLabel = [[UILabel alloc] init];
        _byStubInfoLabel.font = ByEnergyRegularFont(13);
        _byStubInfoLabel.textColor = BYENERGYCOLOR(0xb5b5b5);
    }
    return _byStubInfoLabel;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = IMAGEWITHNAME(@"bg_details_2");
    }
    return _bgImageView;
}

- (UILabel *)byTitleLabel {
    if (!_byTitleLabel) {
        _byTitleLabel = [[UILabel alloc] init];
        _byTitleLabel.textColor = UIColor.byEnergyBlack;
        _byTitleLabel.font = ByEnergyBoldFont(20);
        _byTitleLabel.textAlignment = NSTextAlignmentLeft;
        _byTitleLabel.numberOfLines = 0;
    }
    return _byTitleLabel;
}

- (UILabel *)byContentLabel {
    if (!_byContentLabel) {
        _byContentLabel = [[UILabel alloc] init];
        _byContentLabel.textColor = UIColor.byEnergyGreen;
        _byContentLabel.font = ByEnergyBoldFont(20);
        _byContentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byContentLabel;
}

- (UILabel *)byDistanceLabel {
    if (!_byDistanceLabel) {
        _byDistanceLabel = [[UILabel alloc] init];
        _byDistanceLabel.textColor = UIColor.byEnergyGray;
        _byDistanceLabel.font = ByEnergyRegularFont(12);
        _byDistanceLabel.textAlignment = NSTextAlignmentLeft;
        _byDistanceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _byDistanceLabel;
}

- (UIButton *)loactionBtn {
    if (!_loactionBtn) {
        _loactionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loactionBtn.userInteractionEnabled = NO;
        [_loactionBtn setImage:IMAGEWITHNAME(@"homeNavIcon") forState:UIControlStateNormal];
    }
    return _loactionBtn;
}

@end
