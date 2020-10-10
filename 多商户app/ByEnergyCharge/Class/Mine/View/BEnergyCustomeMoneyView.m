//
//  BEnergyCustomeMoneyView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyCustomeMoneyView.h"

@interface BEnergyCustomeMoneyView ()
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BEnergyCustomeMoneyView

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
    [self addSubview:self.textField];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titleLabel.mas_bottom).mas_offset(8);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        ByEnergyStrongSelf
        if (x.length > 5) {
            [self.textField resignFirstResponder];
            [HUDManager showTextHud:@"输入字数不能超过5位！"];
            self.textField.text = [x substringWithRange:NSMakeRange(0, 5)];
        }
        [self.reChargeSubject sendNext:self.textField.text];
    }];
}

#pragma mark ----- LazyLoad
- (RACSubject *)reChargeSubject {
    if (_reChargeSubject == nil) {
        _reChargeSubject = [RACSubject subject];
    }
    return _reChargeSubject;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"自定义金额";
        _titleLabel.font = ByEnergyRegularFont(14);
        _titleLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#3E3E3E"];
    }
    return _titleLabel;
}

- (ByEnergyRechargeTextField *)textField {
    if (!_textField) {
        _textField = [[ByEnergyRechargeTextField alloc] init];
        _textField.font = ByEnergyRegularFont(14);
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.textColor = [UIColor colorByEnergyWithBinaryString:@"#353535"];
        _textField.layer.borderWidth = 1;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [UIColor colorByEnergyWithBinaryString:@"#E4E2E2"].CGColor;
        UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        unit.textAlignment = NSTextAlignmentCenter;
        unit.text = @"元";
        unit.textColor = [UIColor colorByEnergyWithBinaryString:@"#3E3E3E"];
        unit.font = ByEnergyRegularFont(16);
        _textField.leftView = unit;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F3F3F3"];
        _textField.attributedPlaceholder = [StringUtils setTextFieldPlacehoder:@"请输入自定义金额" Color:[UIColor colorByEnergyWithBinaryString:@"#C9C9C9"]];
    }
    return _textField;
}
@end
