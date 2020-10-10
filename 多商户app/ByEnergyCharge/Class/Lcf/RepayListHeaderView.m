//
//  RepayListHeaderView.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayListHeaderView.h"

@interface RepayListHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mountLabel;

@end
@implementation RepayListHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"RepayListHeaderView" owner:self options:nil]lastObject];
        
    }
    return self;
}

- (void)setModel:(RepayModel *)model {
    _model = model;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",_model.dateString];
    self.mountLabel.text = [NSString stringWithFormat:@"%@",_model.total_amountSting];
}
@end
