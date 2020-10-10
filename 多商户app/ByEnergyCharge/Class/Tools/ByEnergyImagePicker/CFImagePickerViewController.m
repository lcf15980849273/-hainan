//
//  CFImagePickerViewController.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/10/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CFImagePickerViewController.h"
#import "TZPhotoPreviewController.h"
#import "TZAssetCell.h"
#import "TZAssetModel.h"
#import "UIView+Layout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZGifPhotoPreviewController.h"
#import "CFButton.h"
@interface CFImagePickerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) PhotoCollectionView *photoCollectionView;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) CFButton *skipButton;
@property (nonatomic, strong) UIButton *nextStepButton;
@property (nonatomic, strong) NSMutableArray *selectedImageArray;
@property (nonatomic, strong) NSMutableArray *selectedImageInfos;
@property (nonatomic, strong) NSMutableArray<TZAssetModel *> *selectedModels;
@end

@implementation CFImagePickerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isSelectOriginalPhoto = YES;
//    self.maxImagesCount = self.maxImagesCount > 0 ? self.maxImagesCount : 9;
    if (self.titleStr) {
        self.navigationItem.title = self.titleStr;
    }
    self.photoWidth = 828.0;
    self.columnNumber = 3;
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"tz_allowPickingVideo"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"tz_allowPickingImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initSubviews];
    
    [self fetchAlbumData];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.photoCollectionView zm_layoutLeft:0.0f width:self.view.zm_width];
    [self.photoCollectionView zm_layoutTop:0.0f height:self.view.zm_height - self.bottomView.zm_height];
    self.bottomView.zm_y = self.view.zm_height - self.bottomView.zm_height;
    [self.bottomView zm_layoutLeft:0.0f width:self.view.zm_width];
    [self.skipButton zm_layoutLeft:15 width:self.view.zm_width - 2 * 15.0];
    [self.nextStepButton zm_layoutLeft:15 width:self.view.zm_width - 2 * 15.0];
}

- (void)initSubviews {
    
    [self.view addSubview:self.photoCollectionView];
    [self.photoCollectionView registerClass:[TZAssetCell class] forCellWithReuseIdentifier:@"TZAssetCell"];
    [self.photoCollectionView registerClass:[TZAssetCameraCell class] forCellWithReuseIdentifier:@"TZAssetCameraCell"];
    [self configBottomToolBar];
}

- (void)fetchAlbumData {
    if ([[TZImageManager manager] authorizationStatus] == PHAuthorizationStatusDenied) {
        // 无权限 做一个友好的提示
        [BEnergyCustomAlertView showAlertViewWithTitle:@"选择照片需要您允许“有言在先”访问您的相册"
                                buttonArray:@[@"确定"]
                                      block:^(BEnergyCustomAlertView *target, NSInteger buttonIndex) {
//                                          if (buttonIndex == 1) {
//                                              [BDSystemJurisdictionHandleTool gotoBDSystemSetter];
//                                          }
                                      }];
    }else if ([[TZImageManager manager] authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        [self hnByEnergyAfter:2 action:^{
            if (self.model.models.count == 0) {
                [self fetchAlbumData];
            }
            
        }];
    }
    else {
        [[TZImageManager manager] getCameraRollAlbum:NO
                                   allowPickingImage:YES
                                          completion:^(TZAlbumModel *model) {
                                              self.model = model;
                                          }];
    }
}

- (void)setModel:(TZAlbumModel *)model {
    _model = model;
    
    if (self.model.count > 0) {
        [self checkSelectedModels];
    }
    [self.photoCollectionView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.backButtonClickHandle) {
        self.backButtonClickHandle(_model);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)configBottomToolBar {
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.nextStepButton];
    if (self.publishType != BDPublishTypeDefault) {
        if (!self.isMustChoose) {
            [self.bottomView addSubview:self.skipButton];
        }
        else {
            self.bottomView.zm_height = 86.0f;
            self.nextStepButton.zm_y = 20.0f;
        }
        
        [self.nextStepButton setTitle:[NSString stringWithFormat:@"下一步 （%lu/%ld）", (unsigned long)self.selectedModels.count, (long)self
                                       .maxImagesCount] forState:UIControlStateNormal];
    }
    else {
        self.bottomView.zm_height = 86.0f;
        self.nextStepButton.zm_y = 20.0f;
        [self.nextStepButton setTitle:[NSString stringWithFormat:@"完成 （%lu/%ld）", (unsigned long)self.selectedModels.count, (long)self
                                       .maxImagesCount] forState:UIControlStateNormal];
    }
}

- (void)refreshBottomToolBarStatus {
    if (self.publishType != BDPublishTypeDefault) {
        [self.nextStepButton setTitle:[NSString stringWithFormat:@"下一步 （%lu/%ld）", (unsigned long)self.selectedModels.count, (long)self
                                       .maxImagesCount] forState:UIControlStateNormal];
    }
    else {
        [self.nextStepButton setTitle:[NSString stringWithFormat:@"完成 （%lu/%ld）", (unsigned long)self.selectedModels.count, (long)self
                                       .maxImagesCount] forState:UIControlStateNormal];
    }
}

//- (void)navigationBackItemDidTap:(id)sender {
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - Click Event

- (void)handleNextStepButtonTaped:(UIButton *)sender {
    if (self.selectedModels.count == 0 && self.isMustChoose) {
        [HUDManager showStateHud:@"请至少选择一张图片" state:HUDStateTypeWarning];
        return;
    }
    [HUDManager showLoading];
    
    dispatch_group_t group = dispatch_group_create();
    ByEnergyWeakSekf(self);
    [self.selectedImageArray removeAllObjects];
    
    [TZImageManager manager].shouldFixOrientation = YES;
    for (NSInteger i = 0; i < self.selectedModels.count; i++) {
        dispatch_group_enter(group);
        TZAssetModel *model = self.selectedModels[i];
        [[TZImageManager manager] getOriginalPhotoDataWithAsset:model.asset
                                                     completion:^(NSData *data, NSDictionary *info, BOOL isDegraded) {
                                                         if (data) {
                                                             UIImage *photo = [UIImage imageWithData:data scale:0.5];
                                                             photo = [self scaleImage:photo toSize:CGSizeMake(self.photoWidth, (int)(self.photoWidth * photo.size.height / photo.size.width))];
                                                             [self.selectedImageArray addObject:photo];
                                                             [self.selectedImageInfos addObject:info];
                                                         }
                                                         dispatch_group_leave(group);
                                                     }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        ByEnergyStrongSelf(self);
        [HUDManager hidenHud];
        [self handleGotoTopicPublishPage];
    });
}

- (void)handleSkipButtonTaped:(UIButton *)sender {
    [self.selectedImageArray removeAllObjects];
    [self.selectedModels removeAllObjects];
    [self handleGotoTopicPublishPage];
}

- (void)handleGotoTopicPublishPage {
    if (self.didFinishPickingPhotosHandle) {
        self.didFinishPickingPhotosHandle(self.selectedImageArray,self.selectedModels,_isSelectOriginalPhoto);
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else if (self.didFinishPickingPhotosWithInfosHandle) {
        self.didFinishPickingPhotosWithInfosHandle(self.selectedImageArray, self.selectedModels, _isSelectOriginalPhoto, self.selectedImageInfos);
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
}

- (void)clearAllSelections{
    for (TZAssetModel *model in self.model.models) {
        model.isSelected = NO;
    }
    [self.selectedModels removeAllObjects];
    [self.photoCollectionView reloadData];
}

- (void)didGetAllPhotos:(NSArray *)photos assets:(NSArray *)assets infoArr:(NSArray *)infoArr {
    [HUDManager hidenHud];
    
    [self callDelegateMethodWithPhotos:photos assets:assets infoArr:infoArr];
}

- (void)callDelegateMethodWithPhotos:(NSArray *)photos assets:(NSArray *)assets infoArr:(NSArray *)infoArr {
    
    if (self.didFinishPickingPhotosHandle) {
        self.didFinishPickingPhotosHandle(photos,assets,_isSelectOriginalPhoto);
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.models.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // the cell lead to take a picture / 去拍照的cell
    if (indexPath.row == 0) {
        TZAssetCameraCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZAssetCameraCell" forIndexPath:indexPath];
        cell.imageView.image = IMAGEWITHNAME(@"camera_takepicture");
        return cell;
    }
    // the cell dipaly photo or video / 展示照片或视频的cell
    TZAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZAssetCell" forIndexPath:indexPath];
    cell.photoDefImageName = @"feedBackNomal";
    cell.photoSelImageName = @"feedBackSelect";
    TZAssetModel *model;
    model = self.model.models[indexPath.row - 1];
    cell.allowPickingGif = YES;
    cell.model = model;
    cell.showSelectBtn = YES;
    cell.selectPhotoButton.frame = cell.bounds;
    
    __weak typeof(cell) weakCell = cell;
    __weak typeof(self) weakSelf = self;
    //    __weak typeof(_numberImageView.layer) weakLayer = _numberImageView.layer;
    cell.didSelectPhotoBlock = ^(BOOL isSelected) {
        if (self.maxImagesCount == 1) {
            [self clearAllSelections];
        }
        // 1. cancel select / 取消选择
        if (isSelected) {
            weakCell.selectPhotoButton.selected = NO;
            model.isSelected = NO;
            NSArray *selectedModels = [NSArray arrayWithArray:self.selectedModels];
            for (TZAssetModel *model_item in selectedModels) {
                if ([[[TZImageManager manager] getAssetIdentifier:model.asset] isEqualToString:[[TZImageManager manager] getAssetIdentifier:model_item.asset]]) {
                    [self.selectedModels removeObject:model_item];
                    break;
                }
            }
            [weakSelf refreshBottomToolBarStatus];
        } else {
            // 2. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
            if (self.selectedModels.count < self.maxImagesCount) {
                weakCell.selectPhotoButton.selected = YES;
                model.isSelected = YES;
                [self.selectedModels addObject:model];
                [weakSelf refreshBottomToolBarStatus];
            } else {
                [HUDManager showStateHud:[NSString stringWithFormat:@"最多选择%ld张", (long)self.maxImagesCount] state:HUDStateTypeFail];
            }
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // take a photo / 去拍照
    if (indexPath.row == 0)  {
        [self takePhoto]; return;
    }
    // preview phote or video / 预览照片或视频
    //    NSInteger index = index = indexPath.row - 1;
    //    TZAssetModel *model = _models[index];
    //    TZPhotoPreviewController *photoPreviewVc = [[TZPhotoPreviewController alloc] init];
    //    photoPreviewVc.currentIndex = index;
    //    photoPreviewVc.models = _models;
    //    [self pushPhotoPrevireViewController:photoPreviewVc];
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat margin = 5;
    CGFloat itemWH = (SCREENWIDTH - (self.columnNumber + 1) * margin) / self.columnNumber;
    return CGSizeMake(itemWH, itemWH);
}

#pragma mark - UIScrollViewDelegate
#pragma mark - Private Method

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
        // 无权限 做一个友好的提示
        [BEnergyCustomAlertView showAlertViewWithTitle:@"拍照需要您允许”海控充电“访问您的相机"
                                buttonArray:@[@"确定"]
                                      block:^(BEnergyCustomAlertView *target, NSInteger buttonIndex) {
                                          
                                      }];
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)pushPhotoPrevireViewController:(TZPhotoPreviewController *)photoPreviewVc {
    __weak typeof(self) weakSelf = self;
    photoPreviewVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    [photoPreviewVc setBackButtonClickBlock:^(BOOL isSelectOriginalPhoto) {
        weakSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
        [weakSelf.photoCollectionView reloadData];
    }];
    [photoPreviewVc setDoneButtonClickBlock:^(BOOL isSelectOriginalPhoto) {
        weakSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
        [weakSelf handleNextStepButtonTaped:nil];
    }];
    [photoPreviewVc setDoneButtonClickBlockCropMode:^(UIImage *cropedImage, id asset) {
        [weakSelf didGetAllPhotos:@[cropedImage] assets:@[asset] infoArr:nil];
    }];
    [self.navigationController pushViewController:photoPreviewVc animated:YES];
}

/// Scale image / 缩放图片
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)checkSelectedModels {
    for (TZAssetModel *model in self.model.models) {
        model.isSelected = NO;
        NSMutableArray *selectedAssets = [NSMutableArray array];
        for (TZAssetModel *model in self.selectedModels) {
            [selectedAssets addObject:model.asset];
        }
        if ([[TZImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            model.isSelected = YES;
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (image) {
            [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
                if (!error) {
                    [self reloadPhotoArray];
                }
            }];
        }
    }
}

- (void)reloadPhotoArray {
    ByEnergyWeakSekf;
    [[TZImageManager manager] getCameraRollAlbum:NO
                               allowPickingImage:YES
                                      completion:^(TZAlbumModel *model) {
                                          self.model = model;
                                          [[TZImageManager manager] getAssetsFromFetchResult:model.result
                                                                           allowPickingVideo:NO
                                                                           allowPickingImage:YES
                                                                                  completion:^(NSArray<TZAssetModel *> *models) {
                                                                                      ByEnergyStrongSelf;
                                                                                      [HUDManager hidenHud];
                                                                                      
                                                                                      TZAssetModel *assetModel = [self.model.models firstObject];
                                                                                      
                                                                                      if (self.maxImagesCount == 1) {
                                                                                          [self clearAllSelections];
                                                                                      }
                                                                                      if (self.selectedModels.count < self.maxImagesCount) {
                                                                                          assetModel.isSelected = YES;
                                                                                          [self.selectedModels addObject:assetModel];
                                                                                          [self refreshBottomToolBarStatus];
                                                                                      }
                                                                                      [self.photoCollectionView reloadData];
                                                                                      
                                                                                  }];
                                      }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    //NSLog(@"TZPhotoPickerController dealloc");
}

#pragma mark Lazy Load
- (PhotoCollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat margin = 5;
        layout.minimumInteritemSpacing = margin;
        layout.minimumLineSpacing = margin;
        
        _photoCollectionView = [[PhotoCollectionView alloc] initWithFrame:CGRectMake(0, NavigationStatusBarHeight,375.0f, 522.0f) collectionViewLayout:layout];
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
        _photoCollectionView.dataSource = self;
        _photoCollectionView.delegate = self;
        _photoCollectionView.alwaysBounceHorizontal = NO;
        _photoCollectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    }
    
    return _photoCollectionView;
}

- (UIImagePickerController *)imagePickerVc {
    if (!_imagePickerVc) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
    }
    return _imagePickerVc;
}


- (NSMutableArray<TZAssetModel *> *)selectedModels {
    if (!_selectedModels) {
        _selectedModels = [NSMutableArray new];
    }
    return _selectedModels;
}

- (NSMutableArray *)selectedImageArray {
    if (!_selectedImageArray) {
        _selectedImageArray = [NSMutableArray new];
    }
    
    return _selectedImageArray;
}

- (NSMutableArray *)selectedImageInfos {
    if (!_selectedImageInfos) {
        _selectedImageInfos = [NSMutableArray new];
    }
    
    return _selectedImageInfos;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 522.0f, 375.0f, 145.0f)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (CFButton *)skipButton {
    if (!_skipButton) {
        CGRect frame = CGRectMake(15, 26.0f, 345.0f, 16.0f);
        CFButton *obj = [CFButton buttonWithType:UIButtonTypeCustom];
        obj.frame = frame;
        obj.alignment = BDButtonAlignmentHorizontalImageRight;
        [obj setTitle:@"跳过图片选择"];
        [obj setTitleColor:BYENERGYCOLOR(0x181818) forState:UIControlStateNormal];
        obj.titleLabel.font = ByEnergyRegularFont(14);
        [obj setImageName:@"skip_select_photo"];
        [obj addTarget:self
                action:@selector(handleSkipButtonTaped:)
      forControlEvents:UIControlEventTouchUpInside];
        _skipButton = obj;
    }
    return _skipButton;
}

- (UIButton *)nextStepButton {
    if (!_nextStepButton) {
        CGRect frame = CGRectMake(15, 69.0f, 345.0f, 46.0f);
        _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepButton.titleLabel.font = ByEnergyRegularFont(18);
        [_nextStepButton setTitleColor:BYENERGYCOLOR(0xffffff) forState:UIControlStateNormal];
        _nextStepButton.frame = frame;
        _nextStepButton.backgroundColor = BYENERGYCOLOR(0x00BFE5);
        _nextStepButton.layer.cornerRadius = 5;
        _nextStepButton.layer.masksToBounds = YES;
        [_nextStepButton addTarget:self
                            action:@selector(handleNextStepButtonTaped:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _nextStepButton;
}


@end

@implementation PhotoCollectionView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
