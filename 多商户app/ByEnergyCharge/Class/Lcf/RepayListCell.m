//
//  RepayListCell.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayListCell.h"

@interface RepayListCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
@property (weak, nonatomic) IBOutlet UILabel *termLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayLabel;
@property (weak, nonatomic) IBOutlet UILabel *bjLabel;
@property (weak, nonatomic) IBOutlet UILabel *lxLabel;
@property (weak, nonatomic) IBOutlet UILabel *overdueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *overdueImage;

@end
@implementation RepayListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.shadowOffset = CGSizeMake(0, 1);
    self.backView.layer.shadowOpacity = 1.0;
    self.backView.layer.shadowRadius = 5;
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                                      green:0.0f/255.0f
                                                       blue:0.0f/255.0f
                                                      alpha:0.2].CGColor;
}

- (void)setModel:(RepayListModel *)model {
    _model = model;
    self.overdueLabel.hidden = _model.isHidenState;
    self.overdueImage.hidden = _model.isHidenState;
//    self.timelabel.text = [NSString stringWithFormat:@"%@%@元",[NSDate timestampSwitchTime:_model.lending_at andFormatter:@"yyyy年MM月dd日"],[NSString doubleReplaceWithNumber:_model.quota]];
    self.termLabel.text = [NSString stringWithFormat:@"%@/%@",_model.term,_model.total_term];
    self.repayLabel.text = [NSString stringWithFormat:@"%@元",[NSString doubleReplaceWithNumber:_model.monthly]];
    self.bjLabel.text = [NSString stringWithFormat:@"%@元",[NSString doubleReplaceWithNumber:_model.principal]];
    self.lxLabel.text = [NSString stringWithFormat:@"%@元",[NSString doubleReplaceWithNumber:_model.interest]];
//    self.overdueImage.image = [_model.state isEqualToString:@"overdue"] ? image(@"overdueIcon") : image(@"overRepay");
    self.overdueLabel.text = [_model.state isEqualToString:@"overdue"] ? @"" : @"";
}


- (IBAction)repayButtonClick:(UIButton *)sender {
    if (self.repayButtonBLock) {
        self.repayButtonBLock(self.model);
    }
}

@end
