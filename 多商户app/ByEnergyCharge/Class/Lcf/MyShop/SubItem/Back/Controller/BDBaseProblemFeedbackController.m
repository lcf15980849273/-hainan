//
//  BDBaseProblemFeedbackController.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDBaseProblemFeedbackController.h"
#import "BDProblemFeedbackModel.h"
#import "BDProblemFeedbackCell.h"
//#import <UITableView+FDTemplateLayoutCell.h>
#import "BDProblemFeedbackReplyCell.h"

@interface BDBaseProblemFeedbackController ()

@property (nonatomic, strong) NSMutableArray<BDProblemFeedbackModel *> *dataArray;

@end

@implementation BDBaseProblemFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadData];
}

- (void)refreshData {
//    [super refreshData];
    [self loadData];
}

- (void)loadMoreData {
//    [super loadMoreData];
    [self loadData];
}


- (void)setupView {
   self.tableView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - NavigationStatusBarHeight  - 34);
   [self.tableView registerNib:[UINib nibWithNibName:kBDProblemFeedbackCell bundle:nil] forCellReuseIdentifier:kBDProblemFeedbackCell];
   [self.tableView registerNib:[UINib nibWithNibName:kBDProblemFeedbackReplyCell bundle:nil] forCellReuseIdentifier:kBDProblemFeedbackReplyCell];
}


- (void)loadData {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    NSDictionary *params = @{
//                             @"pageNo" : @(self.currentPage),
//                             @"pageSize" : @(self.pageOffSet),
//                             @"isReply" : @(self.type)
//                             };
//    ByEnergyWeakSekf;
//    [HttpRequestDataTool GET:ProblemListUrl params:params tokenState:ApiTokenUploadStateOptional success:^(id response) {
//        ByEnergyStrongSelf;
//        // NSArray *result = self.isHandDeal ? response[@"data"][@"content"] : response[@"data"][@"result"];
//        NSArray *result = response[@"data"][@"result"];
//        [self endLoading];
//        if (result.count > 0) {
//            if (self.currentPage == 1) {
//                [self.dataArray removeAllObjects];
//            }
//            self.showsDataNoDataView = NO;
//            self.currentPage++;
//            NSArray *arr = [NSArray yy_modelArrayWithClass:[BDProblemFeedbackModel class] json:result];
//            [self.dataArray addObjectsFromArray:arr];
//            [self.tableView reloadData];
//
//        }else {
//            [self.refreshFooter endRefreshingWithNoMoreData];
//            if (self.currentPage == 1) {
//                self.showsDataNoDataView = YES;
//                [self.dataArray removeAllObjects];
//                [self.tableView reloadData];
//            }
//        }
//    } failure:^(id response) {
//        [self endLoading];
//        self.showsDataNoDataView = YES;
//    }];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) { // 待回复
        BDProblemFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:kBDProblemFeedbackCell forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.section];
        return cell;
    }
    
    BDProblemFeedbackReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:kBDProblemFeedbackReplyCell forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.section];
    ByEnergyWeakSekf;
    cell.clickFullBtnBlock = ^(BDProblemFeedbackReplyCell *cell) {
        ByEnergyStrongSelf;
        [self.tableView reloadData];
    };
    
    cell.clickFullReplyBtnBlock = ^(BDProblemFeedbackReplyCell * _Nonnull cell) {
        ByEnergyStrongSelf;
        [self.tableView reloadData];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.type == 0) {
//        return [tableView fd_heightForCellWithIdentifier:kBDProblemFeedbackCell configuration:^(BDProblemFeedbackCell *cell) {
//            cell.model = self.dataArray[indexPath.section];
//        }];
//    }
//
//    return [tableView fd_heightForCellWithIdentifier:kBDProblemFeedbackReplyCell configuration:^(BDProblemFeedbackReplyCell *cell) {
//        cell.model = self.dataArray[indexPath.section];
//    }];
//}


#pragma mark - Lazy Load

- (NSMutableArray<BDProblemFeedbackModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
