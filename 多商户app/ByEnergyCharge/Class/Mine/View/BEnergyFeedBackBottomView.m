//
//  BEnergyFeedBackBottomView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyFeedBackBottomView.h"

@interface BEnergyFeedBackBottomView ()

@property (strong, nonatomic)UIButton *addFeedBackButton;
@property (strong, nonatomic)UIButton *soveButton;
@end
@implementation BEnergyFeedBackBottomView

- (void)byEnergyInitSubView {
    [self addSubview:self.addFeedBackButton];
    [self addSubview:self.soveButton];
    [self setViewShadowWithView:self.addFeedBackButton];
    [self setViewShadowWithView:self.soveButton];
    
    [self.addFeedBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(10);
        make.height.mas_offset(53);
    }];
    
    [self.soveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.addFeedBackButton.mas_bottom).offset(20);
        make.height.mas_offset(53);
    }];
}

- (void)setViewShadowWithView:(UIButton *)view {
    view.layer.cornerRadius = 5.0f;
    view.layer.shadowOffset = CGSizeMake(0, 2);
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowRadius = 5;
    view.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                             green:0.0f/255.0f
                                              blue:0.0f/255.0f
                                             alpha:0.1].CGColor;
}

#pragma mark ----- LazyLoad
- (UIButton *)addFeedBackButton {
    if (!_addFeedBackButton) {
        _addFeedBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addFeedBackButton setTitle:@"追加反馈" forState: UIControlStateNormal];
        _addFeedBackButton.backgroundColor = [UIColor whiteColor];
        _addFeedBackButton.titleLabel.font = ByEnergyRegularFont(17);
        _addFeedBackButton.adjustsImageWhenHighlighted = NO;
        [_addFeedBackButton setTitleColor:BYENERGYCOLOR(0x676767) forState:UIControlStateNormal];
        ByEnergyWeakSekf;
        [[[_addFeedBackButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf;
            if (self.showFeedBackPopViewBlock) {
                self.showFeedBackPopViewBlock();
            }
            
        }];
    }
    return _addFeedBackButton;
}

- (UIButton *)soveButton {
    if (!_soveButton) {
        _soveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_soveButton setTitle:@"已解决" forState: UIControlStateNormal];
        _soveButton.backgroundColor = [UIColor whiteColor];
        _soveButton.titleLabel.font = ByEnergyRegularFont(17);
        _soveButton.adjustsImageWhenHighlighted = NO;
        [_soveButton setTitleColor:BYENERGYCOLOR(0x676767) forState:UIControlStateNormal];
        ByEnergyWeakSekf;
        [[[_soveButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf;
            if (self.resoveFeedBackBlock) {
                self.resoveFeedBackBlock();
            }
            
        }];
    }
    return _soveButton;
}


@end
