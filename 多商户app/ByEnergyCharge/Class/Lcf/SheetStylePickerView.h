
//
//  SheetStylePickerView.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/10/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BEnergyBaseView.h"

@interface SheetStylePickerView : BEnergyBaseView<UITableViewDelegate, UITableViewDataSource>


+ (instancetype)sheetStylePickerView;

@property(nonatomic, strong) NSArray *titles;

@property(nonatomic, assign) CGFloat cellHeight;

@property(nonatomic) NSTextAlignment textAlignment;

@property(nonatomic, strong) UIFont *font;

@property(nonatomic, strong) UIColor *textColor;

@property(nonatomic, copy) NSString *lastSelectedOpt;

@property(nonatomic, copy) void(^DidSelectedRowBlock)(NSString *title, long index);

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *maskView;

- (void)show;
- (void)dismiss;

@end
