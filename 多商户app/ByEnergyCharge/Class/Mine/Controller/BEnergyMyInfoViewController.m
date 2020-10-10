//
//  BEnergyMyInfoViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyMyInfoViewController.h"
#import "BEnergyMyInformationViewModel.h"
#import "BRPickerView.h"
#import "NSDate+date.h"
#import "BEnergyLoginViewModel.h"

@interface BEnergyMyInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *sexTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (nonatomic, strong) BEnergyUserInfoModel *byUserInfoViewModel;
@property (nonatomic, strong) NSMutableDictionary *byTagInfoDic;
@property (nonatomic, strong) BEnergyMyInformationViewModel *myInformationViewModel;
@property (nonatomic, copy) NSString *byBirthdayStr;
@property (nonatomic, strong) BEnergyLoginViewModel *byLoginViewModel;
@property(nonatomic, assign)BOOL hasIconImage;
@end

@implementation BEnergyMyInfoViewController

- (instancetype)init {
    return [BEnergyMyInfoViewController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self fillUserInfoData];
    
    [self byEnergyInitViewModel];
}

- (void)initDataAndViews {
    self.navigationItem.title = @"个人信息";
    self.view.backgroundColor = BYENERGYCOLOR(0xf6f6f6);
    [self.nameTextFiled setTextCount:20];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self byEnergyNavItemWitnTitles:@[@"保存"] isLeft:NO target:self action:@selector(submitPersonInfoClick) tags:[NSArray new]];
    [self.iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePersonIconImageView)]];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)fillUserInfoData {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[StringUtils resoureUrlStrWithPath:byEnergyClearNilStr(self.byUserInfoViewModel.headImgUrl)
                                                                                           baseUrl:URL_BASE]]
                          placeholderImage:IMAGEWITHNAME(@"make_pic")];
    self.nameTextFiled.text = byEnergyClearNilStr(self.byUserInfoViewModel.nickName);
    self.sexTextFiled.text = self.byUserInfoViewModel.sex == 1 ? @"男" : @"女";
    self.birthdayTextField.text = self.byBirthdayStr;
    self.phoneTextFiled.text = [StringUtils numberSuitScanf:byEnergyClearNilStr(self.byUserInfoViewModel.account)];
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)byEnergyInitViewModel {
    
    ByEnergyWeakSekf
    [[[[self.myInformationViewModel.hnUploadUserIconCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.myInformationViewModel.result) {
            NSDictionary *dic = x;
            NSArray *array = dic[@"fileIdList"];
            if (array.count > 0) {
                [self.byTagInfoDic setObject:[array firstObject] forKey:@"headImg"];
                [self.myInformationViewModel.hnEditUserInfoCommand execute:self.byTagInfoDic];
            }else {
                [HUDManager showTextHud:@"上传头像有误！" onView:self.view];
            }
        }else {
            [HUDManager hidenHud];
        }
    }];
    
    [[self.myInformationViewModel.hnUploadUserIconCommand executionSignals] subscribeError:^(NSError * _Nullable error) {
        
    }];
    
    [[[[self.myInformationViewModel.hnEditUserInfoCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.myInformationViewModel.result) {
            [HUDManager showStateHud:@"保存成功!"
                               state:HUDStateTypeSuccess
                             imgName:nil
                          afterDelay:1.5
                              onView:ByEnergyAppWindow
                     completionBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
    
    [self.myInformationViewModel.hnUploadUserIconCommand.errors subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [HUDManager showTextHud:x.domain.description onView:self.view];
    }];
}

#pragma mark ----- tableViewDeleGate,Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            kWeakSelf(self);
            [BRStringPickerView showStringPickerWithTitle:@"性别"
                                               dataSource:@[@"男",@"女"]
                                          defaultSelValue:@"男"
                                             isAutoSelect:NO
                                              resultBlock:^(id selectValue) {
                weakself.sexTextFiled.text = selectValue;
            }];
        }else if (indexPath.row == 2) {
            kWeakSelf(self);
            [BRDatePickerView showDatePickerWithTitle:@"生日"
                                             dateType:UIDatePickerModeDate
                                      defaultSelValue:byEnergyClearNilStr(self.byBirthdayStr)
                                           minDateStr:@""
                                           maxDateStr:[NSDate byEnergyFetchCurrentDateString]
                                         isAutoSelect:NO
                                          resultBlock:^(NSString *selectValue) {
                weakself.birthdayTextField.text = selectValue;
                
            }];
        }
    }
}

#pragma mark ----- aciton
- (IBAction)logoutButtonClick:(UIButton *)sender {
    kWeakSelf(self);
    
    [BEnergyCustomAlertView showAlertViewWithTitle:@"您确定要退出登录吗？"
                                       buttonArray:@[@"取消",@"确认"]
                                             block:^(BEnergyCustomAlertView * _Nonnull target, NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            [[BEnergySCUserStorage sharedInstance] clearUserInfo];
            [weakself.byLoginViewModel.hnRemoveTokenCommand execute:nil];
            [[BEnergySCUserStorage sharedInstance] clearUserInfo];
            [USER_DEFAULT setObject:@"" forKey:@"token"];
            [HUDManager showStateHud:@"退出成功"
                               state:HUDStateTypeSuccess
                             imgName:nil
                          afterDelay:1
                              onView:self.view
                     completionBlock:^{
                ByEnergySendNotification(ByEnergyLogout, nil);
                [self hnByEnergyAfter:0.5 action:^{
                    [self.navigationController popViewControllerAnimated:NO];
                }];
            }];
        }
    }];
}

- (void)submitPersonInfoClick {
    
    if (self.nameTextFiled.text.length == 0) {
        [HUDManager showTextHud:@"请输入昵称" onView:self.view];return;
    }
    if (self.sexTextFiled.text.length == 0) {
        [HUDManager showTextHud:@"请选择性别 " onView:self.view];return;
    }
    if (self.birthdayTextField.text.length == 0) {
        [HUDManager showTextHud:@"请选择生日 " onView:self.view];return;
    }
    
    [self.byTagInfoDic setObject:self.nameTextFiled.text forKey:@"name"];
    [self.byTagInfoDic setObject:self.byUserInfoViewModel.id forKey:@"id"];
    [self.byTagInfoDic setObject:self.birthdayTextField.text forKey:@"birthday"];
    [self.byTagInfoDic setObject:[self.sexTextFiled.text isEqualToString:@"男"] ? @"1":@"2" forKey:@"sex"];
    
    if (self.hasIconImage) {
        [HUDManager hidenHud];
        NSArray *fileDatas = [NSArray arrayWithObject:self.byTagInfoDic[@"headImg"]];
        if (byEnergyIsNilOrNull(fileDatas)) {
            [HUDManager showTextHud:@"上传文件为空！"];
            return;
        }
        [self.myInformationViewModel.hnUploadUserIconCommand execute:fileDatas];
    }else {
        [self.myInformationViewModel.hnEditUserInfoCommand execute:self.byTagInfoDic];
    }
    
    //....
    SubscribeViewController *vc = [SubscribeViewController new];
    [vc showSheetStylePickerViewWithLastText:@"类别"];
}

- (void)choosePersonIconImageView {
    [StringUtils endEditedFromView:self.view];
    ByEnergyWeakSekf
    [[SCPhotoUtil sharedInstance] takePhotoWithEditEnabled:YES
                                                targetSize:CGSizeMake(100, 100)
                                        compressionQuality:0.2
                                                 completed:^(NSData *imageData) {
        ByEnergyStrongSelf
        if (imageData != nil) {
            [self.iconImageView setImage:[UIImage imageWithData:imageData]];
            [self.byTagInfoDic setObject:imageData forKey:@"headImg"];
            self.hasIconImage = YES;
        }
    }];
}

#pragma mark ----- LazyLoad
LCFLazyload(BEnergyMyInformationViewModel, myInformationViewModel)

LCFLazyload(NSMutableDictionary, byTagInfoDic)

- (BEnergyUserInfoModel *)byUserInfoViewModel {
    if (!_byUserInfoViewModel) {
        _byUserInfoViewModel = [[BEnergyUserInfoModel alloc] init];
        _byUserInfoViewModel = [BEnergySCUserStorage sharedInstance].userInfo;
    }
    return _byUserInfoViewModel;
}

- (NSString *)byBirthdayStr {
    if (!_byBirthdayStr) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _byBirthdayStr = [dateFormatter stringFromDate:[NSDate date]];
        if (self.byUserInfoViewModel.formatDate) {
            _byBirthdayStr = self.byUserInfoViewModel.formatDate;
        }
    }
    return _byBirthdayStr;
}
@end
