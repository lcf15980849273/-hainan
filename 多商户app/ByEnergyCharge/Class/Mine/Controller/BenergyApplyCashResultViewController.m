//
//  BenergyApplyCashResultViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/6/5.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BenergyApplyCashResultViewController.h"
#import "BEnergyMyAccountInfoViewController.h"
@interface BenergyApplyCashResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;//金额
@property (weak, nonatomic) IBOutlet UILabel *accountLabel; //账号

@end

@implementation BenergyApplyCashResultViewController

- (instancetype)init {
    return [BenergyApplyCashResultViewController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitDatas];
    [self byEnergyInitViews];
    [self byEnergySetViewLayout];
    [self byEnergyInitViewModel];
    
    [self popToPointViewController:NSStringFromClass([BEnergyMyAccountInfoViewController class])];
}

- (void)byEnergyInitDatas {
   
}

- (void)byEnergyInitViews {
    self.title = @"提现结果";
    self.amountLabel.text = [NSString stringWithFormat:@"%@元",self.applyAmount];
    self.accountLabel.text = self.accountLabel.text;
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergySetViewLayout {
    
}

- (void)byEnergyInitViewModel {
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}


- (IBAction)backButtonClick:(UIButton *)sender {
    ByEnergySendNotification(ByEnergyRefreshMyAmount, nil);
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
