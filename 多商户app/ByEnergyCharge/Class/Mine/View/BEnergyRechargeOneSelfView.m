
//
//  BEnergyRechargeOneSelfView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyRechargeOneSelfView.h"
#import "UIButton+Layout.h"


@interface BEnergyRechargeOneSelfView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *balanceLabel;

@end

@implementation BEnergyRechargeOneSelfView

- (instancetype)init {
    if (self = [super init]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
        [self byEnergyInitViewModel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
        [self byEnergyInitViewModel];
    }
    return self;
}

- (void)byEnergyInitViews {
   
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconImage];
    [self addSubview:self.balanceLabel];
    [self addSubview:self.chooseView];
    [self addSubview:self.customeMoneyView];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(120, 37));
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titleLabel.mas_bottom).mas_offset(29);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titleLabel.mas_bottom).mas_offset(28);
        make.left.equalTo(weakself.iconImage.mas_right).mas_offset(4);
        make.right.equalTo(weakself).mas_offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    [self.chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.balanceLabel.mas_bottom).mas_offset(23);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(125);
    }];
    
    [self.customeMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.chooseView.mas_bottom).mas_offset(22);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [self.chooseView.chooseSubject subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [self.reChargeSubject sendNext:x];
        [StringUtils endEditedFromView:ByEnergyAppWindow];
        [self.customeMoneyView.textField endEditing:YES];
        self.customeMoneyView.textField.text = @"";
    }];
    
    [self.customeMoneyView.reChargeSubject subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        NSString *value = x;
        if (value.length > 0) {
            self.chooseView.selectBtn.selected = NO;
            [self.reChargeSubject sendNext:x];
        }
    }];
}

#pragma mark ----- LazyLoad
- (RACSubject *)reChargeSubject {
    if (!_reChargeSubject) {
        _reChargeSubject = [RACSubject subject];
    }
    return _reChargeSubject;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"余额充值";
        _titleLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#353535"];
        _titleLabel.font = ByEnergyRegularFont(26);
    }
    return _titleLabel;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = IMAGEWITHNAME(@"icon_balance_Balance");
    }
    return _iconImage;
}

- (UILabel *)balanceLabel {
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc] init];
        _balanceLabel.text = NSStringFormat(@"当前余额：%0.2f元",[[(BEnergyUserInfoModel *)[BEnergySCUserStorage sharedInstance].userInfo amount] floatValue]);
        _balanceLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#3E3E3E"];
        _balanceLabel.font = ByEnergyRegularFont(16);
    }
    return _balanceLabel;
}

- (BEnergyChooseMoneyView *)chooseView {
    if (!_chooseView) {
        _chooseView = [[BEnergyChooseMoneyView alloc] init];
    }
    return _chooseView;
}

- (BEnergyCustomeMoneyView *)customeMoneyView {
    if (!_customeMoneyView) {
        _customeMoneyView = [[BEnergyCustomeMoneyView alloc] init];
    }
    return _customeMoneyView;
}
@end
