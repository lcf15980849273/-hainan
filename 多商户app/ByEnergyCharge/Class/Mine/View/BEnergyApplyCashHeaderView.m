//
//  BEnergyApplyCashHeaderView.m
//  StarCharge
//
//  Created by newyea on 2020/8/22.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyApplyCashHeaderView.h"
#import "UIButton+Layout.h"


@interface BEnergyApplyCashHeaderView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *byTitleLabel;
@property (nonatomic, strong) UIImageView *byIconImageView;
@property (nonatomic, strong) UILabel *byAmountLabel;
@property (nonatomic, strong) UIButton *byApplyAllBtn;
@property (nonatomic, assign) BOOL isHaveDian;
@end

@implementation BEnergyApplyCashHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
    }
    return self;
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.byTitleLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.byIconImageView];
    [self addSubview:self.byAmountLabel];
    [self addSubview:self.byApplyAllBtn];
    [self addSubview:self.textField];
}

- (void)byEnergySetViewLayout {
    [self.byTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(120, 37));
    }];
    
    [self.byIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byTitleLabel.mas_bottom).mas_offset(29);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.byApplyAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byTitleLabel.mas_bottom).mas_offset(29);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    [self.byAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byTitleLabel.mas_bottom).mas_offset(28);
        make.left.equalTo(self.byIconImageView.mas_right).mas_offset(4);
        make.right.equalTo(self.byApplyAllBtn.mas_left).mas_offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byAmountLabel.mas_bottom).mas_offset(18);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(44);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).mas_offset(15);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(20);
    }];
    
}

- (void)setAmount:(NSString *)amount {
    _amount = amount;
    self.byAmountLabel.text = NSStringFormat(@"当前余额：%0.2f元", [_amount floatValue]);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.byApplyAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.byApplyAllBtn.titleLabel.right + 5, 0, 0);
}

#pragma mark ----- UITextFieldDelegate
/**
 *  textField的代理方法，监听textField的文字改变
 *  textField.text是当前输入字符之前的textField中的text
 *
 *  @param textField textField
 *  @param range     当前光标的位置
 *  @param string    当前输入的字符
 *
 *  @return 是否允许改变
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            [HUDManager showTextHud:@"您的输入格式不正确"];
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
            [HUDManager showTextHud:@"最多只能输入一个小数点"];
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    [HUDManager showTextHud:@"第二个字符需要是小数点"];
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    [HUDManager showTextHud:@"第二个字符需要是小数点"];
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                    [HUDManager showTextHud:@"最多输入小数点后两位"];
                    return NO;
                }
            }
        }
    }
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:textField.text];
    [mutableString insertString:string atIndex:range.location];
    if ([mutableString floatValue] > [self.amount floatValue]) {
        [HUDManager showTextHud:@"提现金额不能超过当前余额!"];
        return NO;
    }
    return YES;
}

#pragma mark ----- LazyLoad
- (UILabel *)byTitleLabel {
    if (!_byTitleLabel) {
        _byTitleLabel = [[UILabel alloc] init];
        _byTitleLabel.text = @"提现申请";
        _byTitleLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#353535"];
        _byTitleLabel.font = ByEnergyRegularFont(26);
    }
    return _byTitleLabel;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#FFAA36"];
        _tipsLabel.font = ByEnergyRegularFont(13);
    }
    return _tipsLabel;
}

- (UIImageView *)byIconImageView {
    if (!_byIconImageView) {
        _byIconImageView = [[UIImageView alloc] init];
        _byIconImageView.image = IMAGEWITHNAME(@"icon_balance_Balance");
    }
    return _byIconImageView;
}

- (UILabel *)byAmountLabel {
    if (!_byAmountLabel) {
        _byAmountLabel = [[UILabel alloc] init];
        _byAmountLabel.text = NSStringFormat(@"当前余额：%0.2f元",[[(BEnergyUserInfoModel *)[BEnergySCUserStorage sharedInstance].userInfo amount] floatValue]);
        _byAmountLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#3E3E3E"];
        _byAmountLabel.font = ByEnergyRegularFont(16);
    }
    return _byAmountLabel;
}

- (UIButton *)byApplyAllBtn {
    if (!_byApplyAllBtn) {
        
        _byApplyAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _byApplyAllBtn.adjustsImageWhenHighlighted = NO;
        [_byApplyAllBtn setTitle:@"全部提现" forState:UIControlStateNormal];
        [_byApplyAllBtn setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#0096D2"] forState:UIControlStateNormal];
        [_byApplyAllBtn setImage:IMAGEWITHNAME(@"btn_ahead_Balance") forState:UIControlStateNormal];
        _byApplyAllBtn.titleLabel.font = ByEnergyRegularFont(14);
        _byApplyAllBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        ByEnergyWeakSekf
        [[_byApplyAllBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            self.textField.text = self.amount;
        }];
    }
    return _byApplyAllBtn;
}

- (ByEnergyRechargeTextField *)textField {
    if (!_textField) {
        _textField = [[ByEnergyRechargeTextField alloc] init];
        _textField.font = ByEnergyRegularFont(14);
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.textColor = [UIColor colorByEnergyWithBinaryString:@"#353535"];
        _textField.layer.borderWidth = 1;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.layer.borderColor = [UIColor colorByEnergyWithBinaryString:@"#E4E2E2"].CGColor;
        UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        unit.textAlignment = NSTextAlignmentCenter;
        unit.text = @"元";
        unit.textColor = [UIColor colorByEnergyWithBinaryString:@"#3E3E3E"];
        unit.font = ByEnergyRegularFont(14);
        _textField.leftView = unit;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F3F3F3"];
        _textField.attributedPlaceholder = [StringUtils setTextFieldPlacehoder:@"请输入提现金额" Color:[UIColor colorByEnergyWithBinaryString:@"#C9C9C9"]];
        _textField.delegate = self;
    }
    return _textField;
}

@end
