//
//  BEnergyCustomAlertView.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BEnergyCustomAlertView.h"
@interface BEnergyCustomAlertView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttonsArray;
@property (nonatomic, strong) NSMutableArray<UIView *> *buttonsSplitLineArray;
@property (nonatomic, assign) NSTimeInterval autoDismissDelay;
@property (nonatomic, assign) NSTimeInterval lastShowTime;
@end

@implementation BEnergyCustomAlertView

#pragma mark - Overrides
- (void)dealloc {
    NSLog(@"BDAlertView[%@] dealloc", self.title);
}

- (void)byEnergyInitSubView {
    [super byEnergyInitSubView];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.frameView];
    [self.frameView addSubview:self.titleLabel];
    [self.frameView addSubview:self.detailLabel];
    [self.frameView addSubview:self.buttonsView];
    [self zm_performSelectorOnTapWithTarget:self
                                   selector:@selector(frameViewBackgroundDidTap:)
                             backgroundOnly:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) {
        self.frame = self.superview.bounds;
    }
    self.frameView.zm_width = 270.0f;
    [self layoutFrameView];
    self.frameView.zm_height = self.buttonsView.zm_bottom;
    self.frameView.zm_centerX = self.zm_halfWidth;
    self.frameView.zm_centerY = self.zm_halfHeight;
}

#pragma mark - Public Method
- (instancetype)initWithAlignment:(BDAlertViewAlignment)alignment
                            title:(NSString *)title
                           detail:(NSString *)detail
                buttonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray
                  operationAction:(BDAlertViewOperationBlock)operationAction
          dismissWhenTouchOutside:(BOOL)dismissWhenTouchOutside {
    self = [self initWithFrame:CGRectZero];
    self.alignment = alignment;
    self.title = title;
    self.detail = detail;
    self.buttonsTitleArray = buttonsTitleArray;
    self.operationAction = [operationAction copy];
    self.dismissWhenTouchOutside = dismissWhenTouchOutside;
    self.autoDismissDelay = 1;
    
    return self;
}

- (void)show {
    self.lastShowTime = [[NSDate date] timeIntervalSince1970];
    if (self.superview == [BEnergyCustomAlertView alertBackgroundView]) {
        return;
    }
    UIWindow *window = ByEnergyAppWindow;
    UIView *backgroundView = [BEnergyCustomAlertView alertBackgroundView];
    [window addSubview:backgroundView];
    [window bringSubviewToFront:backgroundView];
    backgroundView.frame = window.bounds;
    
    [backgroundView addSubview:self];
    [backgroundView bringSubviewToFront:self];
    self.frame = backgroundView.bounds;
    
    if (self.buttonsTitleArray.count == 0) {
        ByEnergyWeakSekf;
        [self hnByEnergyAfter:self.autoDismissDelay
                             action:^{
                                 ByEnergyStrongSelf;
                                 [self willAutoDismiss];
                             }];
    }
}

- (void)dismiss {
    [self removeFromSuperview];
    UIView *backgroundView = [BEnergyCustomAlertView alertBackgroundView];
    
    if (backgroundView.subviews.count == 0) {
        [backgroundView removeFromSuperview];
    }
}

+ (void)dismissAll {
    UIWindow *window = ByEnergyAppWindow;
    for (UIView *subview in window.subviews.copy) {
        if (subview == [self alertBackgroundView]) {
            for (UIView *v in subview.subviews.copy) {
                [v removeFromSuperview];
            }
            [subview removeFromSuperview];
            break;
        }
    }
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title
                           buttonArray:(NSArray<__kindof NSString *> *)buttons
                                 block:(BDAlertViewOperationBlock)block {
    return [self showAlertViewWithAlignment:BDAlertViewAlignmentDefault
                                      title:title
                                     detail:nil
                          buttonsTitleArray:buttons
                            operationAction:block
                    dismissWhenTouchOutside:YES];
}   


+ (instancetype)showAlertViewWithTitle:(NSString *)title
                                detail:(NSString *)detail
                     buttonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray
                       operationAction:(BDAlertViewOperationBlock)operationAction {
    
    return [self showAlertViewWithAlignment:BDAlertViewAlignmentDefault
                                      title:title
                                     detail:detail
                          buttonsTitleArray:buttonsTitleArray
                            operationAction:operationAction
                    dismissWhenTouchOutside:NO];
    
}

+ (instancetype)showAlertViewWithAlignment:(BDAlertViewAlignment)alignment
                                     title:(NSString *)title
                                    detail:(NSString *)detail
                         buttonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray
                           operationAction:(BDAlertViewOperationBlock)operationAction
                   dismissWhenTouchOutside:(BOOL)dismissWhenTouchOutside {
    
    return [self showAlertViewWithAlignment:alignment
                                      title:title
                                     detail:detail
                          buttonsTitleArray:buttonsTitleArray
                            operationAction:operationAction
                    dismissWhenTouchOutside:dismissWhenTouchOutside
                           autoDismissDelay:2];
}

+ (instancetype)showAlertViewWithAlignment:(BDAlertViewAlignment)alignment
                                     title:(NSString *)title
                                    detail:(NSString *)detail
                         buttonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray
                           operationAction:(BDAlertViewOperationBlock)operationAction
                   dismissWhenTouchOutside:(BOOL)dismissWhenTouchOutside
                          autoDismissDelay:(NSTimeInterval)autoDismissDelay {
    
    BEnergyCustomAlertView *view = nil;
    
    if (buttonsTitleArray.count == 0) {
        view = [self noOperationAlertView];
    }
    
    if (!view) {
        view = [[self alloc] initWithAlignment:alignment
                                         title:title
                                        detail:detail
                             buttonsTitleArray:buttonsTitleArray
                               operationAction:operationAction
                       dismissWhenTouchOutside:dismissWhenTouchOutside];
    }
    else {
        view.alignment = alignment;
        view.title = title;
        view.detail = detail;
        view.buttonsTitleArray = buttonsTitleArray;
        view.operationAction = [operationAction copy];
        view.dismissWhenTouchOutside = dismissWhenTouchOutside;
    }
    
    view.autoDismissDelay = autoDismissDelay;
    
    dispatch_main_async_safe(^{
        [view show];
    });
    
    return view;
}

+ (instancetype)showSuccessWithTitle:(NSString *)title {
    return [self showSuccessWithTitle:title delay:2];
}

+ (instancetype)showSuccessWithTitle:(NSString *)title delay:(NSTimeInterval)delay {
    return [self showAlertViewWithAlignment:BDAlertViewAlignmentDefault
                                      title:title
                                     detail:nil
                          buttonsTitleArray:nil
                            operationAction:nil
                    dismissWhenTouchOutside:YES
                           autoDismissDelay:delay];
}

+ (instancetype)showErrorWithTitle:(NSString *)title {
    return [self showErrorWithTitle:title delay:2];
}

+ (instancetype)showErrorWithTitle:(NSString *)title delay:(NSTimeInterval)delay {
    return [self showAlertViewWithAlignment:BDAlertViewAlignmentDefault
                                      title:title
                                     detail:nil
                          buttonsTitleArray:nil
                            operationAction:nil
                    dismissWhenTouchOutside:YES
                           autoDismissDelay:delay];
}

#pragma mark - Private Method

+ (instancetype)noOperationAlertView {
    static id _noOperationAlertView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _noOperationAlertView = [[self alloc] init];
    } );
    
    return _noOperationAlertView;
}

+ (UIView *)alertBackgroundView {
    static UIView *_alertBackgroundView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _alertBackgroundView = [[UIView alloc] init];
        _alertBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.65f];
    } );
    
    return _alertBackgroundView;
}

- (void)willAutoDismiss {
    NSTimeInterval showDuration = [[NSDate date] timeIntervalSince1970] - self.lastShowTime;
    if (showDuration >= self.autoDismissDelay) {
        [self dismiss];
    }
    else {
        ByEnergyWeakSekf;
        [self hnByEnergyAfter:(self.autoDismissDelay - showDuration)
                             action:^{
                                 ByEnergyStrongSelf;
                                 [self willAutoDismiss];
                             }];
    }
}

- (void)layoutFrameView {
    self.titleLabel.zm_top = 25.0;
    
    [self.titleLabel zm_layoutLeft:10.0f width:self.frameView.zm_width - 20.0f];
    [self.detailLabel zm_layoutLeft:20.0f width:self.frameView.zm_width - 40.0f];
    
    self.buttonsView.zm_left = 0.0f;
    self.buttonsView.zm_width = self.frameView.zm_width;
    
    CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font
                                               width:self.titleLabel.zm_width];
    self.titleLabel.zm_height = size.height;
    
    CGSize size2 = [self.detailLabel.text sizeWithFont:self.detailLabel.font
                                                 width:self.detailLabel.zm_width];
    self.detailLabel.zm_height = size2.height;
    
    self.detailLabel.zm_top = self.titleLabel.zm_bottom + 15;
    if (self.detail.length == 0) {
        self.detailLabel.zm_height = 0.0f;
        self.buttonsView.zm_top = self.detailLabel.zm_bottom + 10.0f;
    }
    else {
        self.buttonsView.zm_top = self.detailLabel.zm_bottom + 15;
    }
    
    if (self.buttonsTitleArray.count == 0) {
        self.buttonsView.zm_height = 0.0f;
    }
    else {
        self.buttonsView.zm_height = 50.0f;
    }
    
    [self layoutButtonsView];
}

- (void)layoutButtonsView {
    __block CGFloat buttonLeft = 0.0f;
    CGFloat buttonHeight = self.buttonsView.zm_height;
    CGFloat buttonWidth = self.buttonsView.zm_width / self.buttonsArray.count;
    [[self.buttonsArray copy] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        button.zm_top = 0.0f;
        button.zm_left = buttonLeft;
        button.zm_width = buttonWidth;
        button.zm_height = buttonHeight;
        
        if (idx > 0) {
            UIView *line = self.buttonsSplitLineArray[idx - 1];
            line.backgroundColor = APPGrayColor;
            line.zm_width = 0.5f;
            line.zm_height = buttonHeight;
            line.zm_centerX = button.zm_left;
            line.zm_centerY = button.zm_centerY;
        }
        
        buttonLeft += buttonWidth;
    }];
    
    [[self.buttonsSplitLineArray copy] enumerateObjectsUsingBlock:^(UIView *line, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.buttonsView bringSubviewToFront:line];
    }];
    
    UIView *topline = [[UIView alloc] init];
    topline.backgroundColor = APPGrayColor;
    [self.buttonsView addSubview:topline];
    topline.zm_height = 0.5;
    topline.zm_left = 0;
    topline.zm_top = 0;
    topline.zm_right = 0;
    [self.buttonsView bringSubviewToFront:topline];
}

#pragma mark - Actions

- (void)frameViewBackgroundDidTap:(id)sender {
    if (self.dismissWhenTouchOutside) {
        [self dismiss];
    }
}

#pragma mark - Setter Getter

- (void)setAlignment:(BDAlertViewAlignment)alignment {
    _alignment = alignment;
    
    switch (alignment) {
        case BDAlertViewAlignmentDefault:
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.detailLabel.textAlignment = NSTextAlignmentCenter;
            break;
            
        case BDAlertViewAlignmentLeft:
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            self.detailLabel.textAlignment = NSTextAlignmentLeft;
            break;
            
        case BDAlertViewTitleCenter:
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.detailLabel.textAlignment = NSTextAlignmentLeft;
        default:
            break;
    }
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
    self.titleLabel.font = ByEnergyRegularFont(16);
    [self setNeedsLayout];
}

- (void)setDetail:(NSString *)detail {
    _detail = [detail copy];
    self.detailLabel.text = detail;
    self.detailLabel.font = ByEnergyRegularFont(15);
    [self setNeedsLayout];
}

- (void)setSureBtnTitleColor:(UIColor *)sureBtnTitleColor {
    _sureBtnTitleColor = sureBtnTitleColor;
    self.buttonsTitleArray = self.buttonsTitleArray;
}

- (void)setOtherBtnTitleColor:(UIColor *)otherBtnTitleColor {
    _otherBtnTitleColor = otherBtnTitleColor;
    self.buttonsTitleArray = self.buttonsTitleArray;
}

- (void)setButtonsTitleArray:(NSArray<__kindof NSString *> *)buttonsTitleArray {
    _buttonsTitleArray = [buttonsTitleArray copy];
    
    [self.buttonsView vd_removeAllSubviews];
    [self.buttonsArray removeAllObjects];
    [self.buttonsSplitLineArray removeAllObjects];
    [[buttonsTitleArray copy] enumerateObjectsUsingBlock:^(NSString *buttonTitle, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.titleLabel.font = ByEnergyRegularFont(16);
        [button setTitleColor:self.otherBtnTitleColor ?: BYENERGYCOLOR(0x676767) forState:UIControlStateNormal];
        if (idx == 1) {
            [button setTitleColor:self.sureBtnTitleColor ?: BYENERGYCOLOR(0x333333) forState:UIControlStateNormal];
        }
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        
        button.layer.borderColor = APPGrayColor.CGColor;
        button.layer.borderWidth = 0.5f;
        ByEnergyWeakSekf;
        [button zm_controlTapAction:^(id sender) {
            ByEnergyStrongSelf;
            if (self.operationAction) {
                self.operationAction(self, idx);
            }
            
            if (!self.disableDismissWhenOperationButtonTap) {
                [self dismiss];
            }
        }];
        
        if (idx > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
            line.backgroundColor = APPTableSEPRATE;
            
            [self.buttonsSplitLineArray addObject:line];
            [self.buttonsView addSubview:line];
        }
        
        [self.buttonsArray addObject:button];
        [self.buttonsView addSubview:button];
    }];
    
    [self layoutButtonsView];
}

#pragma mark - Lazy Load

- (UIView *)frameView {
    if (!_frameView) {
        CGRect sketchFrame = CGRectZero;
        UIView *view = [[UIView alloc] initWithFrame:sketchFrame];
        
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        _frameView = view;
    }
    
    return _frameView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGRect sketchFrame = CGRectZero;
        UILabel *view = [[UILabel alloc] initWithFrame:sketchFrame];
        view.textColor = BYENERGYCOLOR(0x333333);
        view.font = ByEnergyRegularFont(16.0f);
        view.textAlignment = NSTextAlignmentCenter;
        view.numberOfLines = 0;
        _titleLabel = view;
    }
    
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        CGRect sketchFrame = CGRectZero;
        UILabel *view = [[UILabel alloc] initWithFrame:sketchFrame];
        view.textColor = BYENERGYCOLOR(0x333333);
        view.font = ByEnergyRegularFont(15.0f);
        view.textAlignment = NSTextAlignmentCenter;
        view.numberOfLines = 0;
        _detailLabel = view;
    }
    
    return _detailLabel;
}

- (UIView *)buttonsView {
    if (!_buttonsView) {
        CGRect sketchFrame = CGRectZero;
        UIView *view = [[UIView alloc] initWithFrame:sketchFrame];
        
        view.clipsToBounds = YES;
        
        _buttonsView = view;
    }
    
    return _buttonsView;
}

- (NSMutableArray<UIButton *> *)buttonsArray {
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray new];
    }
    
    return _buttonsArray;
}

- (NSMutableArray<UIView *> *)buttonsSplitLineArray {
    if (!_buttonsSplitLineArray) {
        _buttonsSplitLineArray = [NSMutableArray new];
    }
    
    return _buttonsSplitLineArray;
}

@end
