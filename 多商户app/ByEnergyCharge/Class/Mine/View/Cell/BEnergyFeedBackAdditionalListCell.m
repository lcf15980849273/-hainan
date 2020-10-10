//
//  BEnergyFeedBackAdditionalListCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/7.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyFeedBackAdditionalListCell.h"

@interface BEnergyFeedBackAdditionalListCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelWidth;


@end

@implementation BEnergyFeedBackAdditionalListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabelWidth.constant = SCREENWIDTH - 20 * 2;
}

- (void)setModel:(ListModel *)model {
    _model = model;
    self.timeLabel.text = _model.createTimeStr;
    self.contentLabel.attributedText = [self attributeStringWith:_model.info];
    
}

- (NSMutableAttributedString *)attributeStringWith:(NSString *)score {
    NSString *str = [NSString stringWithFormat:@"%@: %@",self.model.logType == 1 ? self.model.nickName : @"小叶客服回复",self.model.info];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = self.model.logType == 1 ? NSMakeRange(0, self.model.nickName.length + 2) : NSMakeRange(0, 8);
    [ats setAttributes:@{NSFontAttributeName : ByEnergyRegularFont(14),
                         NSForegroundColorAttributeName: self.model.logType == 1 ? BYENERGYCOLOR(0x676767) : BYENERGYCOLOR(0x00BFE5)} range:range];
    [ats setAttributes:@{NSFontAttributeName : ByEnergyRegularFont(14),
                         NSForegroundColorAttributeName:BYENERGYCOLOR(0x676767)} range:NSMakeRange( self.model.logType == 1 ? self.model.nickName.length + 2 : 8, score.length)];
    
    return ats;
}
@end
