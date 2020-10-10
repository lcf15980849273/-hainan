//
//  ByEnergyTextView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ByEnergyTextView : BEnergyBaseView

@property (nonatomic, strong) UITextView *placeholderTextView;
@property (nonatomic, strong) UITextView *inputTextView;
@property (nonatomic, strong) UILabel *limitNumberLabel;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) id  delegate;

//设置输入框占位文字
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeholderColor;

//设置输入框限制数量, 不大于0表示不限制
@property (nonatomic, assign) NSUInteger limitNumber;

//是否显示限制数字label
@property (nonatomic, assign, getter = isShowLimitNumberLabel) BOOL showLimitNumberLabel;
@property (nonatomic, copy) void(^textDidChangeAction)(__kindof UITextView *target, NSString *text);
@property (nonatomic, weak) id<UITextViewDelegate> originalDelegate;

//过滤
@property(nonatomic,assign)BOOL forbidEmoji;
//更新占位符
- (void)updatePlaceholder;
@end

NS_ASSUME_NONNULL_END
