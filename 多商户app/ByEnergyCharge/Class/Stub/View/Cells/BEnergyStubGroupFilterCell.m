
//
//  BEnergyStubGroupFilterCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/15.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubGroupFilterCell.h"

#define FilterBtnTag 10

@interface BEnergyStubGroupFilterCell()
@property (nonatomic, copy) NSString *byTitle;
@property (nonatomic, strong) NSArray *BtnDataArray;
@property (nonatomic, strong) BEnergyStartChargeCellModel *model;
@end

@implementation BEnergyStubGroupFilterCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStartChargeCellModel:(BEnergyStartChargeCellModel *)model {
    if (self = [super init]) {
        self.byTitle = model.title;
        self.BtnDataArray = model.arrayValue;
        self.model = model;
        [self initDataViews];
    }
    return self;
}

- (void)initDataViews {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = byEnergyClearNilStr(self.byTitle);
    label.textColor = BYENERGYCOLOR(0xa3a3a3);
    label.font = ByEnergyRegularFont(12);
    [self addSubview:label];
    
    NSMutableArray *btnArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.BtnDataArray.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:IMAGEWITHNAME(@"btn_select_selected_StubList") forState:UIControlStateSelected];
        [button setBackgroundImage:IMAGEWITHNAME(@"btn_select_nor_StubList") forState:UIControlStateNormal];
        [button setTitleColor:UIColor.byEnergyBlack forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#01CF4B"] forState:UIControlStateSelected];
        [button setTitle:byEnergyClearNilStr(self.BtnDataArray[i]) forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        button.tag = i + FilterBtnTag;
        button.adjustsImageWhenHighlighted = NO;
        ByEnergyWeakSekf
        [[[button rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            UIButton *sender = (UIButton *)x;
            if (!sender.selected) {
                int index = (int)[sender tag] - FilterBtnTag;
                if (index < self.BtnDataArray.count) {
                    for (UIView *view in self.subviews) {
                        if ([view isKindOfClass:[UIButton class]]) {
                            [(UIButton *)view setSelected:(view.tag - FilterBtnTag) == index];
                        }
                    }
                }
                [self.selectSubject sendNext:@(index)];
            }else {
                sender.selected = !sender.selected;
                [self.selectSubject sendNext:@(0)];
            }
            
        }];
        if (byEnergyIsValidStr(self.BtnDataArray[i])) {
            [self addSubview:button];
            [btnArray addObject:button];
        }
    }
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    CGFloat spacing = (SCREENWIDTH - 90 - 108 * btnArray.count - 10 * (btnArray.count - 1));
    
    if (self.BtnDataArray.count > 2) {
        [[btnArray copy] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                  withFixedItemLength:108
                                          leadSpacing:90
                                          tailSpacing:spacing];
    }else {
        [[btnArray copy] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(90);
            make.width.mas_offset(108);
        }];
    }
    

    [[btnArray copy] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.mas_equalTo(30);
    }];
}

- (void)configUIWithSelectedIndex:(int)index {
    if (index < self.BtnDataArray.count) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                [(UIButton *)view setSelected:(view.tag - FilterBtnTag) == index];
            }
        }
    }
}

#pragma mark ----- LazyLoad
- (RACSubject *)selectSubject {
    if (!_selectSubject) {
        _selectSubject = [RACSubject subject];
    }
    return _selectSubject;
}

@end
