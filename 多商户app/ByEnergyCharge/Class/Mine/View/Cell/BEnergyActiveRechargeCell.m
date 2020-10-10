//
//  BEnergyActiveRechargeCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/3.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyActiveRechargeCell.h"

@interface BEnergyActiveRechargeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UIImageView *selectIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *hasParticipateImageView;

@end
@implementation BEnergyActiveRechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = BYENERGYCOLOR(0x9e9e9e).CGColor;
}

- (void)setModel:(BEnergyActiveChargeModel *)model {
    _model = model;
     self.iconImageView.image = _model.isSelect ? IMAGEWITHNAME(@"aciconSelect") : IMAGEWITHNAME(@"aciconNomal");
    self.titleLabel.textColor = _model.isSelect ? BYENERGYCOLOR(0xff6b46) : BYENERGYCOLOR(0x9e9e9e);
    self.titleLabel.text = model.name;
    self.contentLabel.textColor = _model.isSelect ? BYENERGYCOLOR(0xff6b46) : BYENERGYCOLOR(0x9e9e9e);
    [self.detailButton setBackgroundImage:_model.isSelect ?  IMAGEWITHNAME(@"acDetailBackRed") : IMAGEWITHNAME(@"acDetailBack") forState:UIControlStateNormal];
    self.selectIconImageView.image = _model.isSelect ? IMAGEWITHNAME(@"accycleSelect") : IMAGEWITHNAME(@"accycleNomal");
    self.countLabel.text = _model.userRemainTimes;
    self.backView.layer.borderColor = _model.isSelect ? BYENERGYCOLOR(0xFF7552).CGColor : BYENERGYCOLOR(0x9e9e9e).CGColor;
    self.contentLabel.text = _model.info;
    self.countLabel.textColor = _model.isSelect ? BYENERGYCOLOR(0xff6b46) : BYENERGYCOLOR(0x9e9e9e);
    if (_model.joinFlag) { //可以参加
        self.hasParticipateImageView.hidden = YES;
        self.selectIconImageView.hidden = NO;
        self.countLabel.hidden = NO;
    }else { //不可参加
        self.hasParticipateImageView.hidden = NO;
        self.selectIconImageView.hidden = YES;
        self.countLabel.hidden = YES;
    }
}

- (IBAction)detailButtonClick:(UIButton *)sender {
    
    //@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=825371852,3089547542&fm=11&gp=0.jpg"

    if (self.model.h5RuleLink.length == 0) {
        [HUDManager showTextHud:@"暂无活动详情"];return;
    }

    
    ByEnergyBaseWebVc *vc = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:self.model.h5RuleLink
                                                                           title:@"活动详情"
                                                                         baseUrl:nil
                                                                          params:nil];
    vc.isElastic = NO;
    [ByEnergyTopVC.navigationController pushViewController:vc animated:YES];
}

@end
