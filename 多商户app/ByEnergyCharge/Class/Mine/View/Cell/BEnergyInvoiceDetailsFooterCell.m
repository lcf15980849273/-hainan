
//
//  BEnergyInvoiceDetailsFooterCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/11.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceDetailsFooterCell.h"
#import "BEnergyInvoiceDetailsModel.h"

@interface BEnergyInvoiceDetailsFooterCell()
@property (nonatomic, strong) UILabel *stubNameLabel;
@property (nonatomic, strong) UILabel *creatTimeLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@end


@implementation BEnergyInvoiceDetailsFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    
    ConsumInfoItem *consumInfoItemModel = (ConsumInfoItem *)baseModel;
    self.stubNameLabel.text = byEnergyClearNilStr(consumInfoItemModel.stubGroupName);
    self.creatTimeLabel.text = NSStringFormat(@"订单创建时间：%@",byEnergyClearNilStr(consumInfoItemModel.orderCreateTime));
    self.orderLabel.text = NSStringFormat(@"订单编号：%@",byEnergyClearNilStr(consumInfoItemModel.orderId));
    self.moneyLabel.text = NSStringFormat(@"%0.2f元",[consumInfoItemModel.orderPayAmount floatValue]);
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.stubNameLabel];
    [self addSubview:self.creatTimeLabel];
    [self addSubview:self.orderLabel];
    [self addSubview:self.moneyLabel];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.stubNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(20);
        make.right.equalTo(weakself.moneyLabel.mas_left).mas_offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    [self.creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.stubNameLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(20);
        make.right.equalTo(weakself.moneyLabel.mas_left).mas_offset(-10);
        make.height.mas_equalTo(17);
    }];
    
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.creatTimeLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(17);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.creatTimeLabel.mas_centerY).mas_offset(0);
        make.left.equalTo(weakself.creatTimeLabel.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(25);
    }];
}


#pragma mark ----- LazyLoad
- (UILabel *)stubNameLabel {
    if (!_stubNameLabel) {
        _stubNameLabel = [[UILabel alloc] init];
        _stubNameLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#252525"];
        _stubNameLabel.font = ByEnergyRegularFont(14);
    }
    return _stubNameLabel;
}

- (UILabel *)creatTimeLabel {
    if (!_creatTimeLabel) {
        _creatTimeLabel = [[UILabel alloc] init];
        _creatTimeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _creatTimeLabel.font = ByEnergyRegularFont(12);
    }
    return _creatTimeLabel;
}

- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _orderLabel.font = ByEnergyRegularFont(12);
    }
    return _orderLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#00D566"];
        _moneyLabel.font = ByEnergyRegularFont(18);
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}
@end
