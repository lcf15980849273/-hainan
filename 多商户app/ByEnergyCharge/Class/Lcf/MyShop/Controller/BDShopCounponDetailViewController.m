//
//  BDShopCounponDetailViewController.m
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopCounponDetailViewController.h"
#import "BDShopCounponInfoCell.h"
#import "BDShopCounponDetailModel.h"
@interface BDShopCounponDetailViewController ()
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic,strong) BDShopCounponDetailModel *detailModel;

@end

@implementation BDShopCounponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self fetchCounponDetailData];
}

- (void)initDataAndViews {
    self.title = @"优惠卡详情";
//    self.refreshHeader.hidden = YES;
//    self.refreshFooter.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:self.shareButton]];
    [self.tableView registerNib:[UINib nibWithNibName:kBDShopCounponInfoCell bundle:nil] forCellReuseIdentifier:kBDShopCounponInfoCell];
    [self.tableView registerNib:[UINib nibWithNibName:kBDShopCounponIntroduceCell bundle:nil] forCellReuseIdentifier:kBDShopCounponIntroduceCell];
}

- (void)shareButtonTaped {
    
//    [ShareTool shareWithType:@"storeCard"
//                      goalId:self.detailModel.storeCardId
//                       title:nil//model.title
//                     content:nil//model.introduction
//                       image:nil];//model.logo
}

- (void)fetchCounponDetailData {
    
//    [HUDTool showLoading];
//    [HttpRequestDataTool GET:StoreCardDetailUrl
//                       params:@{@"storeCardId":self.storeCardId}
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          [HUDTool dismissHud];
//                          self.detailModel = [BDShopCounponDetailModel zm_modelFromJson:response[@"data"]];
//                          self.detailModel.isMyshop = self.type == BDShopCardSelf;
//                          [self.tableView reloadData];
//    } failure:^(id response) {
//        [HUDTool dismissHud];
//    }];
}

#pragma mark - tableViewDataSorse Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (self.detailModel.businessTel.length > 0) {
            return 300.0f;
        }else {
            return 256.0f;
        }
    }else {
        return [BDShopCounponIntroduceCell cellHeightWithModel:self.detailModel];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BDShopCounponInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBDShopCounponInfoCell];
        cell.model = self.detailModel;
        return cell;
    }else {
        BDShopCounponIntroduceCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBDShopCounponIntroduceCell];
        cell.model = self.detailModel;
        return cell;
    }
}

#pragma mark - LazyLoad

- (BDShopCounponDetailModel *)detailModel {
    if (!_detailModel) {
        _detailModel = [[BDShopCounponDetailModel alloc] init];
    }
    return _detailModel;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton =  [UIButton zm_buttonWithTitle:@"分享"
                                                 frame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)
                                                 image:nil
                                                 color:APPGrayColor
                                                  font:ByEnergyRegularFont(16.0f)];
        _shareButton.titleEdgeInsets = UIEdgeInsetsMake(0.0f, -10.0f, 0.0f, -12.0f);
        [_shareButton addTarget:self
                           action:@selector(shareButtonTaped)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _shareButton;
}
@end
