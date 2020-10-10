//
//  BDShopInfoViewController.m
//  bydeal
//
//  Created by chenfeng on 2018/12/22.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopInfoViewController.h"
#import "UIViewController+ByEnergyStoryboard.h"
#import "ByEnergyTextView.h"
//#import "BDCityPickerView.h"
//#import "BDIndustryPickView.h"

@interface BDShopInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextFiled;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogoImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *addressTextFiled;
//@property (weak, nonatomic) IBOutlet BDTextView *introdutionTextView;
@property (nonatomic,assign) BOOL isHasImage;
@property (nonatomic,strong) NSString *imageStr;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *county;
@property (nonatomic,strong) NSString *provinceKey;
@property (nonatomic,strong) NSString *cityKey;
@property (nonatomic,strong) NSString *countyKey;
@property (weak, nonatomic) IBOutlet UITextField *titleTextFiled;
//@property (weak, nonatomic) IBOutlet BDTextView *shareContentView;
@end

@implementation BDShopInfoViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses removeObject:[UITableViewController class]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[UITableViewController class]];
}

- (void)navigationBackItemDidTap:(id)sender {

    if (self.isJumpRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self chooseActionTap];
    
    [self fetchShopInfo];
}

- (void)initDataAndViews {
    self.title = @"小店信息";
//    self.showRefreshHeader = NO;
//    self.showLoadMoreFooter = NO;
    self.isHasImage = NO;
    self.shopLogoImageView.layer.cornerRadius = 17.5f;
    self.shopLogoImageView.layer.masksToBounds = YES;
//    self.introdutionTextView.placeholder = @"请输入";
//    self.introdutionTextView.placeholderColor = COLOR_cccccc;
//    self.introdutionTextView.inputTextView.font = ByEnergyRegularFont(15);
//    self.introdutionTextView.limitNumber = 200;
//    [self.introdutionTextView setShowLimitNumberLabel:YES];
//    
//    self.shareContentView.placeholder = @"请输入(选填)";
//    self.shareContentView.placeholderColor = COLOR_cccccc;
//    self.shareContentView.inputTextView.font = ByEnergyRegularFont(15);
//    self.shareContentView.limitNumber = 45;
//    [self.shareContentView setShowLimitNumberLabel:YES];
//    
//    [self.phoneTextFiled limitTextLength:11];
//    [self.shopNameTextFiled limitTextLength:12];
//    [self.titleTextFiled limitTextLength:32];
//    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
}

- (void)fetchShopInfo {

//    [HUDTool showLoading];
//    [HttpRequestDataTool GET:GetStoreInfoUrl
//                      params:@{@"storeId":self.shopID}
//                  tokenState:ApiTokenUploadStateMust
//                     success:^(id response) {
//                         [HUDTool dismissHud];
//                         self.isHasImage = YES;
//                         self.shopNameTextFiled.text = response[@"data"][@"storeName"];
//                         self.imageStr = response[@"data"][@"storeLogo"];
//                         [self.shopLogoImageView sd_setImageWithURL:[response[@"data"][@"storeLogo"] zm_url]];
//                         self.phoneTextFiled.text = response[@"data"][@"storeTel"];
//                         self.introdutionTextView.text = response[@"data"][@"introduction"];
//                         self.provinceKey = response[@"data"][@"provinceKey"];
//                         self.cityKey = response[@"data"][@"cityKey"];
//                         self.countyKey = response[@"data"][@"countyKey"];
//                         self.province = response[@"data"][@"province"];
//                         self.city = response[@"data"][@"city"];
//                         self.county = response[@"data"][@"county"];
//                         NSString *shareTitleStr = response[@"data"][@"shareTitle"];
//                         NSString *shareContentStr = response[@"data"][@"shareInfo"];
//                         self.titleTextFiled.text = shareTitleStr.length > 0 ? shareTitleStr:@"";
//                         self.shareContentView.text = shareContentStr.length > 0 ? shareContentStr:@"";
//                         self.addressTextFiled.text = [NSString stringWithFormat:@"%@-%@",response[@"data"][@"province"],response[@"data"][@"city"]];
//                     }
//                     failure:^(id response) {
//                         [HUDTool dismissHud];
//                     }];
}


- (void)handelImagesData {
    
//    [HUDTool showLoading];
//    [BatchUploadImagesTool uploadAttachmentWithAssets:@[self.shopLogoImageView.image]
//                                             fileType:@"jpg"
//                                          useOriginal:NO
//                                       fromPhotoAlbum:NO
//                                              success:^(id response) {
//                                                  [HUDTool dismissHud];
//                                                  self.imageStr = response[0][@"path"];
//                                                  [self handleData];
//                                              } failure:^(id response) {
//                                                  [HUDTool showErrorWithHint:@"图片上传失败，请重试"];
//                                              }];
}

- (void)handleData {
    
    NSDictionary *param = @{
                            @"storeName":self.shopNameTextFiled.text.length > 0 ?self.shopNameTextFiled.text:@"",
                            @"storeLogo":self.imageStr,
                            @"storeTel":self.phoneTextFiled.text,
                            @"province":self.province.length > 0 ? self.province:@"",
                            @"city":self.city.length > 0 ? self.city:@"",
                            @"county":self.county.length > 0 ? self.county:@"",
                            @"provinceKey":self.provinceKey.length > 0 ? self.provinceKey:@"",
                            @"cityKey":self.cityKey.length > 0 ? self.cityKey:@"",
                            @"countyKey":self.countyKey.length > 0 ? self.countyKey:@"",
                            @"address":@"",
//                            @"introduction":self.introdutionTextView.text,
                            @"shareTitle":self.titleTextFiled.text.length > 0 ?self.titleTextFiled.text:@"",
//                            @"shareInfo":self.shareContentView.text.length > 0 ?self.shareContentView.text:@"",
                            };
    
//    [HttpRequestDataTool POST:SetStoreInfoUrl
//                       params:param
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          [HUDTool showSuccessWithHint:@"保存成功"];
//                          if (self.fetchShopId) {
//                              self.fetchShopId(response[@"data"][@"result"]);
//                          }
//                          [self.navigationController popViewControllerAnimated:YES];
//                      } failure:^(id response) {
//                          [HUDTool showErrorWithHint:@"保存失败，请重试"];
//                      }];
}

- (void)handleSaveButtonTaped {
    
    if (![self checkMenmuList]) {
        return;
    }
    [self handelImagesData];
}

- (BOOL)checkMenmuList {
    

    return YES;
}
#pragma mark - action
- (void)chooseActionTap {
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 1) {
//            ByEnergyWeakSekf;
//            [self choosePictureWithUploadIdentityStyle:^(NSArray *photos) {
//                ByEnergyStrongSelf;
//                if (photos.count > 0) {
//                    self.shopLogoImageView.image = photos[0];
//                    self.isHasImage = YES;
//                }
//            }];
//        }else if (indexPath.row == 3) {
//            [self selectAddressWithType:ListColumnWithProvinceCityTwo];
//        }
//    }    
}

@end
