//
//  UITextField+setTextCount.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (setTextCount)

/**
 textFiled输入时限制长度，传入限定值
 @param length 限制长度
 */
- (void)setTextCount:(int)length;
@end

NS_ASSUME_NONNULL_END
