//
//  BEnergyApplyCashFooterView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/4.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyApplyCashFooterView.h"

@interface BEnergyApplyCashFooterView ()
@property (nonatomic, strong) UIButton *submitBtn;


@end

@implementation BEnergyApplyCashFooterView

- (void)byEnergyInitSubView {
    [self addSubview:self.submitBtn];
    [self addSubview:self.textView];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.bottom.equalTo(self.mas_bottom).mas_offset(-11);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.equalTo(self.submitBtn.mas_top).mas_offset(-20);
    }];
}


#pragma mark ----- LazyLoad
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.adjustsImageWhenHighlighted = NO;
        [_submitBtn setBackgroundImage:IMAGEWITHNAME(@"chargingBtn") forState:UIControlStateNormal];
        [_submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = ByEnergyRegularFont(18);
        ByEnergyWeakSekf
        [[[_submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            if (self.submitButtonBlock) {
                self.submitButtonBlock();
            }
        }];
    }
    return _submitBtn;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor colorByEnergyWithBinaryString:@"#676767"];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = ByEnergyRegularFont(14);
        _textView.editable = NO;
        _textView.userInteractionEnabled = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
    }
    return _textView;
}
@end
