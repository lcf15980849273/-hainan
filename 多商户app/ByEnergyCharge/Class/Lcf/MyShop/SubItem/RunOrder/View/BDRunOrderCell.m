//
//  BDProblemFeedbackCell.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDRunOrderCell.h"
//#import <ZXCategories/NSString+ZXSize.h>

@interface BDRunOrderCell ()



@property (weak, nonatomic) IBOutlet UILabel *suplierLabel;

@property (weak, nonatomic) IBOutlet UILabel *contactLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@end

@implementation BDRunOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = APPGrayColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark - Event


#pragma mark - Setter
- (void)setModel:(BDProblemFeedbackModel *)model {
    _model = model;
  
    
    self.suplierLabel.text = model.goalName;
    
//    self.timeLabel.text = [NSDate vd_stringWithformat:@"yyyy-MM-dd HH:mm" timeMillis:model.createTime];
    self.contentLabel.text = model.content;
  
    
}

@end
