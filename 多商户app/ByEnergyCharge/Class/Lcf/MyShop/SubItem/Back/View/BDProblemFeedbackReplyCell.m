//
//  BDProblemFeedbackCell.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDProblemFeedbackReplyCell.h"
//#import <ZXCategories/NSString+ZXSize.h>

@interface BDProblemFeedbackReplyCell ()

@property (weak, nonatomic) IBOutlet UILabel *suplierLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyContentLabel;

@property (weak, nonatomic) IBOutlet UIButton *fullBtn;

@property (weak, nonatomic) IBOutlet UIButton *fullReplyBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fullContentBtnHCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fullReplyBtnHCons;

@end

@implementation BDProblemFeedbackReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = APPGrayColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark - Event

- (IBAction)didClickPhoneBtn:(UIButton *)sender {
    
}

- (IBAction)didClickMessageBtn:(UIButton *)sender {
    
}

- (IBAction)didClickFullBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.model.isOpen = sender.selected;
    if (self.clickFullBtnBlock) {
        self.clickFullBtnBlock(self);
    }
}

- (IBAction)didClickFullReplyBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.model.isOpenReplyContent = sender.selected;
    if (self.clickFullReplyBtnBlock) {
        self.clickFullReplyBtnBlock(self);
    }
}


#pragma mark - Setter
- (void)setModel:(BDProblemFeedbackModel *)model {
    _model = model;
    self.fullBtn.selected = model.isOpen;
    self.fullReplyBtn.selected = model.isOpenReplyContent;
    
    self.suplierLabel.text = model.goalName;
    self.typeLabel.text = model.typeContent;
//    self.timeLabel.text = [NSDate vd_stringWithformat:@"yyyy-MM-dd HH:mm" timeMillis:model.createTime];
    self.contentLabel.text = model.content;
//    self.replyTimeLabel.text = [NSDate vd_stringWithformat:@"yyyy-MM-dd HH:mm" timeMillis:model.replyTime];
    self.replyContentLabel.text = model.replyContent;
    
    self.contentLabel.numberOfLines = self.model.isOpen ? 0 : 2;
    
    CGSize size = CGSizeZero;
    self.fullBtn.hidden = size.height < ByEnergyRegularFont(15).lineHeight * 2 + 5;
    self.fullContentBtnHCons.constant = self.fullBtn.hidden ? 0 : 44;
    
    
    self.replyContentLabel.numberOfLines = self.model.isOpenReplyContent ? 0 : 2;
    CGSize replySize = CGSizeZero;
    self.fullReplyBtn.hidden = replySize.height < ByEnergyRegularFont(15).lineHeight * 2 + 5;
    
    self.fullReplyBtnHCons.constant = self.fullReplyBtn.hidden ? 10 : 44;
    
}

@end
