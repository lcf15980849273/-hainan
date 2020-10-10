//
//  BEnergyInvoiceDetailsHeadCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/11.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceDetailsHeadCell.h"
#import "BEnergyInvoiceDetailsModel.h"

@interface BEnergyInvoiceDetailsHeadCell()
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *applyTimeLabel;
@property (nonatomic, strong) UILabel *finishTimeLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@end

@implementation BEnergyInvoiceDetailsHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

//- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self byEnergyInitViews];
//        [self byEnergySetViewLayout];
//    }
//    return self;
//}


- (void)byEnergyInitViews {
    
    [self addSubview:self.statusLabel];
    [self addSubview:self.orderLabel];
    [self addSubview:self.applyTimeLabel];
    [self addSubview:self.finishTimeLabel];
    [self addSubview:self.moneyLabel];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.equalTo(weakself.statusLabel.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(22);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.equalTo(weakself.moneyLabel.mas_left).mas_offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.statusLabel.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(17);
    }];
    
    [self.applyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.orderLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(17);
    }];
    
    [self.finishTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.applyTimeLabel.mas_bottom).mas_offset(7);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(17);
    }];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    BEnergyInvoiceDetailsModel *detailsModel = (BEnergyInvoiceDetailsModel *)baseModel;
    self.moneyLabel.text = NSStringFormat(@"%0.2f元",detailsModel.baseInfo.money);
    switch (detailsModel.baseInfo.status) {
        case 0:
            self.statusLabel.text = @"开票申请中，请您耐心等待";
            break;
        case 1:
            self.statusLabel.text = @"已开具发票";
            self.finishTimeLabel.text = NSStringFormat(@"开具成功日期：%@",byEnergyClearNilStr(detailsModel.baseInfo.invoiceUpdateTime));
            break;
        case 2:
            self.statusLabel.text = @"申请开票失败，请联系客服";
            break;
        default:
            self.statusLabel.text = @"申请开票失败，请联系客服";
            break;
    }
    self.orderLabel.text = NSStringFormat(@"发票订单号：%@",byEnergyClearNilStr(detailsModel.baseInfo.invoiceNum));
    self.applyTimeLabel.text = NSStringFormat(@"开具申请日期：%@",byEnergyClearNilStr(detailsModel.baseInfo.invoiceCreateTime));
    
}

#pragma mark ----- LazyLoad
- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#252525"];
        _statusLabel.font = ByEnergyRegularFont(16);
    }
    return _statusLabel;
}

- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _orderLabel.font = ByEnergyRegularFont(12);
    }
    return _orderLabel;
}

- (UILabel *)applyTimeLabel {
    if (!_applyTimeLabel) {
        _applyTimeLabel = [[UILabel alloc] init];
        _applyTimeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _applyTimeLabel.font = ByEnergyRegularFont(12);
    }
    return _applyTimeLabel;
}

- (UILabel *)finishTimeLabel {
    if (_finishTimeLabel) {
        _finishTimeLabel = [[UILabel alloc] init];
        _finishTimeLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _finishTimeLabel.font = ByEnergyRegularFont(12);
    }
    return _finishTimeLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#00D566"];
        _moneyLabel.font = ByEnergyRegularFont(18);
        _moneyLabel.adjustsFontSizeToFitWidth = YES;
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
}
@end
