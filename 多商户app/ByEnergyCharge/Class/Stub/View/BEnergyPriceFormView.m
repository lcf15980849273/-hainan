//
//  BEnergyPriceFormView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyPriceFormView.h"
#import "BEnegryStubDetailPriceCell.h"

@interface BEnergyPriceFormView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BEnergyPriceFormView

- (instancetype)init {
    if (self = [super init]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
    }
    return self;
}

- (void)byEnergyInitViews{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 42)];
    headView.backgroundColor = UIColor.byEnergyLineGray;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 42)];
    label.text = @"价格时间表";
    label.font = ByEnergyRegularFont(16);
    label.textColor = [UIColor colorByEnergyWithBinaryString:@"#6E6E6E"];
    [headView addSubview:label];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(headView.width-50, 0, 42, 42);
    [closeBtn setImage:IMAGEWITHNAME(@"btn_close_StubDetail") forState:UIControlStateNormal];
    closeBtn.adjustsImageWhenHighlighted = NO;
    ByEnergyWeakSekf
    [[[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ByEnergyStrongSelf
        [self.closeSubject sendNext:nil];
    }];
    [headView addSubview:closeBtn];
    
//    self.tableView.tableHeaderView = headView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;
    

    [self addSubview:headView];
    [self addSubview:self.tableView];

}

- (void)byEnergySetViewLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(42);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}



#pragma mark -----TableViewDelegate && TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"BEnergyStubGroupDetailIntegralCell";
    BEnegryStubDetailPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BEnegryStubDetailPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Pricedetails *model = [self.datasArray objectAtIndex:indexPath.row];
    [cell configUIWithPricedetailsModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 117;
}

#pragma mark ----- LazyLoad

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _tableView.separatorColor = UIColor.byEnergyLineGray;
    }
    return _tableView;
}

- (NSMutableArray *)datasArray {
    if (_datasArray == nil) {
        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}

- (RACSubject *)closeSubject {
    if (_closeSubject == nil) {
        _closeSubject = [RACSubject subject];
    }
    return _closeSubject;
}

@end
