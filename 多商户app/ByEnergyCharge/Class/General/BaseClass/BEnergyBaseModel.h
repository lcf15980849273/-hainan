//
//  BEnergyBaseModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "JSONModel.h"
#import <objc/runtime.h>
#import "NSString+ByEnergySize.h"

@interface BEnergyBaseModel : JSONModel

- (id)fetchValueWithName:(NSString *)propertyName;
@end
