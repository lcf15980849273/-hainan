//
//  CFImagePickerViewController.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/10/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BEnergyBaseViewController.h"
@class TZAlbumModel, TZAssetModel;

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, BDPublishType) {
    BDPublishTypeDefault = 0,
};
@interface CFImagePickerViewController : BEnergyBaseViewController

@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, assign) BOOL isMustChoose; // 图片是否必选
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, assign) NSInteger maxImagesCount;
@property (nonatomic, strong) TZAlbumModel *model;

/// Default is 828px / 默认828像素宽
@property (nonatomic, assign) CGFloat photoWidth;

@property(nonatomic, assign) BDPublishType publishType;

@property (nonatomic, copy) void (^backButtonClickHandle)(TZAlbumModel *model);

@property (nonatomic, copy) void (^didFinishPickingPhotosHandle)(NSArray<UIImage *> *photos,NSArray <TZAssetModel *>*assets,BOOL isSelectOriginalPhoto);

@property (nonatomic, copy) void (^didFinishPickingPhotosWithInfosHandle)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,NSArray<NSDictionary *> *infos);
@end

@interface PhotoCollectionView : UICollectionView

@end
NS_ASSUME_NONNULL_END
