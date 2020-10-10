//
//  RepayBottomView.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayBottomView.h"

@interface RepayBottomView ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *LblBankName;

@end

@implementation RepayBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"RepayBottomView" owner:self options:nil]lastObject];
    }
    return self;
}

- (void)ViewShow {
    self.frame = CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT);
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}

- (void)ViewHiden {
    [self removeFromSuperview];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [self ViewHiden];
}

- (IBAction)commitButtonClick:(UIButton *)sender {
    [self ViewHiden];
    if ([self.delegate respondsToSelector:@selector(commitRepayWithModel:)]) {
        [self.delegate commitRepayWithModel:self.model];
    }
}

#pragma mark - seeter
- (void)setModel:(RepayBottomViewModel *)model {
    _model = model;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",[NSString doubleReplaceWithNumber:_model.amount]];
    self.orderTypeLabel.text = _model.type;
    self.LblBankName.text = _model.bank;
}
@end

@implementation RepayBottomViewModel

- (NSString *)type {
    if ([_type isEqualToString:@"1"]) {
        return @"到期还款";
    }else if ([_type isEqualToString:@"2"]){
        return @"逾期还款";
    }else if ([_type isEqualToString:@"3"]){
        return @"合计还款";
    }else if ([_type isEqualToString:@"4"]){
        return @"提前还款";
    }
    return @"";
}

- (NSString *)repayType {
    if ([_type isEqualToString:@"1"] || [_type isEqualToString:@"2"]) {
        return @"due";
    }else if ([_type isEqualToString:@"3"]){
        return @"sum";
    }else if ([_type isEqualToString:@"4"]) {
        return @"pre";
    }
    return @"";
}
@end


