//
//  ByEnergyTextView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergyTextView.h"
#import "NSString+ByEnergyEmoji.h"
@interface ByEnergyTextView () <UITextViewDelegate>


@end

@implementation ByEnergyTextView

#pragma mark - Overrides
- (void)byEnergyInitSubView {
    [super byEnergyInitSubView];
    
    self.placeholderColor = [UIColor colorByEnergyWithBinaryString:@"#cccccc"];
    self.placeholderFont = ByEnergyRegularFont(15);
    self.inputTextView.font = ByEnergyRegularFont(15);
    
    [self addSubview:self.inputTextView];
    [self addSubview:self.placeholderTextView];
    [self addSubview:self.limitNumberLabel];
    
    
    RACSignal *signal = RACObserve(self.inputTextView, attributedText);
    [signal subscribeNext:^(id  _Nullable x) {
        [self updatePlaceholder];
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeholderTextView.frame = self.bounds;
    
    [self.limitNumberLabel sizeToFit];
    
    self.limitNumberLabel.width = self.limitNumberLabel.width + 10.0f;
    self.limitNumberLabel.height = 20.0f;
    
    self.inputTextView.width = self.width;
    
    self.limitNumberLabel.hidden = !self.showLimitNumberLabel;
    if (self.limitNumberLabel.hidden) {
        [self.inputTextView zm_layoutTop:0.0f height:self.height];
        self.inputTextView.centerY = self.height/2.0f;
    }
    else {
        [self.inputTextView zm_layoutTop:0.0f height:self.height - self.limitNumberLabel.height];
    }
    
    self.limitNumberLabel.right = self.width;
    self.limitNumberLabel.bottom = self.height;
    
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    if (delegate != self) {
        self.originalDelegate = delegate;
    }
    else {
        [self.inputTextView setDelegate:delegate];
    }
}

- (void)setText:(NSString *)text {
    [self.inputTextView setText:text];
    [self updatePlaceholder];
    [self updateLimitNumberLabel];
}

- (NSString *)text {
    return self.inputTextView.text;
}

#pragma mark - Private Method

- (void)updatePlaceholder {
    if (self.placeholder.length <= 0 ||
        self.inputTextView.text.length > 0) {
        self.placeholderTextView.hidden = YES;
        return;
    }
    
    self.placeholderTextView.hidden = NO;
    self.placeholderTextView.textColor = self.placeholderColor;
    self.placeholderTextView.font = self.placeholderFont;
    self.placeholderTextView.text = self.placeholder;
    [self setNeedsLayout];
}

- (void)updateLimitNumberLabel {
    if (self.showLimitNumberLabel && self.limitNumber > 0) {
        self.limitNumberLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.inputTextView.text.length, self.limitNumber];
    }
    else {
        self.limitNumberLabel.text = @"";
    }
    
    [self setNeedsLayout];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [self updatePlaceholder];
    [self updateLimitNumberLabel];
    
    if (self.textDidChangeAction) {
        self.textDidChangeAction(self.inputTextView, textView.text);
    }
    
    if ([self.originalDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.originalDelegate textViewDidChange:textView];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.forbidEmoji) {
        if (([text stringContainsEmoji] || [text hasEmoji]) && ![text isNineKeyBoard]) {// 现在输入表情
            [HUDManager showTextHud:@"不支持输入表情符"];
            return NO;
        }else {
            return YES;
        }
    }
    if (self.limitNumber > 0) {
        NSString *content = [textView.text stringByReplacingCharactersInRange:range withString:text];
        if (range.location > self.limitNumber || content.length > self.limitNumber) {
            self.text = [content substringToIndex:self.limitNumber];
            textView.text = self.text;
            if (self.textDidChangeAction) {
                self.textDidChangeAction(self.inputTextView, textView.text);
            }
            
            if ([self.originalDelegate respondsToSelector:@selector(textViewDidChange:)]) {
                [self.originalDelegate textViewDidChange:textView];
            }
            
            return NO;
        }
    }
    if ([self.originalDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.originalDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.originalDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.originalDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.originalDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.originalDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.originalDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        return [self.originalDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.originalDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        return [self.originalDelegate textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([self.originalDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        return [self.originalDelegate textViewDidChangeSelection:textView];
    }
}

#pragma mark - Setter Getter
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    [self updatePlaceholder];
    [self updateLimitNumberLabel];
}

- (void)setLimitNumber:(NSUInteger)limitNumber {
    _limitNumber = limitNumber;
    [self updateLimitNumberLabel];
}

- (void)setShowLimitNumberLabel:(BOOL)showLimitNumberLabel{
    _showLimitNumberLabel = showLimitNumberLabel;
    [self updateLimitNumberLabel];
}

- (UIFont *)placeholderFont {
    if (_placeholderFont) {
        return _placeholderFont;
    }
    
    if (self.inputTextView.font) {
        return self.inputTextView.font;
    }
    
    return ByEnergyRegularFont(14.0f);
}


-(void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self updatePlaceholder];
}

#pragma mark - Lazy Load

- (UITextView *)placeholderTextView {
    if (!_placeholderTextView) {
        UITextView *obj = [[UITextView alloc] initWithFrame:ScreenBounds];
        
        obj.backgroundColor = [UIColor clearColor];
        obj.userInteractionEnabled = NO;
        _placeholderTextView = obj;
    }
    
    return _placeholderTextView;
}

- (UITextView *)inputTextView {
    if (!_inputTextView) {
        UITextView *obj = [[UITextView alloc] initWithFrame:ScreenBounds];
        
        obj.backgroundColor = [UIColor clearColor];
        obj.delegate = self;
        _inputTextView = obj;
    }
    
    return _inputTextView;
}

- (UILabel *)limitNumberLabel {
    if (!_limitNumberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"";
        label.frame = CGRectZero;
        label.font = ByEnergyRegularFont(12.0f);
        label.textColor = [UIColor colorByEnergyWithBinaryString:@"#b1b1b1"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Menlo-Regular" size:12.0f]; // 等宽字体，避免数字变动时，label的大小不断变化
        //        label.backgroundColor = COLOR_BACKGROUND;
        
        _limitNumberLabel = label;
    }
    
    return _limitNumberLabel;
}

@end
