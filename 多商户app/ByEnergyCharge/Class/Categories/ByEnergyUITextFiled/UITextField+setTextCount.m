//
//  UITextField+setTextCount.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UITextField+setTextCount.h"

static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";
@implementation UITextField (setTextCount)


- (void)setTextCount:(int)length {
    
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey), [NSNumber numberWithInt:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey));
    int length = [lengthNumber intValue];
    if (textField.text.length > length) {
        UITextRange *markedRange = [textField markedTextRange];
        if (markedRange) {
            return;
        }
        //Emoji占2个字符，如果是超出了半个Emoji，用20位置来截取会出现Emoji截为2半
        //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
        NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:length];
        textField.text = [textField.text substringToIndex:range.location];
    }
}
@end
