//
//  BDRecommendationViewController.m
//  bydeal
//
//  Created by chenfeng on 2018/12/27.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDRecommendationViewController.h"
//#import "UIViewController+BDStoryboard.h"
@interface BDRecommendationViewController ()
//@property (weak, nonatomic) IBOutlet BDTextView *contentTextView;
//@property (weak, nonatomic) IBOutlet UITextField *titleTextFiled;
//@property (weak, nonatomic) IBOutlet BDTextView *shareContentView;
@property (nonatomic,assign) BOOL isRecommend;
@end

@implementation BDRecommendationViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses removeObject:[UITableViewController class]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[UITableViewController class]];
}

#pragma mark <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length + string.length <= 32) {
        return YES;
    }
    
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self fillData];
}

- (void)initDataAndViews {
    self.title = @"推荐语";
//    self.showRefreshHeader = NO;
//    self.showLoadMoreFooter = NO;
//    self.contentTextView.placeholder = @"请为您分销的商品填写推荐语（选填）";
//    self.contentTextView.placeholderColor = COLOR_cccccc;
//    self.contentTextView.inputTextView.font = ByEnergyRegularFont(15);
//    self.contentTextView.limitNumber = 200;
//    [self.contentTextView setShowLimitNumberLabel:YES];
//
//    self.shareContentView.placeholder = @"请输入(选填)";
//    self.shareContentView.placeholderColor = COLOR_cccccc;
//    self.shareContentView.inputTextView.font = ByEnergyRegularFont(15);
//    self.shareContentView.limitNumber = 45;
//    [self.shareContentView setShowLimitNumberLabel:YES];
    
}

- (void)fillData {
    
//    self.contentTextView.text = self.model.storeProducts.recommendLanguage.length > 0 ? self.model.storeProducts.recommendLanguage:@"";
//    self.titleTextFiled.text = self.model.storeProducts.shareTitle.length > 0 ? self.model.storeProducts.shareTitle:@"";
//    self.shareContentView.text = self.model.storeProducts.shareDetails.length > 0 ? self.model.storeProducts.shareDetails:@"";
}

- (IBAction)saveButtonClick:(UIButton *)sender {
    
//    NSString *content  = [self.contentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//
//    [HUDTool showLoading];
    
//    NSDictionary *param = @{
////                            @"storeAndProductAndCategoryId":self.model.storeProducts.storeAndProductAndCategoryId,
////                            @"recommendLanguage":content.length == 0 ? @"" : self.contentTextView.text,
//                            @"shareTitle":self.titleTextFiled.text.length > 0 ?self.titleTextFiled.text:@"",
//                            @"shareDetail":self.shareContentView.text.length > 0 ? self.shareContentView.text:@"",
//                            @"isRecommend":self.contentTextView.text.length >0 ? @(YES):@(NO)
//                            };
    
//    [HttpRequestDataTool POST:SaveRecommendUrl
//                       params:param
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          [HUDTool showSuccessWithHint:@"保存成功"];
//                          self.model.storeProducts.recommendLanguage = self.contentTextView.text;
//                          self.model.storeProducts.shareTitle = self.titleTextFiled.text;
//                          self.model.storeProducts.shareDetails = self.shareContentView.text;
//                          if (self.contentTextView.text.length == 0 ) {
//                              self.model.storeProducts.isRecommend = NO;
//                          }else {
//                              self.model.storeProducts.isRecommend = YES;
//                          }
//                          if (self.refreshShopList) {
//                              self.refreshShopList();
//                          }
//                          
//                          [self vd_performActionDelay:0.5
//                                               action:^{
//                                                   [self.navigationController popViewControllerAnimated:YES];
//                                               }];
//    } failure:^(id response) {
//        [HUDTool showErrorWithHint:@"保存失败，请重试"];
//    }];
//    
}

#pragma mark - tableViewDelgate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }else {
        return 10.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}
@end
