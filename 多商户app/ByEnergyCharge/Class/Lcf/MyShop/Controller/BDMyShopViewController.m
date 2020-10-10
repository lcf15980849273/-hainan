//
//  BDMyShopViewController.m
//  bydeal
//
//  Created by chenfeng on 2018/12/25.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDMyShopViewController.h"
#import "BDMyShopCell.h"
#import "BDMyShopSectionHeaderView.h"
#import "BDMyShopParamModel.h"
#import "BDShopInfoViewController.h"
#import "BDdataEmptyCell.h"
#import "BDShopInfoViewController.h"
//#import "BDIndustryPickView.h"
#import "BDShopCounponViewController.h"
//#import "BDPickerView.h"
//#import "BDDistributionGoodsController.h"
//#import "BDGoodsCategoryController.h"
//#import "BDGoodsSearchViewController.h"
//#import "BDGoodsModel.h"
//#import "BDShopPreViewListController.h"
//#import "BDGoodsCell.h"
#import "BDCityBusinessModel.h"
//#import "BDShopDetailController.h"
//#import "NSDate+ZXDateFormatter.h"
//#import "BDSuppliersMessageViewController.h"
//#import "BDMyResultViewController.h"

#import "BDProblemFeedbackController.h"
#import "BDRunOrderController.h"


@interface BDMyShopViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BDMyShopSectionHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *headercollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, assign) NSInteger currentPage; // 当前页码、下标默认从1开始。
@property (nonatomic, assign) NSInteger pageOffSet; // 每页请求数。
@property (nonatomic, strong) UIButton *previewButton;
@property (nonatomic,assign) BDMyShopTableType type;
@property (nonatomic,strong) BDMyShopSectionHeaderView *headerView;
@property (nonatomic,strong) BDMyShopParamModel *onlineParamModel;
@property (nonatomic,strong) BDMyShopParamModel *waitOnlineParamModel;
//@property (nonatomic,strong) NSMutableArray <BDGoodsModel *>*onlineDataArray;
//@property (nonatomic,strong) NSMutableArray <BDGoodsModel *>*waitOnlineDataArray;
@property (nonatomic,strong) NSMutableArray <NSString *>*businessArray;//上架公司名称数组
@property (nonatomic,strong) NSMutableArray <BDBusinessItemModel *>*businessModelArray;//上架公司模型数据包含ID
@property (nonatomic,strong) NSMutableArray *cityArray;//上架城市名称数组

@property (nonatomic,strong) NSMutableArray <NSString *>*waitBusinessArray;//下架公司名称数组
@property (nonatomic,strong) NSMutableArray <BDBusinessItemModel *>*waitBusinessModelArray;//下架公司模型数据包含ID
@property (nonatomic,strong) NSMutableArray *waitCityArray;//下架城市名称数组

@property (nonatomic,copy) NSString *shopId;
@property (nonatomic,strong) BDCityBusinessModel *cityBusinessModel;
@property (nonatomic,strong) BDCityBusinessModel *waitCityBusinessModel;
@property (nonatomic,assign) BOOL isNeedRefresh;//是否需要刷新
@end

@implementation BDMyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshData];
    
}

- (void)initDataAndViews {
    
     self.title = @"我的小店";
    self.pageOffSet = 20;
    self.currentPage = self.onlineParamModel.currentPage;
    self.type = BDMyShopTableTypeOnline;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = APPGrayColor;
//    self.tableView.zm_header = self.refreshHeader;
//    self.tableView.zm_footer = self.refreshFooter;
    self.headercollectionView.delegate = self;
    self.headercollectionView.dataSource = self;
    self.collectionViewLayout.minimumLineSpacing = 0.0f;
    self.collectionViewLayout.minimumInteritemSpacing = 0.0f;
    self.headercollectionView.scrollEnabled = NO;
    self.collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0,0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.previewButton];
    [self.headercollectionView registerNib:[UINib nibWithNibName:kBDMyShopCell bundle:nil] forCellWithReuseIdentifier:kBDMyShopCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBDdataEmptyCell bundle:nil] forCellReuseIdentifier:kBDdataEmptyCell];
    
}

- (void)handlePreiewButtonTaped {
//    BDShopPreViewListController *vc = [[BDShopPreViewListController alloc] init];
//    vc.storeId = self.shopId;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadMoreData {
    [self fetchListData];
}


- (void)refreshData {
    
    if (self.type == BDMyShopTableTypeOnline) {
        self.onlineParamModel.currentPage = 1;
        self.currentPage = self.onlineParamModel.currentPage;
    }else {
        self.waitOnlineParamModel.currentPage = 1;
        self.currentPage = self.waitOnlineParamModel.currentPage;
    }
    [self fetchListData];
}

- (void)fetchListData {
    
    
//    NSDictionary *param = @{
//                            @"searchStr":@"",
//                            @"cityCode":self.type == BDMyShopTableTypeOnline ? self.onlineParamModel.cityCode:self.waitOnlineParamModel.cityCode,
//                            @"businessId":self.type == BDMyShopTableTypeOnline ? self.onlineParamModel.businessId:self.waitOnlineParamModel.businessId,
//                            @"mainCategoryId":self.type == BDMyShopTableTypeOnline ? self.onlineParamModel.mainCategoryId:self.waitOnlineParamModel.mainCategoryId,
//                            @"isPutaway":self.type == BDMyShopTableTypeOnline ? @(YES):@(NO),
//                            @"pageNum":@(self.currentPage),
//                            @"pageSize":@(self.pageOffSet),
//                            };
    
//    [HUDTool showLoading];
//    [HttpRequestDataTool GET:GetStoreMainListUrl
//                       params:param
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          [self endLoading];
//                          [self checkShopInfoWithID:response[@"data"][@"storeId"]];
//                          self.onlineParamModel.outNum = [response[@"data"][@"outNum"] integerValue];
//                          self.onlineParamModel.putNum = [response[@"data"][@"putNum"] integerValue];
//                          self.waitOnlineParamModel.outNum = [response[@"data"][@"outNum"]integerValue];
//                          self.waitOnlineParamModel.putNum = [response[@"data"][@"putNum"]integerValue];
//                          NSArray *modelArray = [BDGoodsModel zm_modelArrayFromJsonArray:[response valueForKeyPath:@"data.result"]];
//                          if (self.type == BDMyShopTableTypeOnline) {
//                              if (self.currentPage == 1) {
//                                  self.onlineDataArray = [NSMutableArray arrayWithArray:modelArray];
//                              }
//                              else {
//                                  [self.onlineDataArray addObjectsFromArray:modelArray];
//                              }
//                              self.onlineParamModel.currentPage += 1;
//                              self.currentPage = self.onlineParamModel.currentPage;
//                          }
//                          else {
//                              if (self.currentPage == 1) {
//                                  self.waitOnlineDataArray = [NSMutableArray arrayWithArray:modelArray];
//                              }
//                              else {
//                                  [self.waitOnlineDataArray addObjectsFromArray:modelArray];
//                              }
//                              self.waitOnlineParamModel.currentPage += 1;
//                              self.currentPage = self.waitOnlineParamModel.currentPage;
//                          }
//                          if (modelArray.count < self.pageOffSet) {
//                              [self.refreshFooter endRefreshingWithNoMoreData];
//                          }
//
//                          if (self.type == BDMyShopTableTypeWaitOnline) {
//                              self.headerView.redView.hidden = YES;
//                          }else {
//                              if ([response[@"data"][@"noReadNum"] integerValue] == 0) {
//                                  self.headerView.redView.hidden = YES;
//                              }else {
//                                  self.headerView.redView.hidden = NO;
//                              }
//                          }
//
//                          if (self.cityArray.count == 0) {
//                             [self fetchCityBusinessData];
//                          }
//                          [self.tableView reloadData];
//    } failure:^(id response) {
//        [HUDTool showErrorWithHint:@"请求失败，请重试"];
//    }];
}

/*获取城市商号联动数据*/
- (void)fetchCityBusinessData {
    NSDictionary *param = @{
                            @"storeId":self.shopId,
                            @"isPutaway":self.type == BDMyShopTableTypeOnline ? @(YES):@(NO)
                            };
//    [HttpRequestDataTool GET:StoreOutBusinessUrl
//                       params:param
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          
//                          if (self.type == BDMyShopTableTypeOnline) {//上架城市联动
//                              if (self.cityArray.count > 0) {
//                                  [self.cityArray removeAllObjects];
//                              }
//                              if (self.businessArray.count > 0) {
//                                  [self.businessArray removeAllObjects];
//                                  [self.businessModelArray removeAllObjects];
//                              }
//                              self.cityBusinessModel = [BDCityBusinessModel zm_modelFromJson:response[@"data"]];
//                              for (BDCityModel *model in self.cityBusinessModel.citys) {
//                                  [self.cityArray addObject:model.city];
//                              }
//                              for (BDCityModel *model in self.cityBusinessModel.citys) {
//                                  if ([model.cityKey isEqualToString:@""]) {
//                                      for (BDBusinessModel *businessModel in self.cityBusinessModel.business) {
//                                          for (BDBusinessItemModel *itemModel in businessModel.business) {
//                                              [self.businessArray addObject:itemModel.businessName];
//                                              [self.businessModelArray addObject:itemModel];
//                                          }
//                                      }
//                                  }
//                              }
//                              [self addOnlineAllOpreation];
//                          }else {//待上架城市联动
//                              if (self.waitCityArray.count > 0) {
//                                  [self.waitCityArray removeAllObjects];
//                              }
//                              if (self.waitBusinessArray.count > 0) {
//                                  [self.waitBusinessArray removeAllObjects];
//                                  [self.waitBusinessModelArray removeAllObjects];
//                              }
//                              self.waitCityBusinessModel = [BDCityBusinessModel zm_modelFromJson:response[@"data"]];
//                              for (BDCityModel *model in self.waitCityBusinessModel.citys) {
//                                  [self.waitCityArray addObject:model.city];
//                              }
//                              for (BDCityModel *model in self.waitCityBusinessModel.citys) {
//                                  if ([model.cityKey isEqualToString:@""]) {
//                                      for (BDBusinessModel *businessModel in self.waitCityBusinessModel.business) {
//                                          for (BDBusinessItemModel *itemModel in businessModel.business) {
//                                              [self.waitBusinessArray addObject:itemModel.businessName];
//                                              [self.waitBusinessModelArray addObject:itemModel];
//                                          }
//                                      }
//                                  }
//                              }
//                              [self addwaitOnlineAllOpreation];
//                          }
//    } failure:^(id response) {
//        
//    }];
}

#pragma mark - BDMyShopSectionHeaderViewDelegate
- (void)onLineViewTapWithType:(BDMyShopTableType)type {
    self.type = type;
   
    self.currentPage = self.onlineParamModel.currentPage;
    self.isNeedRefresh = NO;
    [self.tableView reloadData];
}

- (void)waitOnLineViewTapWithType:(BDMyShopTableType)type {
    self.type = type;

    self.currentPage = self.waitOnlineParamModel.currentPage;
    self.isNeedRefresh = NO;
    if (self.waitBusinessArray.count == 0) {
        [self fetchCityBusinessData];//切到待上架重新请求商号联动数据
    }
    [self.tableView reloadData];
}

/*地址筛选*/
- (void)addressViewTapWithType:(BDMyShopTableType)type {
    self.type = type;
//    BDPickerView *pickView = [[BDPickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    if (type == BDMyShopTableTypeOnline) {
//        pickView.dataArray = self.cityArray;
//    }else {
//        pickView.dataArray = self.waitCityArray;
//    }
//    ByEnergyWeakSekf;
//    [pickView setSelectBlock:^(NSInteger index) {
//        ByEnergyStrongSelf;
//        if (type == BDMyShopTableTypeOnline) {//上架城市联动
//            if (self.businessArray.count > 0) {
//                [self.businessArray removeAllObjects];
//                [self.businessModelArray removeAllObjects];
//            }
//            if (![self.cityArray[index] isEqualToString:@"全国"]) {
//                for (BDBusinessModel *model in self.cityBusinessModel.business) { //获取某个城市所属商号
//                    if ([model.cityKey isEqualToString:self.cityBusinessModel.citys[index].cityKey]) {
//                        for (BDBusinessItemModel *itemModel in model.business) {
//                            [self.businessArray addObject:itemModel.businessName];
//                            [self.businessModelArray addObject:itemModel];
//                        }
//                    }
//                }
//            }else {
//                for (BDCityModel *model in self.cityBusinessModel.citys) { //获取全国时所有商号
//                    if ([model.cityKey isEqualToString:@""]) {
//                        for (BDBusinessModel *businessModel in self.cityBusinessModel.business) {
//                            for (BDBusinessItemModel *itemModel in businessModel.business) {
//                                [self.businessArray addObject:itemModel.businessName];
//                                [self.businessModelArray addObject:itemModel];
//                            }
//                        }
//                    }
//                }
//            }
//            [self addOnlineAllOpreation];
//            self.onlineParamModel.city = self.cityArray[index];
//            self.onlineParamModel.cityCode = self.cityBusinessModel.citys[index].cityKey;
//            self.onlineParamModel.businessName = @"商号筛选";
//            self.onlineParamModel.typeName = @"类目筛选";
//            self.onlineParamModel.businessId = @"";
//            self.onlineParamModel.mainCategoryId = @"";
//        }else {//待上架城市联动
//            if (self.waitBusinessArray.count > 0) {
//                [self.waitBusinessArray removeAllObjects];
//                [self.waitBusinessModelArray removeAllObjects];
//            }
//            if (![self.waitCityArray[index] isEqualToString:@"全国"]) {
//                for (BDBusinessModel *model in self.waitCityBusinessModel.business) { //获取某个城市所属商号
//                    if ([model.cityKey isEqualToString:self.waitCityBusinessModel.citys[index].cityKey]) {
//                        for (BDBusinessItemModel *itemModel in model.business) {
//                            [self.waitBusinessArray addObject:itemModel.businessName];
//                            [self.waitBusinessModelArray addObject:itemModel];
//                        }
//                    }
//                }
//            }else {
//                for (BDCityModel *model in self.waitCityBusinessModel.citys) { //获取全国时所有商号
//                    if ([model.cityKey isEqualToString:@""]) {
//                        for (BDBusinessModel *businessModel in self.waitCityBusinessModel.business) {
//                            for (BDBusinessItemModel *itemModel in businessModel.business) {
//                                [self.waitBusinessArray addObject:itemModel.businessName];
//                                [self.waitBusinessModelArray addObject:itemModel];
//                            }
//                        }
//                    }
//                }
//            }
//            [self addwaitOnlineAllOpreation];
//            self.waitOnlineParamModel.city = self.waitCityArray[index];
//            self.waitOnlineParamModel.cityCode = self.waitCityBusinessModel.citys[index].cityKey;
//            self.waitOnlineParamModel.businessName = @"商号筛选";
//            self.waitOnlineParamModel.typeName = @"类目筛选";
//            self.waitOnlineParamModel.businessId = @"";
//            self.waitOnlineParamModel.mainCategoryId = @"";
//        }
//        [self refreshData];
//    }];
//    [pickView show];
//
}

- (void)addOnlineAllOpreation {
    BDBusinessItemModel *addModel = [[BDBusinessItemModel alloc] init];
    addModel.businessName = @"全部";
    addModel.businessId = @"";
    [self.businessArray insertObject:addModel.businessName atIndex:0];
    [self.businessModelArray insertObject:addModel atIndex:0];
}

- (void)addwaitOnlineAllOpreation {
    BDBusinessItemModel *addModel = [[BDBusinessItemModel alloc] init];
    addModel.businessName = @"全部";
    addModel.businessId = @"";
    [self.waitBusinessArray insertObject:addModel.businessName atIndex:0];
    [self.waitBusinessModelArray insertObject:addModel atIndex:0];
}

/*类目筛选*/
- (void)typeViewTapWithType:(BDMyShopTableType)type {
    self.type = type;
    [self.view endEditing:YES];
//    BDIndustryPickView *industryPickView = [[BDIndustryPickView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withListType:BDCategoryType];
//    industryPickView.delegate = self;
//    [industryPickView show];
}

/*商号筛选*/
- (void)bussinessViewTapWithType:(BDMyShopTableType)type {
    self.type = type;
//    BDPickerView *pickView = [[BDPickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    if (type == BDMyShopTableTypeOnline) {
//        pickView.dataArray = self.businessArray;
//    }else {
//        pickView.dataArray = self.waitBusinessArray;
//    }
//    ByEnergyWeakSekf;
//    [pickView setSelectBlock:^(NSInteger index) {
//        ByEnergyStrongSelf;
//        if (type == BDMyShopTableTypeOnline) {
//            if (self.businessArray.count == 0) {
//                return;
//            }
//        }else {
//            if (self.waitBusinessArray.count == 0) {
//                return;
//            }
//        }
//        if (type == BDMyShopTableTypeOnline) {
//            if ([self.businessArray[index] isEqualToString:@"全部"]) {
//                self.onlineParamModel.businessName = @"商号筛选";
//            }else {
//                self.onlineParamModel.businessName = self.businessArray[index];
//            }
//            self.onlineParamModel.businessId = self.businessModelArray[index].businessId;
//        }else {
//            if ([self.waitBusinessArray[index] isEqualToString:@"全部"]) {
//                self.waitOnlineParamModel.businessName = @"商号筛选";
//            }else {
//                self.waitOnlineParamModel.businessName = self.waitBusinessArray[index];
//            }
//            self.waitOnlineParamModel.businessId = self.waitBusinessModelArray[index].businessId;
//        }
//        [self refreshData];
//    }];
//    [pickView show];
    
}

/*搜索*/
- (void)searchViewTapWithType:(BDMyShopTableType)type {
//    BDGoodsSearchViewController *vc = [[BDGoodsSearchViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - BDIndustryPickViewDelegate
//- (void)selectedIndustry:(BDIndustryModel *)industry
//          AndSubIndustry:(BDSubIndustryModel *)subIndustry
//          AndSelectValue:(BDIndustrySelectValueModel *)value
//             withAllName:(NSString *)rea {
//
//    if (self.type == BDMyShopTableTypeOnline) {
//        self.onlineParamModel.typeName = [subIndustry.title isEqualToString:@"全部"] ? @"类目筛选":subIndustry.title;
//        self.onlineParamModel.mainCategoryId = subIndustry.ID == 0 ? @"":[NSString stringWithFormat:@"%ld",subIndustry.ID];
//    }else {
//        self.waitOnlineParamModel.typeName = [subIndustry.title isEqualToString:@"全部"] ? @"类目筛选":subIndustry.title;
//        self.waitOnlineParamModel.mainCategoryId = subIndustry.ID == 0 ? @"":[NSString stringWithFormat:@"%ld",subIndustry.ID];
//    }
//    [self refreshData];
//}

#pragma mark - tableViewDataSorse Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 195.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 149.0f;
    }
    return 0.001f;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
//    BDDiscussNoDataView *noDataView = [[BDDiscussNoDataView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,200)];
//    noDataView.backgroundColor = BDWhiteColor;
//    noDataView.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    if (self.type == BDMyShopTableTypeOnline) {
//        noDataView.titleLab.text = @"暂时没有商品~";
//        noDataView.imageView.image = BDImageNamed(@"partner_icon_noproduct");
//        return self.onlineDataArray.count == 0 ? noDataView:nil;
//    }else {
//        noDataView.titleLab.text = @"还没有商品，快去选货~";
//        noDataView.imageView.image = BDImageNamed(@"xuanhuo");
//        ByEnergyWeakSekf;
//        [noDataView.imageView zm_performActionOnTap:^(__kindof UIView *view) {
//            ByEnergyStrongSelf;
//            BDDistributionGoodsController *vc = [[BDDistributionGoodsController alloc] init];
//            vc.type = BDDistributionGoodsControllerTypeDistribution;
//            [vc setDidClickReturnBlock:^{
//                ByEnergyStrongSelf;
//                [self fetchCityBusinessData];
//            }];
//            [self.navigationController pushViewController:vc animated:YES];
//        }];
//        return self.waitOnlineDataArray.count == 0 ? noDataView:nil;
//    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        self.headerView.delegate = self;
        self.headerView.paramModel = self.type == BDMyShopTableTypeOnline ? self.onlineParamModel:self.waitOnlineParamModel;
        return self.headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

#pragma mark -CollectionViewDelegate、DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREENHEIGHT / 4, 97);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDMyShopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBDMyShopCell forIndexPath:indexPath];
    cell.index = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)endLoading {
    
//    [HUDTool dismissHud];
//    [self.refreshHeader endRefreshing];
//    [self.refreshFooter endRefreshing];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)checkShopInfoWithID:(NSString *)shopId {
    self.shopId = shopId;
   
}

#pragma mark - lazyLoad
- (BDMyShopSectionHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BDMyShopSectionHeaderView alloc] init];
    }
    return _headerView;
}

- (BDMyShopParamModel *)onlineParamModel {
    if (!_onlineParamModel) {
        _onlineParamModel = [[BDMyShopParamModel alloc] init];
        _onlineParamModel.city = @"全国";
        _onlineParamModel.cityCode = @"";
        _onlineParamModel.businessName = @"商号筛选";
        _onlineParamModel.typeName = @"类目筛选";
        _onlineParamModel.currentPage = 1;
        _onlineParamModel.businessId = @"";
        _onlineParamModel.mainCategoryId = @"";
    }
    return _onlineParamModel;
}

- (BDMyShopParamModel *)waitOnlineParamModel {
    if (!_waitOnlineParamModel) {
        _waitOnlineParamModel = [[BDMyShopParamModel alloc] init];
        _waitOnlineParamModel.city = @"全国";
        _waitOnlineParamModel.cityCode = @"";
        _waitOnlineParamModel.businessName = @"商号筛选";
        _waitOnlineParamModel.typeName = @"类目筛选";
        _waitOnlineParamModel.currentPage = 1;
        _waitOnlineParamModel.businessId = @"";
        _waitOnlineParamModel.mainCategoryId = @"";
    }
    return _waitOnlineParamModel;
}

- (NSMutableArray <NSString *>*)businessArray {
    if (!_businessArray) {
        _businessArray = [NSMutableArray new];
    }
    return _businessArray;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [[NSMutableArray alloc] init];
    }
    return _cityArray;
}

- (NSMutableArray<BDBusinessItemModel *> *)businessModelArray {
    if (!_businessModelArray) {
        _businessModelArray = [[NSMutableArray alloc] init];
    }
    return _businessModelArray;
}

- (NSMutableArray <NSString *>*)waitBusinessArray {
    if (!_waitBusinessArray) {
        _waitBusinessArray = [NSMutableArray new];
    }
    return _waitBusinessArray;
}

- (NSMutableArray *)waitCityArray {
    if (!_waitCityArray) {
        _waitCityArray = [[NSMutableArray alloc] init];
    }
    return _waitCityArray;
}

- (NSMutableArray<BDBusinessItemModel *> *)waitBusinessModelArray {
    if (!_waitBusinessModelArray) {
        _waitBusinessModelArray = [[NSMutableArray alloc] init];
    }
    return _waitBusinessModelArray;
}

- (BDCityBusinessModel *)cityBusinessModel {
    if (!_cityBusinessModel) {
        _cityBusinessModel = [[BDCityBusinessModel alloc] init];
    }
    return _cityBusinessModel;
}

- (BDCityBusinessModel *)waitCityBusinessModel {
    if (!_waitCityBusinessModel) {
        _waitCityBusinessModel = [[BDCityBusinessModel alloc] init];
    }
    return _waitCityBusinessModel;
}

- (UIButton *)previewButton {
    if (!_previewButton) {
        _previewButton =  [UIButton zm_buttonWithTitle:@"小店预览"
                                                 frame:CGRectMake(0.0f, 0.0f, 100.0f, 44.0f)
                                                 image:nil
                                                 color:APPGrayColor
                                                  font:ByEnergyRegularFont(16.0f)];
        _previewButton.titleEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        [_previewButton addTarget:self
                           action:@selector(handlePreiewButtonTaped)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _previewButton;
}


@end

