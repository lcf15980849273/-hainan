

//
//  BEnergyInvoiceDetailsItemCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/10.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceDetailsItemCell.h"
#import "BEnergyInvoiceSortModel.h"

@interface BEnergyInvoiceDetailsItemCell()
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *creatTimeLabel;
@property (nonatomic, strong) UILabel *failLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@end

@implementation BEnergyInvoiceDetailsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)byEnergyInitViews {
    
    [self addSubview:self.orderLabel];
    [self addSubview:self.creatTimeLabel];
    [self addSubview:self.failLabel];
    [self addSubview:self.moneyLabel];
    
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.equalTo(weakself.moneyLabel.mas_left).mas_offset(-5);
        make.height.mas_equalTo(22);
    }];
    
    [self.creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.orderLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(20);
        make.right.equalTo(weakself.moneyLabel.mas_left).mas_offset(-5);
        make.height.mas_equalTo(17);
    }];
    
    [self.failLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.creatTimeLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.equalTo(self.mas_bottom).mas_offset(-9);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.left.equalTo(weakself.creatTimeLabel.mas_right).mas_offset(5);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(25);
    }];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    BEnergyInvoiceSortModel *model = (BEnergyInvoiceSortModel *)baseModel;
    self.orderLabel.text = NSStringFormat(@"发票订单号：%@",byEnergyClearNilStr(model.invoiceNum));
    self.creatTimeLabel.text = NSStringFormat(@"申请时间：%@",byEnergyClearNilStr(model.invoiceCreateTime));
    self.moneyLabel.text = NSStringFormat(@"%0.2f元",model.money);
    if (model.statusType == 3) {
        self.failLabel.hidden = NO;
        self.failLabel.text = NSStringFormat(@"失败原因：%@",byEnergyClearNilReturnStr(model.failReason, @"无"));
        [self.orderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(9);
        }];
    }else {
        self.failLabel.hidden = YES;
    }
}

#pragma mark ----- LazyLoad
- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#252525"];
        _orderLabel.font = ByEnergyRegularFont(14);
        _orderLabel.text = @"";
    }
    return _orderLabel;
}

- (UILabel *)creatTimeLabel {
    if (!_creatTimeLabel) {
        _creatTimeLabel = [[UILabel alloc] init];
        _creatTimeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _creatTimeLabel.font = ByEnergyRegularFont(12);
        _creatTimeLabel.text = @"";
    }
    return _creatTimeLabel;
}

- (UILabel *)failLabel {
    if (!_failLabel) {
        _failLabel = [[UILabel alloc] init];
        _failLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _failLabel.font = ByEnergyRegularFont(12);
        _failLabel.text = @"";
    }
    return _failLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#00D566"];
        _moneyLabel.font = ByEnergyRegularFont(18);
        _moneyLabel.text = NSStringFormat(@"%@元",@"0");
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}
@end
