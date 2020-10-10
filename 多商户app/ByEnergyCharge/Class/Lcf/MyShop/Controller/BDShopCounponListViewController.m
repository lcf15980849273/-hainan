//
//  BDShopCounponListViewController.m
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopCounponListViewController.h"
#import "BDShopCounponListModel.h"
#import "BDShopCounponCell.h"
#import "BDShopCounponDetailViewController.h"
@interface BDShopCounponListViewController ()<BDShopCounponCellDelegate>
@property (nonatomic,strong) NSMutableArray *listDataArray;
@end

@implementation BDShopCounponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataAndViews];
    
    [self fetchCounponListData];
}

- (void)initDataAndViews {
    
    self.title = @"小店优惠卡";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:kBDShopCounponCell bundle:nil] forCellReuseIdentifier:kBDShopCounponCell];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView zm_layoutLeft:0.0f
                            width:self.view.zm_width];
//    [self.tableView zm_layoutTop:0.0f
//                          height:self.view.zm_height - (ViewSafeAreaInsets(self.view).bottom )];
}

- (void)refreshData {
//    self.currentPage = 1;
    [self.listDataArray removeAllObjects];
    [self fetchCounponListData];
}

- (void)loadMoreData {
    [self fetchCounponListData];
}

- (void)fetchCounponListData {
    
//    NSString *url;
//    NSDictionary *param;
//    if (self.isMyshop) {
//        url = self.type == BDShopCouponTypeCollect ? GetFavotiteListUrl:MyStoreCardUrl;
//    }else {
//        url = StoreCardUrl;
//    }
//
//    if (self.type == BDShopCouponTypeCollect) {
//        param = @{
//                  @"subjectType":@"STORECARD",
//                  @"key":@"",
//                  @"pageNum":@(self.currentPage),
//                  @"pageSize":@(self.pageOffSet)
//                  };
//    }else {
//        param = @{
//                  @"storeId":self.isMyshop ?@"":self.shopId,
//                  @"pageNo":@(self.currentPage),
//                  @"pageSize":@(self.pageOffSet),
//                  };
//    }
//
//    [HUDTool showLoading];
//    [HttpRequestDataTool GET:url
//                       params:param
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          [self endLoading];
//                          NSArray *modelArray;
//                          if (self.type == BDShopCouponTypeCollect) {
//                              modelArray = [BDShopCounponCollectListModel zm_modelArrayFromJsonArray:[response valueForKeyPath:@"data.result"]];
//                          }else {
//                              modelArray = [BDShopCounponListModel zm_modelArrayFromJsonArray:[response valueForKeyPath:@"data.result"]];
//                          }
//                          if (self.currentPage == 1) {
//                              self.listDataArray = [NSMutableArray arrayWithArray:modelArray];
//                          }
//                          else {
//                              [self.listDataArray addObjectsFromArray:modelArray];
//                          }
//                          if (modelArray.count < self.pageOffSet) {
//                              [self.refreshFooter endRefreshingWithNoMoreData];
//                          }
//                          self.showsDataNoDataView = self.listDataArray.count > 0 ? NO:YES;
//                          self.currentPage += 1;
//                          [self.tableView reloadData];
//    } failure:^(id response) {
//        [self endLoading];
//    }];
}

#pragma mark - BDShopCounponCellDelegate
- (void)buttonTapWithModel:(BDShopCounponListModel *)model isMyShop:(BOOL)isMyShop {
    if (isMyShop) {
        BDShopCounponDetailViewController *vc = [[BDShopCounponDetailViewController alloc] init];
        if (self.isMyshop && self.type == BDShopCouponTypeCollect) {
            vc.type = BDShopCardSelf;
        }else {
            vc.type = BDShopCardOther;
        }
        vc.storeCardId = model.storeCardId;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self collectOrCancelCollectCounponWithModel:model];
    }
}

#pragma mark - tableViewDataSorse Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BDShopCounponCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBDShopCounponCell];
    cell.delegate = self;
    cell.isMyShop = self.isMyshop;
    if (self.type == BDShopCouponTypeCollect) {
        BDShopCounponCollectListModel *collectListModel = self.listDataArray[indexPath.section];
        cell.model = collectListModel.counponListModel;
    }else {
        cell.model = self.listDataArray[indexPath.section];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BDShopCounponDetailViewController *vc = [[BDShopCounponDetailViewController alloc] init];
    if (self.isMyshop && self.type != BDShopCouponTypeCollect) {
        vc.type = BDShopCardSelf;
    }else {
        vc.type = BDShopCardOther;
    }
    BDShopCounponListModel *model = self.listDataArray[indexPath.section];
    BDShopCounponCollectListModel *collectListModel = self.listDataArray[indexPath.section];
    if (self.type == BDShopCouponTypeCollect) {
      vc.storeCardId = collectListModel.counponListModel.storeCardId;
    }else {
      vc.storeCardId = model.storeCardId;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isMyshop && self.type == BDShopCouponTypeCollect) {
        return YES;
    }else {
        return NO;
    }
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive)
                                                                            title:@"删除"
                                                                          handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                              [self deleteCounponWithModel:self.listDataArray[indexPath.section]];
                                                                          }];
//    deleteAction.backgroundColor = COLOR_TABLEVIEWEDITDELETE;
    return @[deleteAction];
}

/*删除*/
- (void)deleteCounponWithModel:(BDShopCounponCollectListModel *)model {
    
//    [HUDTool showLoading];
//    [HttpRequestDataTool POST:CircleCollectUrl
//                       params:@{@"subjectType":@"STORECARD",@"subjectKey":model.counponListModel.storeCardId}
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          [HUDTool showSuccessWithHint:@"删除成功"];
//                          [self.listDataArray removeObject:model];
//                          self.showsDataNoDataView = self.listDataArray.count > 0 ? NO:YES;
//                          [self.tableView reloadData];
//    } failure:^(id response) {
//        [HUDTool dismissHud];
//    }];
}

/*收藏取消收藏*/
- (void)collectOrCancelCollectCounponWithModel:(BDShopCounponListModel *)model {
    
//    [HUDTool showLoading];
//    [HttpRequestDataTool POST:CircleCollectUrl
//                       params:@{@"subjectType":@"STORECARD",@"subjectKey":model.storeCardId}
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          [HUDTool dismissHud];
//                          if (model.isCollection) {
//                              [HUDTool showSuccessWithHint:@"已取消收藏"];
//                              model.isCollection = NO;
//                          }else {
//                              [HUDTool showSuccessWithHint:@"已收藏"];
//                              model.isCollection = YES;
//                          }
//                          [self.tableView reloadData];
//                      } failure:^(id response) {
//                          [HUDTool dismissHud];
//                      }];
}

#pragma mark - LazyLoad
- (NSMutableArray *)listDataArray {
    if (!_listDataArray) {
        _listDataArray = [[NSMutableArray alloc] init];
    }
    return _listDataArray;
}
@end
