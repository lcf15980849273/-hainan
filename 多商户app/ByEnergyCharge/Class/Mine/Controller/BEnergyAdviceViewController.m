//
//  BEnergyAdviceViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyAdviceViewController.h"
#import "BEnergyXYPhotoView.h"
#import "CFImagePickerViewController.h"
#import "BEnergyFeedBackListCell.h"
#import "BEnergyFeedBackHeaderView.h"
#import "MyAdviceViewController.h"
#import "BEnergyFeedBackViewModel.h"
#import "SCImageUtil.h"
#import "SCPermission.h"
@interface BEnergyAdviceViewController ()<BEnergyXYPhotoViewDelegate>
@property (weak, nonatomic) IBOutlet ByEnergyTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *myFeedBackButton;
@property (weak, nonatomic) IBOutlet UIButton *feedBackButton;
@property (weak, nonatomic) IBOutlet BEnergyXYPhotoView *photoView;
@property (weak, nonatomic) IBOutlet UITableViewCell *feedBackContentCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *feedBackPhotoCell;
@property (strong, nonatomic) NSMutableArray<UIImage*> *imagesArray;//图片数组
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;
@property (nonatomic, strong) BEnergyFeedBackHeaderView *headerView;
@property (nonatomic, strong) BEnergyFeedBackViewModel *FeedBackViewModel;
@property (nonatomic, strong) NSMutableDictionary *tagInfoDic;
@property (nonatomic, strong) BEnergyUserInfoModel *userInfo;
@property (nonatomic, assign) int categoryId;//问题类型ID
@property (nonatomic, assign) BOOL isSelectCategory;
@property (nonatomic, strong) NSMutableArray *imageDataArray;
@end

@implementation BEnergyAdviceViewController

- (instancetype)init {
    return [BEnergyAdviceViewController byEnergyLoadStoryboardFromStoryboardName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses removeObject:[UITableViewController class]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager].disabledDistanceHandlingClasses addObject:[UITableViewController class]];
}

- (void)initDataAndViews {
    self.title = @"意见反馈";
    self.isSelectCategory = NO;
    self.view.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"f7f7f7"];
    self.contentTextView.placeholder = @"请简要描述您的问题和意见，以便我们提供更好的帮助";
    self.contentTextView.limitNumber = 250;
    self.contentTextView.showLimitNumberLabel = YES;
    self.contentTextView.inputTextView.font = ByEnergyRegularFont(12);
    self.photoView.delegate = self;
    self.photoView.maxCount = 3;
    [self setViewShadowWithView:self.feedBackButton];
    [self setViewShadowWithView:self.myFeedBackButton];
    self.photoViewWidth.constant = [BEnergyXYPhotoView getWidthWithArrayCount:3];
    self.photoViewHeight.constant = [BEnergyXYPhotoView getHeightWithArrayCount:3];
    
    [self.tableView registerNib:[UINib nibWithNibName:kBEnergyFeedBackListCell bundle:nil] forCellReuseIdentifier:kBEnergyFeedBackListCell];
    
    //....
    FirstTableView *tab = [FirstTableView new];
    [tab createServiceData];
    [tab byEnergyWithLoadfistTableViewLoaclData];
    SecondTableView *sec = [SecondTableView new];
    [sec byEnergyCreateSecondTableViewWithFrame:CGRectZero];
    [sec refreshByEnergySecondTableData];
}

- (void)setViewShadowWithView:(UIView *)view {
    view.layer.shadowOffset = CGSizeMake(0, 2);
    view.layer.shadowOpacity = 1.0;
    view.layer.shadowRadius = 5;
    view.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                             green:0.0f/255.0f
                                              blue:0.0f/255.0f
                                             alpha:0.1].CGColor;
    
    //...
    CoreGraphicsViewController *vc = [CoreGraphicsViewController new];
    [vc setupNaviWithTintColor:[UIColor redColor]
               backgroundImage:[UIImage imageNamed:@""]
                statusBarstyle:UIStatusBarStyleDefault
                    attributes:[NSDictionary new]];
    
    [vc selectedProvince:@"" AndCity:@"111" AndArea:@"111" withAllName:@"333"];
}

- (void)byEnergyFetchStubGroupList {
    
    NSMutableDictionary *tagInfo = [NSMutableDictionary dictionary];
    [self.FeedBackViewModel.hnFeedBackTypeCommand execute:tagInfo];
}


- (void)bindViewModel {
    
    kWeakSelf(self);
    self.tableView.headerRefreshingBlock = ^{
        [weakself byEnergyFetchStubGroupList];
    };
    
    ByEnergyWeakSekf
    [[[[self.FeedBackViewModel.hnFeedBackTypeCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.FeedBackViewModel.result) {
        }
        [self.tableView reloadData];
        [self.tableView endRefreshing];
    }];
    [[self.FeedBackViewModel.hnFeedBackTypeCommand errors] subscribeNext:^(NSError * _Nullable x) {
        ByEnergyStrongSelf
        [self.tableView endRefreshing];
    }];
    
    [[[[self.FeedBackViewModel.hnUploadFeedBackImageCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.FeedBackViewModel.result) {
        }
        NSDictionary *dic = x;
        NSArray *array = dic[@"fileIdList"];
        [self.tagInfoDic setObject:[array componentsJoinedByString:@","] forKey:@"img"];
        [self commitFeedBackContent];
    }];
    
    
    [[[[self.FeedBackViewModel.hnFeedBackAddCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.FeedBackViewModel.result) {
        }
        [HUDManager showStateHud:@"谢谢您的反馈" state:HUDStateTypeSuccess];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [[self.FeedBackViewModel.hnFeedBackAddCommand errors] subscribeNext:^(NSError * _Nullable x) {
        [HUDManager showStateHud:@"反馈失败，请重试" state:HUDStateTypeFail];
    }];
    
    
    [self.tableView beginRefreshing];
}

- (void)chooseFeedBackImage {
    
    [SCPermission authorizedWithType:SCPermissionType_Photos WithResult:^(BOOL granted) {
        if (granted) {
            CFImagePickerViewController *controller = [[CFImagePickerViewController alloc] init];
            controller.maxImagesCount = 3 - self.imagesArray.count;
            controller.titleStr = @"选择图片";
            ByEnergyWeakSekf;
            controller.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (photos.count > 0) {
                    ByEnergyStrongSelf;
                    [self.imagesArray addObjectsFromArray:photos];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.photoView.imgsArray = self.imagesArray;
                        for (UIImage *image in photos) {
                            UIImage *imageNew = [SCImageUtil imageCompressForSize:image targetSize:CGSizeMake(100, 100)];
                            NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.2);
                            [self.imageDataArray addObject:imageData];
                        }
                    });
                }
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
     }];
}

#pragma mark ----- action
- (IBAction)buttonActionClick:(UIButton *)sender {
    if (sender.tag == 0) {
        [self.navigationController pushViewController:[MyAdviceViewController new] animated:YES];
    }else {
        [self uploadHeadImg];
    }
}

- (void)uploadHeadImg {
    
    if (!self.isSelectCategory) {
        [HUDManager showStateHud:@"请选择您遇到的问题" state:HUDStateTypeWarning];return;
    }
    if (self.contentTextView.inputTextView.text.length == 0) {
        [HUDManager showStateHud:@"请您补充详细问题和意见" state:HUDStateTypeWarning];return;
    }
    
    if (self.imageDataArray.count > 0) {
        [self.FeedBackViewModel.hnUploadFeedBackImageCommand execute:self.imageDataArray];
    }else {
        [self commitFeedBackContent];
    }
}

- (void)commitFeedBackContent {
    
    [self.tagInfoDic setObject:@(self.categoryId) forKey:@"categoryId"];
    [self.tagInfoDic setObject:self.contentTextView.inputTextView.text forKey:@"info"];
    [self.tagInfoDic setObject:self.userInfo.account forKey:@"account"];
    [self.FeedBackViewModel.hnFeedBackAddCommand execute:self.tagInfoDic];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.FeedBackViewModel.datasArray.count : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44.0f;
    }else {
        return indexPath.row == 0 ? 174.0f : 250.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section == 0 ? self.headerView : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 32.0f : 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BEnergyFeedBackListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kBEnergyFeedBackListCell];
        cell.model = self.FeedBackViewModel.datasArray[indexPath.row];
        return cell;
    }else {
        return indexPath.row == 0 ? self.feedBackContentCell : self.feedBackPhotoCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.isSelectCategory = YES;
    BEnergyFeedBackTypeModel *typeModel = self.FeedBackViewModel.datasArray[indexPath.row];
    self.categoryId = typeModel.value;
    for (int i = 0; i  < self.FeedBackViewModel.datasArray.count; i ++) {
        if (i == indexPath.row) {
            BEnergyFeedBackTypeModel *model = self.FeedBackViewModel.datasArray[i];
            if (!model.select) {
                model.select = !model.select;
            }
        }else {
            BEnergyFeedBackTypeModel *model = self.FeedBackViewModel.datasArray[i];
            model.select = NO;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - BEnergyXYPhotoViewDelegate
- (void)addPictureInPhotoEditView:(BEnergyXYPhotoView *)photoEditView {
    [self chooseFeedBackImage];
}

- (void)deleteImageaWithIndex:(NSInteger)index {
    [self.imagesArray removeObjectAtIndex:index];
    self.photoView.imgsArray = self.imagesArray;
}

#pragma mark - LazyLoad

LCFLazyload(BEnergyFeedBackViewModel, FeedBackViewModel)
LCFLazyload(NSMutableDictionary, tagInfoDic)

- (NSMutableArray<UIImage *> *)imagesArray {
    if (!_imagesArray ){
        _imagesArray = [[NSMutableArray alloc] init];;
    }
    return _imagesArray;
}

- (BEnergyFeedBackHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[BEnergyFeedBackHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 32.0f)];
    }
    return _headerView;
}

- (BEnergyUserInfoModel *)userInfo {
    if (_userInfo == nil) {
        _userInfo = [[BEnergyUserInfoModel alloc] init];
        _userInfo = [BEnergySCUserStorage sharedInstance].userInfo;
    }
    return _userInfo;
}

- (NSMutableArray *)imageDataArray {
    if (!_imageDataArray) {
        _imageDataArray = [NSMutableArray new];
    }
    return _imageDataArray;
}
@end
