//
//  RecordListModel.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/5/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RecordListModel.h"

@implementation RecordListModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return   @{
               @"loanid" : @"loan_id",
               @"time":@"state_time"
               };
}

- (NSString *)state {
    if ([_state isEqualToString:@"auditing"]) {
        return @"审核中";
    }else if ([_state isEqualToString:@"audit_failure"]){
        return @"";
    }else if ([_state isEqualToString:@"reviewing"]){
        return @"审核中";
    }else if ([_state isEqualToString:@"review_failure"]){
        return @"";
    }else if ([_state isEqualToString:@"review_success"]){
        return @"";
    }else if ([_state isEqualToString:@"granting"]){
        return @"";
    }else if ([_state isEqualToString:@"repaying"]){
        return @"";
    }else if ([_state isEqualToString:@"finished"]){
        return @"";
    }else if ([_state isEqualToString:@"overdue"]){
        return @"逾期中";
    }else if ([_state isEqualToString:@"grant_failure"]){
        return @"";
    }
    return _state;
}
@end
