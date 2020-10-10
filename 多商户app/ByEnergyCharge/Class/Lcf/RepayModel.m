//
//  RepayModel.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayModel.h"

@implementation RepayModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [RepayListModel class]
             };
}

- (NSString *)dateString {
//    return [NSDate timestampSwitchTime:[self.date intValue] andFormatter:@"MM月dd日"];
    return @"2020";
}

- (NSString *)total_amountSting {
    return [NSString doubleReplaceWithNumber:self.total_amount];
}

@end
@implementation RepayListModel

- (BOOL)isHidenState {
    if ([self.state isEqualToString:@"overdue"] || [self.state isEqualToString:@"finished"]) {
        return NO;
    }return YES;
}
@end
