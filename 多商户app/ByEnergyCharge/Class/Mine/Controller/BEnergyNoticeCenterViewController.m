//
//  BEnergyNoticeCenterViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/12/31.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyNoticeCenterViewController.h"
#import "BEnergySystemNoticeListViewController.h"
#import "BEnergyActivityCenterListViewController.h"
#import "SDCycleScrollView.h"
#import "BEnergyNoticeCenterViewModel.h"
#import "BEnergyNoticeCenterModel.h"
#import "UIButton+HitRec.h"
@interface BEnergyNoticeCenterViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (nonatomic, strong) NSMutableArray <BEnergyNoticeCenterModel *> *noticeModelArray;
@property(nonatomic, strong)BEnergyNoticeCenterViewModel *noticeCenterViewModel;
@end

@implementation BEnergyNoticeCenterViewController
- (instancetype)init {
    return [BEnergyNoticeCenterViewController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self bindViewModel];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
    
}

- (void)bindViewModel {
    
    ByEnergyWeakSekf
    [[[[self.noticeCenterViewModel.hnNoticeCenterCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.noticeCenterViewModel.result) {
        }
        NSMutableArray *imageArray = [NSMutableArray new];
        for (BEnergyNoticeCenterModel *model in self.noticeCenterViewModel.datasArray) {
            [imageArray addObject:model.imgUrl];
            [self.noticeModelArray addObject:model];
        }
        self.bannerView.imageURLStringsGroup = imageArray;
    }];
    
    NSMutableDictionary *tagInfo = [NSMutableDictionary dictionary];
    [tagInfo setObject:[BEnergyAppStorage sharedInstance].userCityId forKey:@"city"];
    [tagInfo setObject:@(500)forKey:@"useType"];
    [tagInfo setObject:@(0) forKey:@"isPopup"];
    [tagInfo setObject:@(1) forKey:@"page"];
    [tagInfo setObject:@(20) forKey:@"pagecount"];
    [self.noticeCenterViewModel.hnNoticeCenterCommand execute:tagInfo];
}

- (void)initDataAndViews {
    self.bannerView.delegate = self;
    self.navigationItem.title = @"消息中心";
    self.titleColorM = [UIColor blackColor];
    self.view.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#edeeee"];
    //    self.navigationBarBackgroundM = UIColor.byEnergyNaiBarBackgroungColor;
  
}

- (void)backBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc showSheetStylePickerViewWithLastText:@"类别"];
}

#pragma mark ----- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.noticeModelArray[index].refType == 1) {
        ByEnergyBaseWebVc *vc = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:nil
                                                                               title:@""
                                                                             baseUrl:byEnergyClearNilStr(self.noticeModelArray[index].srcUrl)
                                                                              params:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.noticeModelArray[index].refType == 3) {
        [self.navigationController pushViewController:[BEnergySystemNoticeListViewController new] animated:YES];
    }
}

#pragma mark ----- action
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[BEnergySystemNoticeListViewController new] animated:YES];
        }else {
            [self.navigationController pushViewController:[BEnergyActivityCenterListViewController new] animated:YES];
        }
    }
}

#pragma mark - LazyLoad
LCFLazyload(BEnergyNoticeCenterViewModel, noticeCenterViewModel)

- (NSMutableArray<BEnergyNoticeCenterModel *> *)noticeModelArray {
    if (!_noticeModelArray) {
        _noticeModelArray = [NSMutableArray new];
    }
    return _noticeModelArray;
}


/*
 UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
 [btn setImage:IMAGEWITHNAME(@"btn_return") forState:UIControlStateNormal];
 [btn setImage:IMAGEWITHNAME(@"btn_return") forState:UIControlStateHighlighted];
 btn.frame = CGRectMake(0, 0, 30, 30);
 [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
 ByEnergyWeakSekf
 [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
 ByEnergyStrongSelf
 [self.navigationController popViewControllerAnimated:YES];
 }];
 btn.hitEdgeInsets = UIEdgeInsetsMake(-15, -15, -15, -20);
 UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
 self.navigationItem.leftBarButtonItem = leftButtonItem;
 */
@end
