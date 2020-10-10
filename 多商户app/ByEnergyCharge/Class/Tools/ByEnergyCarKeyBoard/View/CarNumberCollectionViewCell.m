//
//  CarNumberCollectionViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "CarNumberCollectionViewCell.h"
#import "CarPlateNoKeyBoardView.h"
#import "CarKeyBoardViewModel.h"


#define kNomalColor  [UIColor colorByEnergyWithBinaryString:@"#D8D8D8"]
#define kSelectColor [UIColor colorByEnergyWithBinaryString:@"#00BFE5"]

@interface CarNumberCollectionViewCell ()<UITextFieldDelegate>
@property (nonatomic, strong) CarPlateNoKeyBoardView *keyBoardView;
@end

@implementation CarNumberCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
    }
    return self;
}

- (void)byEnergyInitViews {
    [self addSubview:self.textField];
}

- (void)byEnergySetViewLayout {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
}

- (UITextField *)textField {
    ByEnergyWeakSekf
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = [UIColor colorByEnergyWithBinaryString:@"#353535"];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.font = ByEnergyRegularFont(22);
        _textField.layer.borderWidth= 1.0f;
        _textField.layer.borderColor = [kNomalColor CGColor];
        ViewRadius(_textField, 8);
        _textField.delegate = self;
        [[_textField.rac_textSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * _Nullable x) {
            ByEnergyStrongSelf
            self.textField.textColor = [StringUtils isVaildsStr:x forRegex:@"[a-zA-Z]"]?[UIColor colorByEnergyWithBinaryString:@"#00bfe5"]:[UIColor colorByEnergyWithBinaryString:@"#353535"];
        }];
    }
    _textField.inputView = self.keyBoardView;
    return _textField;
}

- (void)changedTextField:(UITextField *)textField {
   textField.textColor = [StringUtils isVaildsStr:textField.text forRegex:@"[a-zA-Z]"]?[UIColor colorByEnergyWithBinaryString:@"#00bfe5"]:[UIColor colorByEnergyWithBinaryString:@"#353535"];
}


- (CarPlateNoKeyBoardView *)keyBoardView {
    if (!_keyBoardView) {
        _keyBoardView = [[CarPlateNoKeyBoardView alloc] init];
        __weak typeof(self) weakSelf = self;
        _keyBoardView.sc_keyboardEditing = ^(BOOL isDel, NSString * _Nonnull text) {
            NSInteger index;
            if (self.tag < 2) {
                index = self.tag;
            }else {
                index = self.tag-1;
            }
            NSString *string = [CarKeyBoardViewModel sc_regexPlateNo:text index:index maxCount:weakSelf.isNewEnergyCar?8:7
                                ];
            if (weakSelf.textFieldBlock) {
                weakSelf.textFieldBlock(string,weakSelf.tag,isDel);
            }
        };
    }
    return _keyBoardView;
}

- (void)fillCellContent:(NSString *)content isNewEnergyCar:(BOOL)isNewEnergyCar {
    self.isNewEnergyCar = isNewEnergyCar;
    self.textField.text = byEnergyClearNilStr(content);
    self.textField.textColor = [StringUtils isVaildsStr:content forRegex:@"[a-zA-Z]"]?[UIColor colorByEnergyWithBinaryString:@"#00bfe5"]:[UIColor colorByEnergyWithBinaryString:@"#353535"];
}

#pragma mark -----UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = kSelectColor.CGColor;
    self.keyBoardView.selectProvince = textField.text;
    [self.keyBoardView sc_changeKeyBoard:self.tag == 0?YES:NO];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.layer.borderColor = kNomalColor.CGColor;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textField.text = string;
    if (string.length > 0) {
        if (self.textFieldBlock) {
           self.textFieldBlock(string,self.tag,NO);
        }
        return YES;
    }
    return NO;
}

@end
