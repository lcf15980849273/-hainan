//
//  CarPlateNoKeyBoardView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarPlateNoKeyBoardView : UIView
@property (nonatomic, copy) void(^sc_keyboardEditing)(BOOL isDel, NSString *text);

/**
 改变键盘数据，
 
 @param showProvince 显示省份、特殊字
 */
- (void)sc_changeKeyBoard:(BOOL)showProvince;
@property (nonatomic, assign) BOOL isProvince; // 当前是否是省份
@property (nonatomic, copy) NSString *selectProvince; // 选中省份
@end

NS_ASSUME_NONNULL_END
