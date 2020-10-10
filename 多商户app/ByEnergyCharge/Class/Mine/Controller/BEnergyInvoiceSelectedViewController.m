//
//  BEnergyInvoiceSelectedViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyInvoiceSelectedViewController.h"
#import "BEnergyInvoiceSelectedCell.h"
#import "BEnergyApplyForInvoiceViewModel.h"
#import "BEnergyInvoiceSumChoiceModel.h"
#import "UILabel+FitLines.h"

@interface BEnergyInvoiceSelectedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BEnergyApplyForInvoiceViewModel *byViewModel;
@property (nonatomic, strong) UIButton *byRightButton;
@property (nonatomic, assign) BOOL isSelectedAll;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, copy) NSString *currentYearString;

@end

@implementation BEnergyInvoiceSelectedViewController

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
    
    [self byEnergyNavItemWitnTitles:@[@"全选"]
                             isLeft:NO
                             target:self
                             action:@selector(selectedAll)
                               tags:nil];
    _byRightButton = self.navigationItem.rightBarButtonItem.customView;
    [_byRightButton setTitle:@"全选" forState:UIControlStateNormal];
    [_byRightButton setTitle:@"取消" forState:UIControlStateSelected];
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.submitBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = UIColor.byEnergyLineGray;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.loadEmptyType = SCLoadEmptyTypeNoInvoiceSelect;
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
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(55);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-SafeStatusBarHeight);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(-27);
        make.left.mas_equalTo(27);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.equalTo(weakself.footerView.mas_top).mas_offset(0);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    self.byViewModel.orderIdList = self.orderIdList;
    [[[[self.byViewModel.hnInvoiceSumChoiceCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView reloadData];
        [self updataTabFrameToTop:[self.byViewModel.value count] == 0 ? NO:YES];
        [self checkIsAllSelectWithModelArray:x];
        
    }];
    [self.byViewModel.hnInvoiceSumChoiceCommand execute:nil];
    
    [[[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        NSMutableArray *orderIdList = [[NSMutableArray alloc] init];
        __block float money = 0.00;
        NSArray *datas = [self.byViewModel.datasArray.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
            NSArray *array = (NSArray *)value;
            NSArray *dataList = [array.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
                BEnergyInvoiceSumChoiceModel *model = (BEnergyInvoiceSumChoiceModel *)value;
                if (model.isSelected) {
                    [orderIdList addObject:model.orderId];
                    money = money + model.orderPayAmount;
                }
                return model;
            }].toArray;
            return dataList;
        }].toArray;
        [self.selectSubject sendNext:@{@"money":NSStringFormat(@"%0.2f",money),@"orderIdList":[orderIdList componentsJoinedByString:@","]}];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    //数据绑定
    RAC(self.footerView,hidden) = [RACChannelTo(self.byViewModel, value) map:^id _Nullable(id  _Nullable value) {
        ByEnergyStrongSelf
        return [NSNumber numberWithBool:[self.byViewModel.value count] == 0 ?YES:NO];
    }];
}


#pragma mark -----TableViewDelegate && TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.byViewModel.value count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.byViewModel.value objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"BEnergyInvoiceSelectedCell";
    BEnergyInvoiceSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BEnergyInvoiceSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell byEnergyFillCellDataWithModel:[[self.byViewModel.value objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BEnergyInvoiceSumChoiceModel *model =  [[self.byViewModel.value objectAtIndex:section] objectAtIndex:0];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F5F5F5"];
    label.textColor = [UIColor colorByEnergyWithBinaryString:@"#757575"];
    label.font = ByEnergyRegularFont(13);
    label.text = NSStringFormat(@"%@年%@月",self.currentYearString,model.timeMonth);
    label.firstLineHeadIndent = 20.0f;
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSMutableArray *array = [[self.byViewModel.value objectAtIndex:indexPath.section] mutableCopy];
    BEnergyInvoiceSumChoiceModel *model = [array objectAtIndex:indexPath.row];
    model.isSelected = !model.isSelected;
    [array replaceObjectAtIndex:indexPath.row withObject:model];
    [self.byViewModel.value replaceObjectAtIndex:indexPath.section withObject:array];
    [self.tableView reloadData];
}

#pragma mark -----Action-----
- (void)selectedAll {
    self.byRightButton.selected = !self.byRightButton.selected;
    BOOL isSelected = self.byRightButton.selected;
    NSArray *datas = [self.byViewModel.datasArray.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
        NSArray *array = (NSArray *)value;
        NSArray *dataList = [array.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
            BEnergyInvoiceSumChoiceModel *model = (BEnergyInvoiceSumChoiceModel *)value;
            model.isSelected = isSelected;
            return model;
        }].toArray;
        return dataList;
    }].toArray;
    [self.byViewModel.value removeAllObjects];
    [self.byViewModel.value addObjectsFromArray:datas];
    [self.tableView reloadData];
    
    
}

- (void)checkIsAllSelectWithModelArray:(NSArray <BEnergyInvoiceSumChoiceModel *> *)modelArray {
    for (BEnergyInvoiceSumChoiceModel *model in modelArray) {
        if (!model.isSelected) {
            self.byRightButton.selected = NO;
            break;
        }else {
            self.byRightButton.selected = YES;
        }
    }
}

- (void)updataTabFrameToTop:(BOOL)top {
    kWeakSelf(self);
    //    _byRightButton.hidden = !top;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (top) {
            make.bottom.equalTo(weakself.footerView.mas_top).mas_offset(0);
        }else {
            make.bottom.equalTo(weakself.footerView.mas_top).mas_offset(weakself.footerView.height);
        }
    }];
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyApplyForInvoiceViewModel, byViewModel)

- (RACSubject *)selectSubject {
    if (!_selectSubject) {
        _selectSubject = [RACSubject subject];
    }
    return _selectSubject;
}

- (NSString *)currentYearString {
    if (!_currentYearString) {
        NSDate *  senddate = [NSDate date];
        NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy"];
        _currentYearString = [dateformatter stringFromDate:senddate];
    }
    return _currentYearString;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = [UIColor whiteColor];
    }
    return _footerView;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(27, 0, self.footerView.width - 54, 54);
        _submitBtn.center = CGPointMake(self.footerView.width/2, (self.footerView.height/2)+8);
        _submitBtn.adjustsImageWhenHighlighted = NO;
        [_submitBtn setBackgroundImage:IMAGEWITHNAME(@"chargingBtn") forState:UIControlStateNormal];
        [_submitBtn setTitle:@"完成选择" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = ByEnergyRegularFont(18);
        ByEnergyWeakSekf
        [[[_submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            [self.selectSubject sendNext:nil];
        }];
    }
    return _submitBtn;
}

@end
