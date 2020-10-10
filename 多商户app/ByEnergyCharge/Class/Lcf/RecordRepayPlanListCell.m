//
//  RecordRepayPlanListCell.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RecordRepayPlanListCell.h"

@interface RecordRepayPlanListCell ()
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;//期
@property (weak, nonatomic) IBOutlet UIButton *yqButton;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *lxLabel;
@property (weak, nonatomic) IBOutlet UILabel *fjLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation RecordRepayPlanListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.yqButton.layer.borderWidth = 1;
    self.yqButton.layer.borderColor = BYENERGYCOLOR(0xf37155).CGColor;
    [self.yqButton setTitle:@"" forState:UIControlStateNormal];
    
}

- (void)setModel:(RepayDetailPlanListModel *)model {
    _model = model;
    self.periodLabel.text = [NSString stringWithFormat:@"%@/%@",_model.term,_model.total_term];
    [self.yqButton setTitle:[NSString stringWithFormat:@"  %@天  ",_model.overdue_days] forState: UIControlStateNormal];
    self.totalLabel.text = [NSString stringWithFormat:@"%@元",[NSString doubleReplaceWithNumber:_model.amount]];
    self.lxLabel.text = [NSString stringWithFormat:@"：%@",[NSString doubleReplaceWithNumber:_model.interest]];
    self.fjLabel.text = [NSString stringWithFormat:@"%@",[NSString doubleReplaceWithNumber:_model.overdue_fine]];
//    self.timeLabel.text = [NSDate interverWithTimeInterval:model.planned_repayment_at formatter:@"yyyy-MM-dd"];
    self.stateLabel.text = _model.state;
    self.stateLabel.textColor = _model.color;
}

//- (NSString *)interverTimeToString:(NSTimeInterval)time {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter  setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
//    NSString *timeString = [formatter stringFromDate:date];
//    return timeString;
//}
@end
