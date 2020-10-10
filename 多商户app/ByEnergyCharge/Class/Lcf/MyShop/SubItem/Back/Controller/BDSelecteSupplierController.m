//
//  BDSelecteSupplierController.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDSelecteSupplierController.h"

@interface BDSelecteSupplierController ()

@property (nonatomic, strong) NSMutableArray<BDSupplierModel *> *dataArray;

@end

@implementation BDSelecteSupplierController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择供应商";
   
    [self loadData];
    
}

- (void)refreshData {
//    [super refreshData];
    [self.dataArray removeAllObjects];
    [self loadData];
}

- (void)loadMoreData {
//    [super loadMoreData];
//    [self endLoading];
}



- (void)loadData {
//    [HUDTool showLoading];
//    [HttpRequestDataTool GET:MyStoreBusinessUrl
//                       params:nil
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          [HUDTool dismissHud];
//                          [self endLoading];
//                          self.dataArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[BDSupplierModel class] json:response[@"data"][@"result"]]];
//                          if (self.dataArray.count == 0) {
//                              self.showsDataNoDataView = YES;
//                          }else {
//                              self.showsDataNoDataView = NO;
//                              [self.tableView reloadData];
//                          }
//
//                      } failure:^(id response) {
//                          [HUDTool dismissHud];
//                      }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selecteSuccessBlock) {
        self.selecteSuccessBlock(self.dataArray[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.0f;
}

#pragma mark - Lazy Load
- (NSMutableArray<BDSupplierModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
