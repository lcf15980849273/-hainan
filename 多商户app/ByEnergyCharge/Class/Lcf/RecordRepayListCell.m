//
//  RecordRepayListCell.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RecordRepayListCell.h"

@interface RecordRepayListCell ()
@property (weak, nonatomic) IBOutlet UILabel *repayAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
@implementation RecordRepayListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setModel:(RecordListModel *)model {
    _model = model;
    
    self.stateLabel.text  = _model.state;
//    self.timeLabel.text = [NSDate interverWithTimeInterval:model.time formatter:@"yyyy-MM-dd"];
    self.repayAmountLabel.text = [NSString stringWithFormat:@"%@元",[NSString doubleReplaceWithNumber:_model.amount]];
}

@end
