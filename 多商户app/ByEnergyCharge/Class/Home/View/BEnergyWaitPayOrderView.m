//
//  BEnergyWaitPayOrderView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/12.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyWaitPayOrderView.h"
#import "BEnergyChargeListModel.h"

@interface BEnergyWaitPayOrderView ()
/*桩群名称*/
@property (weak, nonatomic) IBOutlet UILabel *stubNameLabel;
/*订单编号*/
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
/*合计消费*/
@property (weak, nonatomic) IBOutlet UILabel *chargeMoneyLabel;
/*充电时间*/
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
/*充电时长*/
@property (weak, nonatomic) IBOutlet UILabel *timeDiffLabel;
@end

@implementation BEnergyWaitPayOrderView



- (IBAction)submit:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitPay)]) {
        [_delegate submitPay];
    }
}
- (IBAction)closeHandler:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(closeView)]) {
        [_delegate closeView];
    }
}

- (void)fillDataWithDataModel:(BEnergyBaseModel *)baseModel {
    BEnergyChargeListModel *model = (BEnergyChargeListModel *)baseModel;
    self.stubNameLabel.text = byEnergyClearNilStr(model.stubGroupName);
    self.orderNumberLabel.text = byEnergyClearNilStr(model.orderId);
    self.creatTimeLabel.text = byEnergyClearNilStr(model.createTime);
    self.timeDiffLabel.text = byEnergyClearNilStr(model.diffTime);
    self.chargeMoneyLabel.text = NSStringFormat(@"¥%0.2f",model.fee);
}

@end
