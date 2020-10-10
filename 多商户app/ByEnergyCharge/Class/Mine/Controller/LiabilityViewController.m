//
//  LiabilityViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/20.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "LiabilityViewController.h"
#import "CFYYViewController.h"
@interface LiabilityViewController ()

@end

@implementation LiabilityViewController
- (instancetype)init {
    return [LiabilityViewController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewDidLoad {
    
    CFYYViewController *vc = [[CFYYViewController alloc]init];
    [vc setAddSubscriptSuccessBlock:^{
        
    }];
    
    [super viewDidLoad];
    self.title = @"免责声明";
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
    
    
}



@end
