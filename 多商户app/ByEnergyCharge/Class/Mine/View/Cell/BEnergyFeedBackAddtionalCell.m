//
//  BEnergyFeedBackAddtionalCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/7.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyFeedBackAddtionalCell.h"

@interface BEnergyFeedBackAddtionalCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelWidth;

@end

@implementation BEnergyFeedBackAddtionalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabelWidth.constant = SCREENWIDTH - 20 * 2;
    self.contentLabelWidth.constant = SCREENWIDTH - 20 * 2;
}


- (void)setModel:(BEnergyMyFeedBackListModel *)model {
    _model = model;
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",_model.categoryTitle,_model.categoryRemark];
    self.contentLabel.text = _model.info;
    self.timeLabel.text = _model.createTimeStr;
}
@end
