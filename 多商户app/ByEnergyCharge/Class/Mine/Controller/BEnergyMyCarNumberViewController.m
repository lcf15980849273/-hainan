//
//  BEnergyMyCarNumberViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyMyCarNumberViewController.h"
#import "BEnergyCarNumberViewModel.h"
#import "BEnergyCarNumberTableViewCell.h"
#import "BEnergyAddCarNumberTableViewCell.h"
#import "BEnergyAddCarNumberViewController.h"

@interface BEnergyMyCarNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) BEnergyCarNumberViewModel *carNumberViewModel;
@property (nonatomic, copy) NSString *carNumber;
@property (nonatomic, strong) BEnergyCarListModel *deletCarModel;


@end

@implementation BEnergyMyCarNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self byEnergyInitViews];
    [self byEnergySetViewLayout];
    [self byEnergyInitViewModel];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)byEnergyInitViews {
    self.titleLabel.text = @"我的车牌号";
    self.detailLabel.text = @"绑定车牌号 立享停车优惠";
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailLabel];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergySetViewLayout {
    kWeakSelf(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(37);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titleLabel.mas_bottom).mas_offset(14);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.detailLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    [[[[self.carNumberViewModel.hnFetchCarNumberCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.carNumberViewModel.result) {
            [self.tableView reloadData];
        }
    }];
    [self.carNumberViewModel.hnFetchCarNumberCommand execute:nil];
    
    [[[[self.carNumberViewModel.hnDelCarNumberCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.carNumberViewModel.result) {
            [HUDManager showStateHud:@"删除成功！" state:HUDStateTypeSuccess];
            [self.carNumberViewModel.datasArray removeObject:self.deletCarModel];
            [self.tableView reloadData];
        }else {
            [HUDManager showStateHud:@"删除失败！" state:HUDStateTypeSuccess];
        }
    }];
    
    [[self.carNumberViewModel.hnDelCarNumberCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [HUDManager showStateHud:@"删除失败！" state:HUDStateTypeSuccess];
    }];
}

#pragma mark -----TableViewDelegate && TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (self.carNumberViewModel.datasArray.count + (self.carNumberViewModel.datasArray.count <10?1:0));
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ByEnergyWeakSekf
    if (indexPath.row < self.carNumberViewModel.datasArray.count ) {
        static NSString *cellId = @"BEnergyCarNumberTableViewCell";
        BEnergyCarNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

        if (cell == nil) {
            cell = [[BEnergyCarNumberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        BEnergyCarListModel *model = self.carNumberViewModel.datasArray[indexPath.row];
        cell.carListModel = model;
//        cell.contentLabel.text = [self.carNumberViewModel.datasArray objectAtIndex:indexPath.row];
        [[[cell.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            [self editCarNumberIndex:indexPath];
        }];
        return cell;
    }else {
        static NSString *cellId = @"BEnergyAddCarNumberTableViewCell";
        BEnergyAddCarNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[BEnergyAddCarNumberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [[[cell.addCarBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            [self pushAddPlateNoViewController:YES WithCarListModel:nil];
        }];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row < self.carNumberViewModel.datasArray.count) {
        [self editCarNumberIndex:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 92;
}

- (void)pushAddPlateNoViewController:(BOOL)isAdd WithCarListModel:(BEnergyCarListModel *)model{
    BEnergyAddCarNumberViewController *vc = [[BEnergyAddCarNumberViewController alloc] init];
    vc.carNumber = isAdd ? @"琼" : model.carNumber;
    vc.isAddPlateNo = isAdd;
    vc.listModel = model;
    vc.carNumberList = self.carNumberViewModel.datasArray;
    ByEnergyWeakSekf
    [[vc.updateSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [self.carNumberViewModel.hnFetchCarNumberCommand execute:nil];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editCarNumberIndex:(NSIndexPath *)indexPath {
    ByEnergyWeakSekf
    BEnergyCarListModel *model = self.carNumberViewModel.datasArray[indexPath.row];
    [SCAlertViewUtils showAlertWithType:SCAlertTypeActionSheet
                                  title:model.carNumber
                                message:nil
                      cancelButtonTitle:@"取消"
                 destructiveButtonTitle:@"删除"
                      otherButtonTitles:@[@"编辑"]
                      completionHandler:^(SCAlertButtonType buttonType, NSUInteger buttonIndex) {
        ByEnergyStrongSelf
        if (buttonType == SCAlertButtonTypeDestructive) {
            [self deleteCarNumber:model];
        }
        if (buttonType == SCAlertButtonTypeOther) {
            [self pushAddPlateNoViewController:NO WithCarListModel:model];
        }
    }];
}

#pragma mark -----Action-----
- (void)deleteCarNumber:(BEnergyCarListModel *)carNumberModel {
    kWeakSelf(self);
    self.deletCarModel = carNumberModel;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [BEnergyCustomAlertView showAlertViewWithTitle:@"您确定是否删除车牌号？"
                                           buttonArray:@[@"保留",@"删除"]
                                                 block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                weakself.carNumberViewModel.carNumber = carNumberModel.carNumber;
                [weakself.carNumberViewModel.hnDelCarNumberCommand execute:nil];
            }
        }];
    });
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc showSheetStylePickerViewWithLastText:@"类别"];
}

#pragma mark ----------LazyLoad
LCFLazyload(BEnergyCarNumberViewModel, carNumberViewModel)

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = ByEnergyRegularFont(26);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = UIColor.byEnergyTitleTextBlack;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = ByEnergyRegularFont(14);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#FFB755"];
    }
    return _detailLabel;
}
@end
