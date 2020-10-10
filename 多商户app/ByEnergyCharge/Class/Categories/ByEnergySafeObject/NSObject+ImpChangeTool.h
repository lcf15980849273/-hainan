//
//  NSObject+ImpChangeTool.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/29.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ImpChangeTool)
/**
 *  交换两个函数实现指针  参数均为NSString类型
 *
 *  @param systemMethodString 系统方法名string
 *  @param systemClassString  系统实现方法类名string
 *  @param safeMethodString   自定义hook方法名string
 *  @param targetClassString  目标实现类名string
 */
+ (void)SwizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString;
@end

NS_ASSUME_NONNULL_END
