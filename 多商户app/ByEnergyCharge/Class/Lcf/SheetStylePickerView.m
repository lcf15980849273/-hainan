//
//  SheetStylePickerView.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/10/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SheetStylePickerView.h"
//#import "BaseTableCell.h"
@implementation SheetStylePickerView

#pragma mark - Public Method

- (void)byEnergyInitSubView {
    [self addSubview:self.maskView];
    [self addSubview:self.tableView];
    self.tableView.zm_y = SCREENHEIGHT;

//    weakify(self);
//    [self.maskView zm_performActionOnTap:^(__kindof UIView *view) {
//        strongify(self);
//
//        [self dismiss];
//    }];
}

+ (instancetype)sheetStylePickerView {
    return [[SheetStylePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.tableView zm_layoutLeft:0.0f
                            width:self.zm_width];
    
}

- (void)show {
//    if (self) {
//        [self removeFromSuperview];
//    }
//    [KeyWindow addSubview:self];
//
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         self.maskView.alpha = 1.0f;
//                         self.tableView.zm_y = KeyWindow.zm_height - self.tableView.zm_height - ViewSafeAreaInsets(self).bottom;
//                     } completion:^(BOOL finished) {
//                         //
//                     }];
}

//- (void)dismiss {
//    [UIView animateWithDuration:0.3
//                     animations:^{
//                         self.maskView.alpha = 0.0f;
//                         self.tableView.zm_y = KeyWindow.zm_height;
//                     }
//                     completion:^(BOOL finished) {
//                         [self removeFromSuperview];
//                     }];
//}
#pragma mark - Protocol
#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    BaseTableCell *cell = [BaseTableCell dequeueCellWithTableView:tableView
//                                                        indexPath:indexPath];
//    cell.textLabel.textAlignment = self.textAlignment ?: NSTextAlignmentLeft;
//    cell.textLabel.font = self.font ?: ByEnergyRegularFont(15);
//    cell.textLabel.textColor = self.textColor ?: [UIColor blackColor];
//    if (indexPath.row < self.titles.count) {
//        cell.textLabel.text = self.titles[indexPath.row];
//
//        if (self.lastSelectedOpt && [cell.textLabel.text isEqualToString:self.lastSelectedOpt]) {
//            cell.textLabel.textColor = BYENERGYCOLOR(0xe99400);
//        }
//    }
//    return cell;
    return [UITableViewCell new];
}

#pragma mrak <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.0001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return self.cellHeight > 0 ?: 44.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < self.titles.count && self.DidSelectedRowBlock) {
        self.DidSelectedRowBlock(self.titles[indexPath.row], indexPath.row);
        self.lastSelectedOpt = self.titles[indexPath.row];
    }
    
    [self dismiss];
}

#pragma mark - Setter Getter
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    self.tableView.zm_height = titles.count * (self.cellHeight > 0 ?: 44.0f);
    
    [self.tableView reloadData];
    
    [self show];
}

#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 375.0f, 100.0f)
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 15.0f);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [UIView new];
//        _maskView.frame = KeyWindow.bounds;
        _maskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        
    }
    return _maskView;
}

@end
