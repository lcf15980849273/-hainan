
//
//  StubGroupDetailIntegralCell.m
//  StarCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnegryStubDetailPriceCell.h"
#import "UIButton+Layout.h"
#import "RYCoverView.h"
@interface BEnegryStubDetailPriceCell ()

@property (nonatomic, strong) UIImageView *byIconImageView;// 当前时段文本
@property (nonatomic, strong) UILabel *byCurrentTimeText;// 当前时段
@property (nonatomic, strong) UILabel *byCurrentTimeLabel;// 总价
@property (nonatomic, strong) UILabel *byTotalFeeLabel;// 电费
@property (nonatomic, strong) UILabel *byElectricFeeLabel;// 服务费
@property (nonatomic, strong) UILabel *byServiceFeeLabel;

@end

@implementation BEnegryStubDetailPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.byIconImageView];
    [self addSubview:self.byCurrentTimeText];
    [self addSubview:self.byCurrentTimeLabel];
    [self addSubview:self.byTotalFeeLabel];
    [self addSubview:self.byElectricFeeLabel];
    [self addSubview:self.byServiceFeeLabel];
    [self addSubview:self.scheduleBtn];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ByEnergyWeakSekf
    [[self.scheduleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        [RYCoverView translucentBottomCoverFrom:ByEnergyAppWindow
                                        content:self.formView
                                       animated:YES
                                      showBlock:nil
                                      hideBlock:nil];
    }];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.byIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.byCurrentTimeLabel.mas_centerY).mas_offset(0);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.scheduleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [self.byCurrentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.equalTo(weakself.byCurrentTimeText.mas_right).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.byCurrentTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.equalTo(weakself.byIconImageView.mas_right).mas_offset(6);
        make.right.equalTo(weakself.byCurrentTimeLabel.mas_left).mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.byTotalFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.byCurrentTimeLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(25);
    }];

    [self.byElectricFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.byTotalFeeLabel.mas_bottom).mas_offset(6);
        make.left.mas_equalTo(20);
        make.right.equalTo(weakself.byServiceFeeLabel.mas_left).mas_offset(-18);
        make.height.mas_equalTo(20);
    }];
    
    [self.byServiceFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.byTotalFeeLabel.mas_bottom).mas_offset(6);
        make.left.equalTo(weakself.byElectricFeeLabel.mas_right).mas_offset(15);
        make.height.mas_equalTo(20);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scheduleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.scheduleBtn.titleLabel.right+5, 0, 0);
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    BEnergyStubGroupDetailModel *detailModel = (BEnergyStubGroupDetailModel *)baseModel;
    self.byCurrentTimeText.text = @"当前时段";
    self.byCurrentTimeLabel.text = byEnergyClearNilStr(detailModel.currentTime);
    self.byTotalFeeLabel.text = NSStringFormat(@"%0.2f元/度",detailModel.totalFee);
    self.byElectricFeeLabel.text = NSStringFormat(@"电费 %0.2f元/度",detailModel.electricFee);
    self.byServiceFeeLabel.text = NSStringFormat(@"服务费 %0.2f元/度",detailModel.serviceFee);
}


- (void)configUIWithPricedetailsModel:(Pricedetails *)model {
    self.byIconImageView.image = IMAGEWITHNAME(@"icon_point_StubDetail");
    self.scheduleBtn.hidden = YES;
    self.byCurrentTimeText.text = @"时间段";
    kWeakSelf(self);
    [self.byIconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    
    [self.byCurrentTimeText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.byIconImageView.mas_right).mas_offset(6);
    }];
    
    [self.scheduleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    
    self.byCurrentTimeLabel.textAlignment = NSTextAlignmentRight;
    self.byCurrentTimeLabel.text = byEnergyClearNilStr(model.priceTime);
    self.byTotalFeeLabel.text = NSStringFormat(@"%0.4f元/度",model.totalFee);
    self.byElectricFeeLabel.text = NSStringFormat(@"电费 %0.4f元/度",model.electricFee);
    self.byServiceFeeLabel.text = NSStringFormat(@"服务费 %0.4f元/度",model.serviceFee);
}


#pragma mark ----- LazyLoad
- (UIImageView *)byIconImageView {
    if (!_byIconImageView) {
        _byIconImageView = [[UIImageView alloc] init];
        _byIconImageView.image = IMAGEWITHNAME(@"icon_time_StubDetail");
    }
    return _byIconImageView;
}

- (UILabel *)byCurrentTimeText {
    if (!_byCurrentTimeText) {
        _byCurrentTimeText = [[UILabel alloc] init];
        _byCurrentTimeText.textColor = [UIColor colorByEnergyWithBinaryString:@"#212121"];
        _byCurrentTimeText.font = ByEnergyRegularFont(14);
        _byCurrentTimeText.textAlignment = NSTextAlignmentLeft;
    }
    return _byCurrentTimeText;
}

- (UILabel *)byCurrentTimeLabel {
    if (!_byCurrentTimeLabel) {
        _byCurrentTimeLabel = [[UILabel alloc] init];
        _byCurrentTimeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#212121"];
        _byCurrentTimeLabel.font = ByEnergyRegularFont(14);
        _byCurrentTimeLabel.textAlignment = NSTextAlignmentLeft;
        _byCurrentTimeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _byCurrentTimeLabel;
}

- (UILabel *)byTotalFeeLabel {
    if (!_byTotalFeeLabel) {
        _byTotalFeeLabel = [[UILabel alloc] init];
        _byTotalFeeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
        _byTotalFeeLabel.font = ByEnergyRegularFont(18);
        _byTotalFeeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byTotalFeeLabel;
}

- (UILabel *)byElectricFeeLabel {
    if (!_byElectricFeeLabel) {
        _byElectricFeeLabel = [[UILabel alloc] init];
        _byElectricFeeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#787878"];
        _byElectricFeeLabel.font = ByEnergyRegularFont(14);
        _byElectricFeeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byElectricFeeLabel;
}

- (UILabel *)byServiceFeeLabel {
    if (!_byServiceFeeLabel) {
        _byServiceFeeLabel = [[UILabel alloc] init];
        _byServiceFeeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#787878"];
        _byServiceFeeLabel.font = ByEnergyRegularFont(14);
        _byServiceFeeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byServiceFeeLabel;
}

- (UIButton *)scheduleBtn {
    if (!_scheduleBtn) {
        _scheduleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scheduleBtn setTitle:@"价格时间表" forState:UIControlStateNormal];
        [_scheduleBtn setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#0096D2"] forState:UIControlStateNormal];
        [_scheduleBtn setImage:IMAGEWITHNAME(@"icon_ahead_StubDetail") forState:UIControlStateNormal];
        _scheduleBtn.titleLabel.font = ByEnergyRegularFont(14);
        _scheduleBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _scheduleBtn;
}
@end
