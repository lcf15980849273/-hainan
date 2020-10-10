//
//  ByEnergyUserLoaction.h
//  ByEnergyCharge
//
//  Created by Mr.lin on 2020/3/24.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ByEnergyUserLoaction : NSObject
SINGLETON_FOR_HEADER(ByEnergyUserLoaction)
+ (BOOL)isValidLocationWithLat:(double)lat lng:(double)lng;
@end

NS_ASSUME_NONNULL_END
