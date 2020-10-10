//
//  RecordDetailModel.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/5/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RecordDetailModel.h"

@interface RecordDetailModel ()
@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@implementation RecordDetailModel

- (NSString *)lending_at {
    
    if (_lending_at.length > 0) {
        return [self interverTimeToString:[_lending_at integerValue]];
    }else {
        return @"";
    }
}

- (NSString *)repayment_at {
    
    if (_repayment_at.length > 0) {
        return [self interverTimeToString:[_repayment_at integerValue]];
    }else {
        return @"";
    }
}

- (NSString *)end_at {
    
    if (_end_at.length > 0) {
        return [self interverTimeToString:[_end_at integerValue]];
    }else {
        return @"";
    }
}

- (NSString *)planned_repayment_at {
    if (_planned_repayment_at.length > 0) {
        return [self interverTimeToString:[_planned_repayment_at integerValue]];
    }else {
        return @"";
    }
}

- (NSString *)delay_state {
    if ([_delay_state isEqualToString:@"success"]) {
        return @"展期成功";
    }else if ([_delay_state isEqualToString:@"waiting"]){
        return @"处理中";
    }else{
        return @"";
    }
}

- (NSString *)repayDetailStr {
    if (self.has_repay_detail) {
        self.isHiden = NO;
        return @"";
    }else {
        self.isHiden = YES;
        return @"详情";
    }
}

- (NSString *)repay_channel {
    if ([_repay_channel isEqualToString:@"0"]) {
        return @"暂未";
    }else if ([_repay_channel isEqualToString:@"1"]) {
        return @"线";
    }else {
        return @"线";
    }
}

- (NSString *)state {
    if ([_state isEqualToString:@"auditing"]) {
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"审核中";
    }else if ([_state isEqualToString:@"audit_failure"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"审核失败";
    }else if ([_state isEqualToString:@"reviewing"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"审核中";
    }else if ([_state isEqualToString:@"review_failure"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"审核失败";
    }else if ([_state isEqualToString:@"grant_failure"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"失败";
    }else if ([_state isEqualToString:@"review_success"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"审核成功";
    }else if ([_state isEqualToString:@"granting"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"";
    }else if ([_state isEqualToString:@"repaying"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"";
    }else if ([_state isEqualToString:@"finished"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"";
    }else if ([_state isEqualToString:@"overdue"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"";
    }else if([_state isEqualToString:@"1"]){
        self.color = APPGrayColor;
        self.isHiden = NO;
        return @"";
    }else if([_state isEqualToString:@"0"]){
        self.color = APPGrayColor;
        self.isHiden = YES;
        return @"";
    }else{
        self.isHiden = YES;
        self.color = APPGrayColor;
        return _state;
    }
}

- (NSDateFormatter *)formatter {
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
        
    }
    return _formatter;
}

- (NSString *)interverTimeToString:(NSTimeInterval)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *timeString = [self.formatter stringFromDate:date];
    return timeString;
}
@end
