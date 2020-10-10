//
//  BEnergyInvoiceSelectedCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceSelectedCell.h"
#import "BEnergyInvoiceSumChoiceModel.h"

@interface BEnergyInvoiceSelectedCell()
@property (nonatomic, strong) UILabel *stubNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView *statusImageView;
@end

@implementation BEnergyInvoiceSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)byEnergyInitViews {
    
    [self addSubview:self.stubNameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.orderLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.statusImageView];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    
    [self.stubNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(45);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(22);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.stubNameLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(45);
        make.right.equalTo(weakself.moneyLabel.mas_left).mas_offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.timeLabel.mas_bottom).mas_offset(4);
        make.left.mas_equalTo(45);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(22);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY).mas_offset(0);
        make.left.equalTo(weakself.timeLabel.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(22);
    }];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    BEnergyInvoiceSumChoiceModel *invoiceSumChoiceModel = (BEnergyInvoiceSumChoiceModel *)baseModel;
    self.stubNameLabel.text = byEnergyClearNilStr(invoiceSumChoiceModel.stubGroupName);
    self.orderLabel.text = NSStringFormat(@"订单编号：%@",byEnergyClearNilStr(invoiceSumChoiceModel.orderId));
    self.timeLabel.text = NSStringFormat(@"%@",byEnergyClearNilStr(invoiceSumChoiceModel.orderCreateTime));
    self.moneyLabel.text = NSStringFormat(@"%0.2f元",invoiceSumChoiceModel.orderPayAmount);
    self.statusImageView.image = IMAGEWITHNAME(invoiceSumChoiceModel.isSelected?@"check_selected_Invoice":@"check_select_nor_Invoice");
    
    if (invoiceSumChoiceModel.isSelected) {
        [self.statusImageView byEnergyViewWithAnimation:self.statusImageView];
    }
}

#pragma mark ----- LazyLoad
- (UILabel *)stubNameLabel {
    if (!_stubNameLabel) {
        _stubNameLabel = [[UILabel alloc] init];
        _stubNameLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#252525"];
        _stubNameLabel.font = ByEnergyRegularFont(16);
    }
    return _stubNameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#828282"];
        _timeLabel.font = ByEnergyRegularFont(12);
    }
    return _timeLabel;
}

- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#828282"];
        _orderLabel.font = ByEnergyRegularFont(12);
    }
    return _orderLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
        _moneyLabel.font = ByEnergyRegularFont(18);
    }
    return _moneyLabel;
}

- (UIImageView *)statusImageView {
    if (!_statusImageView) {
        _statusImageView = [[UIImageView alloc] init];
        _statusImageView.image = IMAGEWITHNAME(@"check_select_nor_Invoice");
    }
    return _statusImageView;
}
@end
