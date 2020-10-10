//
//  NSObject+ByEnergyPerform.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ByEnergyPerform)
- (void)hnByEnergyAfter:(NSTimeInterval)second action:(void (^)(void) )action;
+ (void)hnByEnergyAfter:(NSTimeInterval)second action:(void (^)(void) )action;
@end

NS_ASSUME_NONNULL_END
