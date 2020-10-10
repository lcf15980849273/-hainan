//
//  MineTableViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/23.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "MineTableViewController.h"
#import "BEnergyUserInfoViewModel.h"
#import "BEnergySCUserStorage.h"
#import "BEnergyMyAccountInfoViewController.h"
#import "BEnergyMyCarNumberViewController.h"
#import "BEnergyMyCouponsViewController.h"
#import "BEnergyNoticeCenterViewController.h"
#import "BEnergyMyInfoViewController.h"
#import "BEnergyAppStorage.h"
#import "BEnergySystemInfoViewModel.h"
#import "BEnergyAboutUsTableController.h"
#import "BEnergyAdviceViewController.h"
#import "BEnergyChargeOrderViewController.h"
#import "CFYYViewController.h"
#import "BEnergyMyInvoiceViewController.h"
#import "SDCycleScrollView.h"
#import "ByEnergyShareViewModel.h"
#import "ByEnergyShareCouponModel.h"
@interface MineTableViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BEnergyUserInfoViewModel *userInfoViewModel;
@property (nonatomic, strong) BEnergySystemInfoViewModel *systemInfoModel;
@property (nonatomic, assign) BOOL showLoading;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *hederImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userIconTopMagin;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIView *moneyView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *shareBannerView;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (nonatomic, strong) ByEnergyShareViewModel *shareInfoViewModel;
@property (nonatomic, strong) NSData *shareCoverImageData;
@end

@implementation MineTableViewController

- (instancetype)init {
    return [MineTableViewController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.userInfoViewModel.userInfo execute:nil];
    [self.systemInfoModel.hnSystemInfoCommand execute:nil];
    [self.shareInfoViewModel.ShareWithCouponInfo execute:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self byEnergyInitDatas];
    
    [self byEnergyInitViewModel];
    
    [self byEnergySetViewLayout];
    
}

- (void)byEnergyInitDatas {
    self.statusBarStyle = UIStatusBarStyleLightContent;
    self.tableView.backgroundColor = BYENERGYCOLOR(0xf5f5f5);
    [self.view addSubview:self.titleLabel];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.zm_height = IsIphoneXLater ? 218.0f : 194.0f;
    self.hederImageView.zm_height = IsIphoneXLater ? 218.0f : 194.0f;
    self.userIconTopMagin.constant = IsIphoneXLater ? 105.5f : 81.5f;
    self.amountLabel.font = IsIphone5 ? ByEnergyRegularFont(15) : ByEnergyRegularFont(21);
    if ((BEnergyUserInfoModel *)[BEnergySCUserStorage sharedInstance].userInfo != nil && self.userInfoViewModel.value == nil) {
        self.userInfoViewModel.value = (BEnergyUserInfoModel *)[BEnergySCUserStorage sharedInstance].userInfo;
        [self cofigUIwithModel:self.userInfoViewModel.value];
    }
    self.showLoading = YES;
    
    self.shareBannerView.clipsToBounds = YES;
    self.shareBannerView.delegate = self;

    //.....
    CFYYViewController *vc = [[CFYYViewController alloc]init];
    [vc addtitle:@"" imageStr:@""];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)byEnergySetViewLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
}

- (void)byEnergyInitViewModel {
    ByEnergyWeakSekf
    RAC(self.userInfoViewModel.userInfo.netWorksModel, isHidenHUD) = [[RACChannelTo(self, showLoading) takeUntil:self.rac_willDeallocSignal] map:^id _Nullable(id  _Nullable value) {
        return [NSNumber numberWithBool:![value boolValue]];
    }];
    
    [[[[self.userInfoViewModel.userInfo
        executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        [HUDManager hidenHud];
        if (self.userInfoViewModel.result) {
            self.showLoading = NO;
            [self cofigUIwithModel:self.userInfoViewModel.value];
        }
    }];
    
    [[[[self.systemInfoModel.hnSystemInfoCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.systemInfoModel.result) {
            appAuthModel *model = [BEnergyAppStorage sharedInstance].systemInfo.auth;
            self.moneyView.hidden = [model.rechargeAmountStatus.value isEqualToString:@"1"] ? NO : YES;
        }
        [self.tableView reloadData];
    }];
    
    
    [[[[self.shareInfoViewModel.ShareWithCouponInfo executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.shareInfoViewModel.result) {
            ByEnergyShareCouponModel *model = self.shareInfoViewModel.value;
            if (model.shareCouponProjectStatus == 1) {
                self.shareBannerView.imageURLStringsGroup = @[model.shareCouponImg];
                //压缩缩略图
                [[UIImage new] byEnergyCompressWithMaxKB:32 image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.shareDetailRuleImage]]] Block:^(NSData * _Nonnull imageData) {
                    ByEnergyStrongSelf
                    self.shareCoverImageData = imageData;
                }];
            }
        }
        [self.tableView reloadData];
    }];
} 

- (void)cofigUIwithModel:(BEnergyBaseModel *)model {
    BEnergyUserInfoModel *userModel = (BEnergyUserInfoModel *)model;
    self.nickNameLabel.text = byEnergyClearNilStr(userModel.nickName);
    self.couponLabel.text = userModel.couponCount > 0 ? [NSString stringWithFormat:@"优惠券%d",userModel.couponCount] : @"优惠券";
    self.amountLabel.text = userModel.totalAmount.length > 0 ? userModel.totalAmount : @"0";
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[StringUtils resoureUrlStrWithPath:userModel.headImgUrl baseUrl:URL_BASE]] placeholderImage:IMAGEWITHNAME(@"make_pic")];
}


#pragma mark ----- scrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //CGFloat width = self.view.frame.size.width; // 图片宽度
    CGFloat yOffset = scrollView.contentOffset.y; // 偏移的y值，还要考虑导航栏的64哦
    if (yOffset < 10) {//向下拉是负值，向上是正
        //CGFloat totalOffset = 194 + ABS(yOffset);
        //CGFloat f = totalOffset / 194;//缩放比例
        // //拉伸后的图片的frame应该是同比例缩放。
        //self.hederImageView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
        self.titleLabel.hidden = NO;
    }else {
        self.titleLabel.hidden = YES;
    }
    
}

#pragma mark ----- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    BEnergyUserInfoModel *userModel = self.userInfoViewModel.value;
    ByEnergyShareCouponModel *shareCouponModel = self.shareInfoViewModel.value;
    ByEnergyBaseWebVc *operationVC = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:ApiAppUserShareUrl
                                                                                    title:@"活动详情"
                                                                                  baseUrl:URL_BASE
                                                                                   params:nil];
//    operationVC.isElastic = NO;
    operationVC.byEnergyPageFitEnabled = NO;
    operationVC.byEnergyRefreshEnabled = YES;
    ByEnergyWeakSekf
    [operationVC setShareButtonWithButtonType:^(shareButtonType type) {
        ByEnergyStrongSelf
        if (type == shareButtonTypeweChat) { //分享到微信聊天
            ShareModel *model = [[ShareModel alloc] init];
            model.controller = self;
            model.linkId = userModel.account;
            model.describ = shareCouponModel.shareDetailDescribe;
            model.shareTitle = shareCouponModel.shareCouponProjectTitle;
            model.miniImageData = self.shareCoverImageData;
            [BEnergyShareTool shareWithContentModel:model platform:UMSocialPlatformType_WechatSession useImageType:useImgeTypeUrls fromType:byEnergySharePageTypeMine];
        }else { //分享到朋友圈
            ShareModel *model = [[ShareModel alloc] init];
            model.controller = self;
            model.linkId = userModel.account;
            model.describ = shareCouponModel.shareDetailDescribe;
            model.webpageUrl = shareCouponModel.shareCouponH5;
            model.shareTitle = shareCouponModel.shareCouponProjectTitle;
            model.miniImageData = self.shareCoverImageData;
            [BEnergyShareTool shareWithContentModel:model platform:UMSocialPlatformType_WechatTimeLine useImageType:useImgeTypeUrls fromType:byEnergySharePageTypeMine];
        }
    }];
    [self.navigationController pushViewController:operationVC animated:YES];
}

#pragma mark ----- tableViewDelegate datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 89.0f;;
            break;
        case 1:
            return 50.0f;;
            break;
        case 2:
        {
            ByEnergyShareCouponModel *model = self.shareInfoViewModel.value;
            return model.shareCouponProjectStatus == 1  ? 95.0f : 0.0f;
        }
            break;
        case 3:
        {
            if (indexPath.row == 2) {
                return 55.0f;
            }else if (indexPath.row == 3) {
                NSString *value = [BEnergyAppStorage sharedInstance].systemInfo.auth.invoiceStatus.value;
                return [value isEqualToString:@"0"] ? 55.0f : 0.0f;
            }
            else {
                return 55.0f;
            }
        }
            break;
        default:
            return 0.0f;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        ByEnergyShareCouponModel *model = self.shareInfoViewModel.value;
        return model.shareCouponProjectStatus == 1  ? 10.0f : 0.0001f;
    }else {
        return 10.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self.navigationController pushViewController:[BEnergyNoticeCenterViewController new] animated:YES];
    }else if (indexPath.section == 2) {
        
    }else if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[BEnergyChargeOrderViewController new] animated:YES];
                break;
            case 1:
                //帮助中心
                [self showHelpCenter];
                break;
            case 2:
                //意见反馈
                [self.navigationController pushViewController:[BEnergyAdviceViewController new] animated:YES];
                break;
            case 3:
                //我的发票
                [self.navigationController pushViewController:[BEnergyMyInvoiceViewController new] animated:YES];
                break;
            case 4:
                //客服
                [AlertViewTools showServiceNumber];
                break;
            case 5:
                //关于我们
                [self.navigationController pushViewController:[BEnergyAboutUsTableController new] animated:YES];
                break;
            default:
                break;
        }
    }
}

#pragma mark 帮助中心
- (void)showHelpCenter{
    ByEnergyBaseWebVc *operationVC = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:AppHelpCenterUrl
                                                                                    title:@"帮助中心"
                                                                                  baseUrl:URL_BASE
                                                                                   params:nil];
    operationVC.byEnergyRefreshEnabled = YES;
    [self.navigationController pushViewController:operationVC animated:YES];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (IBAction)userInfoButtonClick:(UIButton *)sender {
    
    //....
    CFYYViewController *vc = [[CFYYViewController alloc]init];
    [vc setAddSubscriptSuccessBlock:^{
        
    }];
    
    //个人信息
    [self.navigationController pushViewController:[BEnergyMyInfoViewController new] animated:YES];
}

- (IBAction)couponsButtonClick:(UIButton *)sender {
    //...
    CFYYViewController *vc = [[CFYYViewController alloc]init];
    [vc addtitle:@"" imageStr:@""];
    
    //优惠券
    [self.navigationController pushViewController:[BEnergyMyCouponsViewController new] animated:YES];
}

- (IBAction)amountButtonClick:(UIButton *)sender {
    //我的钱包
    [self.navigationController pushViewController:[BEnergyMyAccountInfoViewController new] animated:YES];
}

- (IBAction)addCardButtonClick:(UIButton *)sender {
    //我的车牌号
    [self.navigationController pushViewController:[BEnergyMyCarNumberViewController new] animated:YES];
}
#pragma mark - LazyLoad
LCFLazyload(BEnergyUserInfoViewModel, userInfoViewModel)
LCFLazyload(BEnergySystemInfoViewModel, systemInfoModel)
LCFLazyload(ByEnergyShareViewModel, shareInfoViewModel)
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.text = @"我的";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
@end
