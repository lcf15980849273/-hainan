//
//  BEnergySystemNoticeListCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergySystemNoticeListCell.h"
@interface BEnergySystemNoticeListCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;

@end

@implementation BEnergySystemNoticeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(BEnergyNoticeCenterModel *)model {
    _model = model;
    self.timeLabel.text = _model.orderId;
    [self.noticeImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgUrl]];
}

@end
