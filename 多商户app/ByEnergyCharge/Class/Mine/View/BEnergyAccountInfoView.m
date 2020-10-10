

//
//  BEnergyAccountInfoView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyAccountInfoView.h"
#import "BEnergyUserWalletBalanceModel.h"
#import "BEnergyApplyCashViewController.h"
@interface BEnergyAccountInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;//余额
@property (weak, nonatomic) IBOutlet UILabel *freezeAmountLab;//冻结金额
@property (weak, nonatomic) IBOutlet UILabel *activityAmount; //活动充值金额
@property (weak, nonatomic) IBOutlet UILabel *nomalAmount; //普通充值金额
@property (weak, nonatomic) IBOutlet UIButton *extractButton; //提现按钮
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, assign) BOOL change;
@end

@implementation BEnergyAccountInfoView

- (void)fillDataWithDataModel:(BEnergyBaseModel *)baseModel {
    self.bgImageView.image = IMAGEWITHNAME(@"bg_Wallet_big");
    BEnergyUserWalletBalanceModel *model = (BEnergyUserWalletBalanceModel *)baseModel;
    _amountLab.text = NSStringFormat(@"%0.2f",[model.totalAmount floatValue]);
    if (!byEnergyIsNilOrNull(model) && model.cashFreezingStatus == 0) { //有冻结金额
        self.freezeAmountLab.hidden = NO;
        self.arrowImageView.hidden = NO;
        self.freezeAmountLab.text = [NSString stringWithFormat:@"冻结金额:%@（提现申请中的金额为冻结金额）", byEnergyClearNilStr(model.freezingAmount)];
    }else {
        self.arrowImageView.hidden = YES;
        self.freezeAmountLab.hidden = YES;
        self.freezeAmountLab.text = @"";
    }
    
    self.activityAmount.text = [NSString stringWithFormat:@"活动充值金额:%@",model.giveAmount];
    self.nomalAmount.text = [NSString stringWithFormat:@"充值金额:%.2f",model.userAmount];
}

- (void)setModel:(BEnergySystemInfoModel *)model {
    _model = model;
    self.extractButton.hidden = [model.auth.cashStatus.value isEqualToString:@"1"] ? YES : NO;
    self.arrowImageView.hidden = [model.auth.cashStatus.value isEqualToString:@"1"] ? YES : NO;
}

- (IBAction)extractButtonClick:(UIButton *)sender {
    BEnergyApplyCashViewController *vc = [[BEnergyApplyCashViewController alloc] init];
    [ByEnergyTopVC.navigationController pushViewController:vc animated:YES];
}

@end
