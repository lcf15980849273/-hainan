//
//  RecordListViewCell.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/5/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RecordListViewCell.h"

@interface RecordListViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleAmountLalbel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;

@end
@implementation RecordListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(RecordListModel *)model {
    _model = model;
    self.stateLabel.text  = _model.state;
    if ([_model.state isEqualToString:@""]) {
        self.stateLabel.textColor = BYENERGYCOLOR(0xf16f4c);
    }else {
        self.stateLabel.textColor = BYENERGYCOLOR(0x7d7c7c);
    }
    if (self.type == tableViewTypeLoan) {
        self.titleAmountLalbel.text = [NSString stringWithFormat:@"：%@元",_model.quota];
    }else {
        self.titleAmountLalbel.text = [NSString stringWithFormat:@"：%@元",_model.quota];
    }
    self.periodLabel.text = [NSString stringWithFormat:@":%@",_model.term];
//    self.timeLabel.text = [NSDate interverWithTimeInterval:model.time formatter:@"yyyy-MM-dd"];
}


@end
