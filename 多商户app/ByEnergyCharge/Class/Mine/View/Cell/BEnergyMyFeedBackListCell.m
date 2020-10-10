//
//  BEnergyMyFeedBackListCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyMyFeedBackListCell.h"
@interface BEnergyMyFeedBackListCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation BEnergyMyFeedBackListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(BEnergyMyFeedBackListModel *)model {
    _model = model;
    self.timeLabel.text = _model.createTimeStr;
    self.iconImageView.hidden = _model.status == 3 ? NO : YES;
    self.titleLabel.text = [NSString stringWithFormat:@"%@:%@",_model.categoryTitle,_model.info];
}

@end
