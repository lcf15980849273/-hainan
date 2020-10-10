//
//  BEnergyWalletDetailsCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyWalletDetailsCell.h"
#import "BEnergyUserAmountDetailModel.h"

@interface BEnergyWalletDetailsCell ()
@property (nonatomic, strong) UILabel *rechargeTLbl;
@property (nonatomic, strong) UILabel *rechargeCTLbl;
@property (nonatomic, strong) UILabel *rechargeTimeLbl;
@property (nonatomic, strong) UILabel *rechargeStatusLbl;
@end

@implementation BEnergyWalletDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)byEnergyInitViews {
    
    [self addSubview:self.rechargeTLbl];
    [self addSubview:self.rechargeCTLbl];
    [self addSubview:self.rechargeTimeLbl];
    [self addSubview:self.rechargeStatusLbl];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.rechargeTLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(21);
        make.right.equalTo(weakself.rechargeCTLbl.mas_left).mas_offset(-10);
        make.height.mas_equalTo(22);
    }];
    
    [self.rechargeCTLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.right.mas_equalTo(-21);
        make.left.equalTo(weakself.rechargeTLbl.mas_right).mas_offset(10);
        make.height.mas_equalTo(22);
    }];
    
    [self.rechargeTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.rechargeTLbl.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(21);
        make.right.equalTo(weakself.rechargeStatusLbl.mas_left).mas_offset(-10);
        make.height.mas_equalTo(17);
    }];
    
    [self.rechargeStatusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.rechargeCTLbl.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(-21);
        make.left.equalTo(weakself.rechargeTimeLbl.mas_right).mas_offset(10);
        make.height.mas_equalTo(17);
    }];
    [self.rechargeTimeLbl setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    BEnergyUserAmountDetailModel *model = (BEnergyUserAmountDetailModel *)baseModel;
    switch (model.type) {
        case 0:
            self.rechargeTLbl.text =  byEnergyClearNilReturnStr(model.typeNote, @"充电消费");
            self.rechargeStatusLbl.text = byEnergyClearNilStr(model.bank_description);
            self.rechargeCTLbl.text = NSStringFormat(@"-%0.2f",model.amount);
            self.rechargeCTLbl.textColor = [UIColor colorByEnergyWithBinaryString:@"#2F2F2F"];
            break;
        case 1:
            self.rechargeTLbl.text =  byEnergyClearNilReturnStr(model.typeNote, @"余额充值");
            self.rechargeStatusLbl.text = byEnergyClearNilStr(model.bank_description);
            self.rechargeCTLbl.text = NSStringFormat(@"+%0.2f",model.amount);
            self.rechargeCTLbl.textColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
            break;
        case 4:
            self.rechargeTLbl.text =  byEnergyClearNilStr(model.typeNote);
            self.rechargeStatusLbl.text = byEnergyClearNilStr(model.bank_description);
            self.rechargeCTLbl.text = NSStringFormat(@"-%0.2f",model.amount);
            self.rechargeCTLbl.textColor = [UIColor colorByEnergyWithBinaryString:@"#2F2F2F"];
            break;
        case 5:
            self.rechargeTLbl.text =  byEnergyClearNilStr(model.typeNote);
            self.rechargeStatusLbl.text = byEnergyClearNilStr(model.bank_description);
            self.rechargeCTLbl.text = NSStringFormat(@"+%0.2f",model.amount);
            self.rechargeCTLbl.textColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
            break;
        case 6:
            self.rechargeTLbl.text =  byEnergyClearNilStr(model.typeNote);
            self.rechargeStatusLbl.text = byEnergyClearNilStr(model.bank_description);
            self.rechargeCTLbl.text = NSStringFormat(@"+%0.2f",model.amount);
            self.rechargeCTLbl.textColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
            break;
        default:
            break;
    }
    self.rechargeTimeLbl.text = byEnergyClearNilStr(model.createTime);
}

#pragma mark ----- LazyLoad

- (UILabel *)rechargeTLbl {
    if (!_rechargeTLbl) {
        _rechargeTLbl = [[UILabel alloc] init];
        _rechargeTLbl.textColor = [UIColor colorByEnergyWithBinaryString:@"272727"];
        _rechargeTLbl.font = ByEnergyRegularFont(16);
    }
    return _rechargeTLbl;
}

- (UILabel *)rechargeCTLbl {
    if (!_rechargeCTLbl) {
        _rechargeCTLbl = [[UILabel alloc] init];
        _rechargeCTLbl.textColor = UIColor.byEnergyBlack;
        _rechargeCTLbl.font = ByEnergyRegularFont(16);
        _rechargeCTLbl.textAlignment = NSTextAlignmentRight;
    }
    return _rechargeCTLbl;
}

- (UILabel *)rechargeTimeLbl {
    if (!_rechargeTimeLbl) {
        _rechargeTimeLbl = [[UILabel alloc] init];
        _rechargeTimeLbl.textColor = [UIColor colorByEnergyWithBinaryString:@"#A3A3A3"];
        _rechargeTimeLbl.font = ByEnergyRegularFont(12);
    }
    return _rechargeTimeLbl;
}

- (UILabel *)rechargeStatusLbl {
    if (!_rechargeStatusLbl) {
        _rechargeStatusLbl = [[UILabel alloc] init];
        _rechargeStatusLbl.textColor = [UIColor colorByEnergyWithBinaryString:@"A3A3A3"];
        _rechargeStatusLbl.font = ByEnergyRegularFont(12);
        _rechargeStatusLbl.textAlignment = NSTextAlignmentRight;
    }
    return _rechargeStatusLbl;
}
@end
