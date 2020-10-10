//
//  BRAddressPickerView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BRBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^BRAddressResultBlock)(NSArray *selectAddressArr);
@interface BRAddressPickerView : BRBaseView
/**
 *  显示地址选择器
 *
 *  @param defaultSelectedArr       默认选中的值(传数组，元素为对应的索引值。如：@[@10, @1, @1])
 *  @param isAutoSelect             是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock              选择后的回调
 *
 */
+ (void)showAddressPickerWithDefaultSelected:(NSArray *)defaultSelectedArr isAutoSelect:(BOOL)isAutoSelect resultBlock:(BRAddressResultBlock)resultBlock;
@end

NS_ASSUME_NONNULL_END
