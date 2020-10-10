//
//  BDProblemFeedbackCell.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDProblemFeedbackCell.h"

@interface BDProblemFeedbackCell ()

@property (weak, nonatomic) IBOutlet UILabel *suplierLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation BDProblemFeedbackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = APPGrayColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(BDProblemFeedbackModel *)model {
    _model = model;
    self.suplierLabel.text = model.goalName;
    self.typeLabel.text = model.typeContent;
//    self.timeLabel.text = [NSDate vd_stringWithformat:@"yyyy-MM-dd HH:mm" timeMillis:model.createTime];
    self.contentLabel.text = model.content;
}

@end
