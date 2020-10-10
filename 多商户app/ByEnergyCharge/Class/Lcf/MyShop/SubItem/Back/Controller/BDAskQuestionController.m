//
//  BDAskQuestionController.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDAskQuestionController.h"
#import "UIViewController+ByEnergyStoryboard.h"
#import "BDSelecteSupplierController.h"
//#import "BDSuggsetionListModel.h"
//#import "BDPickerView.h"

@interface BDAskQuestionController ()

@property (weak, nonatomic) IBOutlet UITextField *suppplierField;

@property (weak, nonatomic) IBOutlet UITextField *typeField;

@property (weak, nonatomic) IBOutlet UITextField *contactField;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

//@property (weak, nonatomic) IBOutlet BDTextView *contentTextView;

@property (nonatomic, strong) BDSupplierModel *model;

//@property (nonatomic, strong) NSMutableArray<BDSuggsetionListModel *> *menuDataArray; // 菜单数组

//@property (nonatomic, strong) BDSuggsetionListModel *typeModel;

@end

@implementation BDAskQuestionController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses removeObject:[UITableViewController class]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[UITableViewController class]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.contactField limitTextLength:20];
//    [self.phoneField limitTextLength:11];
//    self.contentTextView.placeholder = @"请用10-50字填写反馈内容";
//    self.contentTextView.limitNumber = 100;
//    self.contentTextView.showLimitNumberLabel = YES;
    [self loadMenuData];
}

// 获取菜单下拉框选项
- (void)loadMenuData {
//    [HUDTool showLoading];
    NSDictionary *param = @{@"marker":@"supplierFeedback"};
//    [HttpRequestDataTool POST:fetchTagsWithTypeUrl
//                       params:param
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          DLog(@"下拉框response = %@",response);
//                          [HUDTool dismissHud];
//                          self.menuDataArray = [NSMutableArray arrayWithArray:[BDSuggsetionListModel zm_modelArrayFromJsonArray:response[@"data"][@"result"]]];
//                          
//                          NSMutableArray *tempArray = [NSMutableArray array];
//                          [self.menuDataArray enumerateObjectsUsingBlock:^(BDSuggsetionListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                              [tempArray addObject:obj.title];
//                          }];
//                          
//                      } failure:^(id response) {
//                          [HUDTool dismissHud];
//                      }];
}


#pragma mark - Action

- (IBAction)didClickSubmmit:(UIButton *)sender {
//    if (!self.model) {
//        [HUDTool showErrorWithHint:@"请选择供应商"];
//        return;
//    }
//    if (!self.typeModel) {
//        [HUDTool showErrorWithHint:@"请选择问题类型"];
//        return;
//    }
//
//    if (self.contactField.text.length <= 0 ) {
//        [HUDTool showErrorWithHint:@"请输入联系人"];
//        return;
//    }
//
//    if (self.contactField.text.length <= 0 ) {
//        [HUDTool showErrorWithHint:@"请输入联系人"];
//        return;
//    }
//
//    if (self.phoneField.text.length <= 0 ) {
//        [HUDTool showErrorWithHint:@"请输入手机号"];
//        return;
//    }
//
//    if (self.contentTextView.text.length <= 0 ) {
//        [HUDTool showErrorWithHint:@"请输入反馈内容"];
//        return;
//    }
//
//    if (self.contentTextView.text.length < 10) {
//        [HUDTool showErrorWithHint:@"反馈内容不少于10个字"];
//        return;
//    }
//
//    NSDictionary *params = @{
//                             @"goalId" : self.model.businessId,
//                             @"goalType" : self.model.businessType,
//                             @"typeName" : self.typeModel.marker,
//                             @"typeContent" : self.typeModel.titleStr,
//                             @"name" : self.contactField.text,
//                             @"phone" : self.phoneField.text,
//                             @"content" : self.contentTextView.text,
//                             };
//    [HUDTool showLoading];
//    [HttpRequestDataTool POST:AskQuestionUrl
//                       params:params
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          if (self.askSuccessBlock) {
//                              self.askSuccessBlock();
//                          }
//                          [HUDTool showSuccessWithHint:@"提问成功"];
//                          [self.navigationController popViewControllerAnimated:YES];
//                      } failure:^(id response) {
//                          [HUDTool dismissHud];
//                      }];
//
    
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//            { // 选择供应商
//                BDSelecteSupplierController *vc = [[BDSelecteSupplierController alloc] init];
//                ByEnergyWeakSekf;
//                vc.selecteSuccessBlock = ^(BDSupplierModel * _Nonnull model) {
//                    ByEnergyStrongSelf;
//                    self.model = model;
//                    self.suppplierField.text = model.businessName;
//                };
//                [TopestNavigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 1:
//            { // 问题类型
//                
//                BDPickerView *pickView = [[BDPickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//                [pickView.sureBtn setTitle:@"确定" forState: UIControlStateNormal];
//                [pickView.sureBtn setTitleColor:APPGrayColor forState:UIControlStateNormal];
//                pickView.dataArray = [self.menuDataArray valueForKeyPath:@"titleStr"];;
//                ByEnergyWeakSekf;
//                [pickView setSelectBlock:^(NSInteger index) {
//                    ByEnergyStrongSelf;
//                    self.typeModel = self.menuDataArray[index];
//                    self.typeField.text = self.menuDataArray[index].titleStr;
//                }];
//                [pickView show];
//                
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

#pragma mark - Lazy Load
//- (NSMutableArray<BDSuggsetionListModel *> *)menuDataArray {
//    if (!_menuDataArray) {
//        _menuDataArray = [NSMutableArray array];
//    }
//    return _menuDataArray;
//}

@end
