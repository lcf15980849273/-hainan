//
//  BEnergyBaseModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

@implementation BEnergyBaseModel
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

- (id)fetchValueWithName:(NSString *)propertyName{
    
    return [self valueForKey:propertyName];
} 

@end
