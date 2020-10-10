//
//  BDAskQuestionController.m
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDRunOrderComplainController.h"
//#import "UIViewController+BDStoryboard.h"
#import "BDSelecteSupplierController.h"
//#import "BDSuggsetionListModel.h"
//#import "BDPickerView.h"

//#import "BDTopicImagePickerViewController.h"
//#import "BDPhotoView.h"


@interface BDRunOrderComplainController ()
@property (weak, nonatomic) IBOutlet UITextField *suppplierField;


@property (weak, nonatomic) IBOutlet UITextField *contactField;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;

//@property (weak, nonatomic) IBOutlet BDTextView *contentTextView;
//
//@property (weak, nonatomic) IBOutlet BDPhotoView *photoEditView;

@property (nonatomic,copy) NSString *ratingPics;

@property (nonatomic, strong) BDSupplierModel *model;

//@property (nonatomic, strong) NSMutableArray<BDSuggsetionListModel *> *menuDataArray; // 菜单数组
//
//@property (nonatomic, strong) BDSuggsetionListModel *typeModel;

@property (strong, nonatomic) NSMutableArray<UIImage*> *imagesArray;//图片数组


@end

@implementation BDRunOrderComplainController

//- (instancetype)init {
//    return [BDRunOrderComplainController loadFromStoryboardDefaultTalk];
//}

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
//    self.contentTextView.placeholder = @"请用10-50字填写投诉内容";
//    self.contentTextView.limitNumber = 50;
//    self.contentTextView.showLimitNumberLabel = YES;
//
//    self.photoEditView.delegate = self;
//    self.photoEditView.maxCount = 3;
    [self loadMenuData];
}

// 获取菜单下拉框选项
- (void)loadMenuData {
//    [HUDTool showLoading];
//    NSDictionary *param = @{@"marker":@"supplierFeedback"};
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

    
}

- (void)handelData {
    NSDictionary *params = @{
                             @"goalId" : self.model.businessId,
                             @"goalType" : self.model.businessType,
                             @"goalName" : self.model.businessName,
                             @"name" : self.contactField.text,
                             @"phone" : self.phoneField.text,
                             @"content" : @"",
                             @"images" : self.ratingPics
                             };
//    [HUDTool showLoading];
//    [HttpRequestDataTool POST:ComplainUrl
//                       params:params
//                   tokenState:ApiTokenUploadStateMust
//                      success:^(id response) {
//                          if (self.complainSuccessBlock) {
//                              self.complainSuccessBlock();
//                          }
//                          [HUDTool showSuccessWithHint:@"提问成功"];
//                          [self.navigationController popViewControllerAnimated:YES];
//                      } failure:^(id response) {
//                          [HUDTool dismissHud];
//                      }];
}

- (void)handelImagesData {
//    [HUDTool showLoading];
//
//    [BatchUploadImagesTool uploadAttachmentWithAssets:self.imagesArray
//                                             fileType:@"jpg"
//                                          useOriginal:NO
//                                       fromPhotoAlbum:NO
//                                              success:^(id response) {
//                                                  NSMutableArray *imageStrArray = [NSMutableArray new];
//                                                  for (NSDictionary *imageDic in response) {
//                                                      NSString *imageStr = imageDic[@"path"];
//                                                      [imageStrArray addObject:imageStr];
//                                                  }
//                                                  self.ratingPics = [imageStrArray yy_modelToJSONString];
//                                                   [self handelData];
//                                              } failure:^(id response) {
//
//                                              }];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            { // 选择供应商
                BDSelecteSupplierController *vc = [[BDSelecteSupplierController alloc] init];
                ByEnergyWeakSekf;
                vc.selecteSuccessBlock = ^(BDSupplierModel * _Nonnull model) {
                    ByEnergyStrongSelf;
                    self.model = model;
                    self.suppplierField.text = model.businessName;
                };
//                [TopestNavigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            { // 问题类型
                
                
            }
                break;
                
            default:
                break;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}


//#pragma mark - BDPhotoViewDelegate
//- (void)addPictureInPhotoEditView:(BDPhotoView *)photoEditView {
//    [self uploadImage];
//}

/*选取图片*/
- (void)uploadImage {
    
//    BDTopicImagePickerViewController *controller = [[BDTopicImagePickerViewController alloc] init];
//    controller.maxImagesCount = 3 - self.imagesArray.count;
//    controller.titleStr = @"选择图片";
//    ByEnergyWeakSekf;
//    controller.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        if (photos.count > 0) {
//            ByEnergyStrongSelf;
//            [self.imagesArray addObjectsFromArray:photos];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                _photoEditView.imgsArray = self.imagesArray;
//            });
//        }
//    };
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
//    [TopestViewController presentViewController:nav animated:YES completion:nil];
}

- (void)deleteImageaWithIndex:(NSInteger)index {
    [self.imagesArray removeObjectAtIndex:index];
    if (!self.imagesArray.count) {
    }
    
}


#pragma mark - Lazy Load




- (NSMutableArray<UIImage *> *)imagesArray {
    if (!_imagesArray ){
        _imagesArray = [[NSMutableArray alloc] init];;
    }
    return _imagesArray;
}
@end
