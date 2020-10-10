//
//  BEnergyStubGroupModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/11/20.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "BEnergyStubGroupModel.h"
#import "BEnergyStubGroupDetailModel.h"
@implementation BEnergyStubGroupModel

- (void)setName:(NSString *)name {
    _name = name;
    if (byEnergyIsValidStr(name)) {
        self.nameSize = [name sizeWithFont:ByEnergyRegularFont(20) maxSize:CGSizeMake(SCREENWIDTH-131, MAXFLOAT)];
    }
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"auxiliaryList" : @"auxiliaryList"
             };
}
@end
