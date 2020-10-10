//
//  RepayOnTimeModel.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2019/7/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RepayOnTimeModel.h"

@implementation RepayOnTimeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [RepayOnTimeListModel class]
             };
}
@end

@implementation RepayOnTimeListModel

- (NSString *)state {
//    if ([_state isEqualToString:@"0"]) {
//        self.stateTextColor = COLOR_HEX(0x7d7c7c);
//        return @"";
//    }else if ([_state isEqualToString:@"1"]){
//        self.stateTextColor = COLOR_HEX(0x2391fb);
//        return @"";
//    }else if ([_state isEqualToString:@"2"]){
//        self.stateTextColor = COLOR_HEX(0xf16f4c);
//        return @"";
//    }else if ([_state isEqualToString:@"3"]){
//        self.stateTextColor = kComminBlackTextColor;
//        return @"";
//    }
    return @"";
}

- (NSString *)type {
    if ([_state isEqualToString:@"1"] || [_state isEqualToString:@"2"]) {
        return @"due";
    }else if ([_state isEqualToString:@"3"]){
        return @"sum";
    }else if ([_state isEqualToString:@"4"]) {
        return @"pre";
    }
    return @"";
}
@end
