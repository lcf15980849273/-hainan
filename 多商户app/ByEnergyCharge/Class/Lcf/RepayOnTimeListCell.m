//
//  RepayOnTimeListCell.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayOnTimeListCell.h"
@interface RepayOnTimeListCell ()
@property (weak, nonatomic) IBOutlet UILabel *qsLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *monyLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewTrailing;
@end
@implementation RepayOnTimeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

#pragma mark - setter

- (void)setRepayOntimeModel:(RepayOnTimeModel *)repayOntimeModel {
    _repayOntimeModel = repayOntimeModel;
}

- (void)setModel:(RepayOnTimeListModel *)model {
    _model = model;
    self.qsLabel.text = [NSString stringWithFormat:@"%@/%@",_model.term,self.repayOntimeModel.loan_term];
    self.monyLabel.text = [NSString stringWithFormat:@"%@元",[NSString doubleReplaceWithNumber:_model.amount]];
    self.stateLabel.text = _model.state;
    self.stateLabel.textColor = _model.stateTextColor;
    self.timeLabel.text = [self interverTimeToString:_model.planned_repayment_at];
    
    if ([_model.state isEqualToString:@""]) {
        self.stackViewTrailing.constant = 18.0f;
    }else {
        self.stackViewTrailing.constant = -15.0f;
    }
}

- (NSString *)interverTimeToString:(NSTimeInterval)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter  setDateFormat:@"MM月dd日"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

- (IBAction)showRepayPlanButtonClick:(UIButton *)sender {
    if (self.showRepayPlanBlock) {
        self.showRepayPlanBlock(self.model);
    }
}

@end
