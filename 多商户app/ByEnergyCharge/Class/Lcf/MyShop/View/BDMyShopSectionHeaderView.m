//
//  BDMyShopSectionHeaderView.m
//  bydeal
//
//  Created by chenfeng on 2018/12/25.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDMyShopSectionHeaderView.h"
@interface BDMyShopSectionHeaderView ()
@property (nonatomic,strong) UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *onLineView;
@property (weak, nonatomic) IBOutlet UIView *waitOnlineView;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitOnlineLabel;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UIView *bussinessView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *busineseeNameLabel;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@end
@implementation BDMyShopSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"BDMyShopSectionHeaderView" owner:self options:nil]lastObject];
        [self addSubview:self.lineView];
        self.type = BDMyShopTableTypeOnline;
        [self viewTap];
    }
    return self;
}

- (void)viewTap {
    
    [self.onLineView zm_performActionOnTap:^(__kindof UIView *view) {
        self.type = BDMyShopTableTypeOnline;
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.zm_x = self.onLineView.zm_centerX - 15;
        }];
//        self.onlineLabel.font = BDSemiboldFont(15);
//        self.waitOnlineLabel.font = ByEnergyRegularFont(15);
        
        if ([self.delegate respondsToSelector:@selector(onLineViewTapWithType:)]) {
            [self.delegate onLineViewTapWithType:self.type];
        }
    }];
    
    [self.waitOnlineView zm_performActionOnTap:^(__kindof UIView *view) {
        self.type = BDMyShopTableTypeWaitOnline;
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.zm_x = self.waitOnlineView.zm_centerX - 15;
        }];
//        self.waitOnlineLabel.font = BDSemiboldFont(15);
//        self.onlineLabel.font = ByEnergyRegularFont(15);
        
        if ([self.delegate respondsToSelector:@selector(waitOnLineViewTapWithType:)]) {
            [self.delegate waitOnLineViewTapWithType:self.type];
        }
    }];
    
    [self.addressView zm_performActionOnTap:^(__kindof UIView *view) {
        if ([self.delegate respondsToSelector:@selector(addressViewTapWithType:)]) {
            [self.delegate addressViewTapWithType:self.type];
        }
    }];
    
    
    [self.typeView zm_performActionOnTap:^(__kindof UIView *view) {
        if ([self.delegate respondsToSelector:@selector(typeViewTapWithType:)]) {
            [self.delegate typeViewTapWithType:self.type];
        }
    }];
    
    
    [self.bussinessView zm_performActionOnTap:^(__kindof UIView *view) {
        if ([self.delegate respondsToSelector:@selector(bussinessViewTapWithType:)]) {
            [self.delegate bussinessViewTapWithType:self.type];
        }
    }];
    
    [self.searchView zm_performActionOnTap:^(__kindof UIView *view) {
        if ([self.delegate respondsToSelector:@selector(searchViewTapWithType:)]) {
            [self.delegate searchViewTapWithType:self.type];
        }
    }];
    
}

#pragma mark - setter
- (void)setParamModel:(BDMyShopParamModel *)paramModel {
    _paramModel = paramModel;
    self.cityLabel.text = _paramModel.city;
    self.typeLabel.text = _paramModel.typeName;
    self.busineseeNameLabel.text = _paramModel.businessName;
    self.onlineLabel.text = [NSString stringWithFormat:@"已上架(%ld)",(long)_paramModel.putNum];
    self.waitOnlineLabel.text = [NSString stringWithFormat:@"待上架(%ld)",(long)_paramModel.outNum];
}

#pragma mark - LazyLoad
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREENHEIGHT/4 - 15,87, 30, 2)];
        _lineView.backgroundColor = APPGrayColor;
    }
    return _lineView;
}
@end
