//
//  BEnergyInvoiceDetailsViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceDetailsViewController.h"
#import "BEnergyApplyForInvoiceViewModel.h"
#import "NonHoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"
#import "BEnergyInvoiceDetailsCell.h"
#import "BEnergyInvoiceDetailsHeadCell.h"
#import "BEnergyInvoiceDetailsFooterCell.h"
#import "AlertViewTools.h"
#import "BEnergyInvoiceDetailsModel.h"

@interface BEnergyInvoiceDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) BEnergyApplyForInvoiceViewModel *applyForInvoiceViewModel;
@property (nonatomic, assign) CGFloat addressRowHeight;
@property (nonatomic, strong) UILabel *headLabel;

@end

@implementation BEnergyInvoiceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitDatas];
    
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

- (void)byEnergyInitDatas {
    NSMutableArray *arrays = [[NSMutableArray alloc] init];
    NSMutableArray *firstArray = [[NSMutableArray alloc] init];
    NSMutableArray *secondArray = [[NSMutableArray alloc] init];
    NSMutableArray *threeArray = [[NSMutableArray alloc] init];
    [firstArray addObject:@{
                            byEnergyCellKey:@"baseInfo",
                            byEnergyCellTitle:@"",
                            byEnergyCellValue:@"",
                            }];
    [secondArray addObject:@{
                             byEnergyCellKey:@"name",
                             byEnergyCellTitle:@"发票接收人",
                             byEnergyCellValue:@"",
                             byEnergyCellDisplayValue:(@"nameHeight"),
                             byEnergyCellHeight:@(48),
                             }];
    [secondArray addObject:@{
                             byEnergyCellKey:@"address",
                             byEnergyCellTitle:@"收票地址",
                             byEnergyCellValue:@"",
                             byEnergyCellDisplayValue:(@"addressHeight"),
                             byEnergyCellHeight:@(48),
                             }];
    [threeArray addObject:@{
                            byEnergyCellKey:@"title",
                            byEnergyCellTitle:@"发票抬头",
                            byEnergyCellValue:@"",
                            byEnergyCellDisplayValue:(@"titleHeight"),
                            byEnergyCellHeight:@(48),
                            }];
    [threeArray addObject:@{
                            byEnergyCellKey:@"corporationNum",
                            byEnergyCellTitle:@"纳税人识别号",
                            byEnergyCellValue:@"",
                            byEnergyCellDisplayValue:(@"corporationNumHeight"),
                            byEnergyCellHeight:@(48),
                            }];
    [arrays addObject:firstArray];
    [arrays addObject:secondArray];
    [arrays addObject:threeArray];
    NSArray *datas = [arrays.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
        NSArray *arr = (NSArray *)value;
        NSMutableArray *dataArray = [[arr.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
            NSError* err = nil;
            BEnergyStartChargeCellModel *model = [[BEnergyStartChargeCellModel alloc] initWithDictionary:value error:&err];
            if (err == nil) {
                return model;
            }
            return [BEnergyStartChargeCellModel new];
        }].toArray mutableCopy];
        return dataArray;
    }].toArray;
    [self.contentArray addObjectsFromArray:datas];
}

- (void)byEnergyInitViews {
    self.navigationItem.title = @"发票详情";
    [self byEnergyNavItemWithImgeNames:@[@"btn_service_mine"] isLeft:NO target:self action:@selector(serviceBtnAct) tags:nil];
    
    self.tableView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColor.byEnergyLineGray;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //注册区头跟随滑动
    [self.tableView registerClass:NonHoveringHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(NonHoveringHeaderView.class)];
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    self.applyForInvoiceViewModel.invoiceNum = self.invoiceNum;
    [[[[self.applyForInvoiceViewModel.hnInvoiceDetailCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.applyForInvoiceViewModel.result) {
            [self.tableView reloadData];
        }
    }];
    [self.applyForInvoiceViewModel.hnInvoiceDetailCommand execute:nil];
}

#pragma mark -----懒加载-----
LCFLazyload(BEnergyApplyForInvoiceViewModel, applyForInvoiceViewModel)
LCFLazyload(NSMutableArray, contentArray)

#pragma mark -----TableViewDelegate && TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return  [[self.applyForInvoiceViewModel.value consumInfo] count];
    }
    return [[self.contentArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellId = @"BEnergyInvoiceDetailsHeadCell";
        BEnergyInvoiceDetailsHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[BEnergyInvoiceDetailsHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        BEnergyInvoiceDetailsModel *detailsModel = self.applyForInvoiceViewModel.value;
        detailsModel.baseInfo.status = self.status;
        [cell byEnergyFillCellDataWithModel:detailsModel];
        return cell;
    }else if (indexPath.section == 1 ||indexPath.section == 2) {
        static NSString *cellId = @"BEnergyInvoiceDetailsCell";
        BEnergyInvoiceDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[BEnergyInvoiceDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        BEnergyStartChargeCellModel *model = [self.contentArray[indexPath.section] objectAtIndex:indexPath.row];
        model.value = [[self.applyForInvoiceViewModel.value baseInfo] fetchValueWithName:model.key];
        [cell byEnergyFillCellDataWithModel:model];
        return cell;
    }else {
        static NSString *cellId = @"BEnergyInvoiceDetailsFooterCell";
        BEnergyInvoiceDetailsFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[BEnergyInvoiceDetailsFooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell byEnergyFillCellDataWithModel:[[self.applyForInvoiceViewModel.value consumInfo] objectAtIndex:indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.status == 1) {
            return 136;
        }
        return 112;
    }else if (indexPath.section == 1 || indexPath.section == 2) {
        BEnergyStartChargeCellModel *model = [self.contentArray[indexPath.section] objectAtIndex:indexPath.row];
        return [[[self.applyForInvoiceViewModel.value baseInfo] fetchValueWithName:model.displayValue] floatValue];
    }
    return 92;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 32;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Class headerClass =  NonHoveringHeaderView.class;
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerClass)];
    header.contentView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    header.frame = CGRectMake(20, 0, 300, 32);
    header.tableView = tableView;
    header.section = section;
    header.textLabel.font = ByEnergyRegularFont(14);
    header.textLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#757575"];
    switch (section) {
        case 1:
            header.textLabel.text = @"接收信息";
            break;
        case 2:
            header.textLabel.text = @"发票信息";
            break;
        case 3:
            header.textLabel.text = @"消费记录";
            break;
        default:
            header.textLabel.text = @"";
            break;
    }
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark -----Action-----
- (void)serviceBtnAct {
    NSLog(@"联系客服");
    [AlertViewTools showServiceNumber];
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc showSheetStylePickerViewWithLastText:@"类别"];
}


@end
