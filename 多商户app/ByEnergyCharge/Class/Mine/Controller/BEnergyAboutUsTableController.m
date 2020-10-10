//
//  BEnergyAboutUsTableController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/8.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyAboutUsTableController.h"
#import "BEnergySystemInfoModel.h"
#import "BEnergyAppStorage.h"
#import "ApplicationUtil.h"
#import "LiabilityViewController.h"

@interface BEnergyAboutUsTableController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *wechatLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@end

@implementation BEnergyAboutUsTableController

- (instancetype)init {
    return [BEnergyAboutUsTableController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)initDataAndViews {
    self.title = @"关于我们";
    AboutInfo *aboutInfo = [[[BEnergyAppStorage sharedInstance] systemInfo] aboutInfo];
//    self.iconImageView.image = IMAGEWITHNAME(@"icon_logo_about");
    self.versionLabel.text = NSStringFormat(@"v%@",[ApplicationUtil nowAppVersion]);
    self.wechatLabel.text = byEnergyClearNilReturnStr(aboutInfo.weChat, @"请联系客服");
    self.businessLabel.text = byEnergyClearNilReturnStr(aboutInfo.business, @"请联系客服");
    self.urlLabel.text = byEnergyClearNilReturnStr(aboutInfo.officialURL,@"http://www.xmnewyea.com");
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}


#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 238.0f;
            break;
        case 2:
        case 3:
        case 5:
            return 0.0f;
            break;
        case 1:
        case 4:
        case 6:
            return 44.0f;
            break;
        default:
            return 0.0f;;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        [self.navigationController pushViewController:[LiabilityViewController new] animated:YES];
    }else if (indexPath.row == 5) {
        [self showWebWithpath:AppToServiceAgreementUrl
                       params:nil
                      baseUrl:URL_BASE
                     titleStr:@"用户协议"
                      refType:1
         navigationController:self.navigationController];
    }else if (indexPath.row == 6) {
        [self showWebWithpath:AppPrivacyStatementUrl
                       params:nil
                      baseUrl:URL_BASE
                     titleStr:@"隐私政策"
                      refType:1
         navigationController:self.navigationController];
    }
}

#pragma mark ----- pushWebView
- (void)showWebWithpath:(NSString *)pathStr
                 params:(NSDictionary *)params
                baseUrl:(NSString *)baseUrl
               titleStr:(NSString *)titleStr refType:(int)refType
   navigationController:(UINavigationController *)navigationController {
    
    ByEnergyBaseWebVc *vc = [ByEnergyBaseWebVc byEnergyWebViewControllerWithPath:pathStr
                                                                           title:titleStr
                                                                         baseUrl:URL_BASE
                                                                          params:params];
    [navigationController pushViewController:vc animated:YES];
    
}

@end
