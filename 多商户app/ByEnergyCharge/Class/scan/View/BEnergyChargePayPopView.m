//
//  BEnergyChargePayPopView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargePayPopView.h"
#import "ChargePayPopViewCell.h"
#import "ChargeMoneyPopViewCell.h"
@interface BEnergyChargePayPopView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong)ChargeTypeModel *chargeTypeModel;//选中的充值方式模型
@property(nonatomic, strong)ChargeMoneyModel *chargeMoneyModl;//选中的金额模型

@end

@implementation BEnergyChargePayPopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"BEnergyChargePayPopView" owner:self options:nil]lastObject];
        [self initDataAndViews];
    }
    return self;
}

- (void)initDataAndViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:kChargePayPopViewCell bundle:nil] forCellReuseIdentifier:kChargePayPopViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:kChargeMoneyPopViewCell bundle:nil] forCellReuseIdentifier:kChargeMoneyPopViewCell];
}

- (IBAction)sureButtonClick:(UIButton *)sender {
    
    for (ChargeMoneyModel *model in self.model.chargeMoney) {
        if (model.isSelcet) {
            self.chargeMoneyModl = model;
            break;
        }
    }
    
    if (!self.chargeTypeModel.isSelcet) {
        [HUDManager showStateHud:@"请选择充值方式" state:HUDStateTypeWarning];return;
    }
    
    if (self.commitButtonkBlock) {
        self.commitButtonkBlock(self.chargeTypeModel, self.chargeMoneyModl);
    }
}

#pragma mark ----- setter
- (void)setModel:(BEnergyChargePayInfoModel *)model {
    _model = model;
    for (ChargeTypeModel *model in _model.chargeType) {
        model.isSelcet = [model.type isEqualToString:@"3"] ? YES : NO;
        self.chargeTypeModel = model;
    }
    [self.tableView reloadData];
}


#pragma mark ----- tableViewDelegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.model.chargeType.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 140 : 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0, 20, 200, 13)];
    label.font = ByEnergyRegularFont(14);
    label.textColor = BYENERGYCOLOR(0x676767);
    [headerView addSubview:label];
    label.text = section == 0 ? @"选择充值金额" : @"支付方式";
    return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ChargeMoneyPopViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kChargeMoneyPopViewCell];
        cell.infoModel = self.model;
        return cell;
    }else {
        ChargePayPopViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kChargePayPopViewCell];
        cell.model = self.model.chargeType[indexPath.row];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        self.chargeTypeModel = self.model.chargeType[indexPath.row];
        for (int i = 0; i  < self.model.chargeType.count; i ++) {
            if (i == indexPath.row) {
                ChargeTypeModel *model = self.model.chargeType[i];
                if (!model.isSelcet) {
                    model.isSelcet = !model.isSelcet;
                }
            }else {
                ChargeTypeModel *model = self.model.chargeType[i];
                model.isSelcet = NO;
            }
        }
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark ----- action
- (IBAction)closeButtonClick:(UIButton *)sender {
    [self viewHiden];
}

- (void)viewShow {
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}

- (void)viewHiden {
    [self removeFromSuperview];
}
@end
