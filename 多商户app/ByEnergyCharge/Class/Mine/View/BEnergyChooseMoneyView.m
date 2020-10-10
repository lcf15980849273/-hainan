//
//  BEnergyChooseMoneyView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChooseMoneyView.h"

#define BtnTagBase 100

@implementation BEnergyChooseMoneyView

- (instancetype)init {
    if (self = [super init]) {
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
    ByEnergyWeakSekf
    NSArray *numArray = @[@[@"10",@"20",@"50"],@[@"100",@"200",@"500"]];
    NSArray *array = [[[numArray rac_sequence] signal] map:^id _Nullable(id  _Nullable value) {
        NSArray *arr = (NSArray *)value;
        NSArray *btnArray = [arr.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = BtnTagBase + [value integerValue];
            [button setBackgroundImage:IMAGEWITHNAME(@"btn_amount_nor_Balance") forState:UIControlStateNormal];
            [button setBackgroundImage:IMAGEWITHNAME(@"btn_amount_selected_Balance") forState:UIControlStateSelected];
            [button setTitleColor:UIColor.byEnergyTextDefaultGray forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#00bfe5"] forState:UIControlStateSelected];
            [button setTitle:NSStringFormat(@"%@元",value) forState:UIControlStateNormal];
            button.titleLabel.font = ByEnergyRegularFont(14);
            ByEnergyStrongSelf
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                ByEnergyStrongSelf
                self.selectBtn.selected = NO;
                UIButton *sender = (UIButton *)x;
                sender.selected = YES;
                self.selectBtn = sender;
                [self.chooseSubject sendNext:@(button.tag - BtnTagBase)];
            }];
            [self addSubview:button];
            return button;
        }].toArray;
        return btnArray;
    }].toArray;
    
    CGFloat leadSpacing = 20;
    CGFloat tailSpacing = 20;
    CGFloat fixedSpacing = 12;
    [array[0] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                          withFixedSpacing:fixedSpacing
                               leadSpacing:leadSpacing
                               tailSpacing:tailSpacing];
    [array[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(48);
    }];
    
    [array[1] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                          withFixedSpacing:fixedSpacing
                               leadSpacing:leadSpacing
                               tailSpacing:tailSpacing];
    [array[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([array[0][0] mas_bottom]).mas_offset(15);
        make.height.mas_equalTo(48);
    }];
    
}

#pragma mark ----- LazyLoad
- (RACSubject *)chooseSubject {
    if (_chooseSubject == nil) {
        _chooseSubject = [RACSubject subject];
    }
    return _chooseSubject;
}

@end
