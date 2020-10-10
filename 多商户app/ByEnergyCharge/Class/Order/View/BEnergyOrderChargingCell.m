//
//  BEnergyOrderChargingCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyOrderChargingCell.h"

@interface BEnergyOrderChargingCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stubNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chareTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation BEnergyOrderChargingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backView.layer.shadowOffset = CGSizeMake(0, 2);
    self.backView.layer.shadowOpacity = 1.0;
    self.backView.layer.shadowRadius = 2; //设置阴影的大小
    self.backView.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                                      green:0.0f/255.0f
                                                       blue:0.0f/255.0f
                                                      alpha:0.05].CGColor;
}

- (IBAction)stopChargingButtonClick:(UIButton *)sender {
    if (self.stopChargingBlock) {
        self.stopChargingBlock();
    }
}

- (void)setChargeListModel:(BEnergyChargeListModel *)chargeListModel {
    _chargeListModel = chargeListModel;
    self.stubNameLabel.text = byEnergyClearNilStr(_chargeListModel.stubGroupName);
    self.orderNumberLabel.text = byEnergyClearNilStr(_chargeListModel.orderId);
    self.timeLabel.text = byEnergyClearNilStr(_chargeListModel.createTime);
    self.chareTimeLabel.text = byEnergyClearNilStr(_chargeListModel.diffTime);
    
}
@end
