//
//  StringForUnit.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StringForUnit : NSObject
//米转km
+ (NSString *)getKmStrWithMeter:(int)meter unitStr:(NSString *)unitStr;
@end

NS_ASSUME_NONNULL_END
