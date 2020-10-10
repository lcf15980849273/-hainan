//
//  BEnergyActivityCenterListCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyActivityCenterListCell.h"
@interface BEnergyActivityCenterListCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;
@property (weak, nonatomic) IBOutlet UILabel *acTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *acContentLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end
@implementation BEnergyActivityCenterListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.shadowOffset = CGSizeMake(0, 2);
    self.bgView.layer.shadowOpacity = 1.0;
    self.bgView.layer.shadowRadius = 5;
    self.bgView.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                             green:0.0f/255.0f
                                              blue:0.0f/255.0f
                                             alpha:0.1].CGColor;
}

- (void)setModel:(BEnergyNoticeCenterModel *)model {
    _model = model;
    self.timeLabel.text = _model.orderId;
    [self.noticeImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
    self.acTitleLabel.text = _model.title;
    self.acContentLabel.text = _model.info;
    
}

@end
