//
//  BEnergyXYPhotoView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"
@class BEnergyXYPhotoView;
NS_ASSUME_NONNULL_BEGIN
@protocol BEnergyXYPhotoViewDelegate <NSObject>
// 添加照片的操作
-(void)addPictureInPhotoEditView:(BEnergyXYPhotoView *)photoEditView;
//删除照片的操作
-(void)deleteImageaWithIndex:(NSInteger)index;
@end

@interface BEnergyXYPhotoView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>

+(CGFloat)getHeightWithArrayCount:(NSInteger )count;
+(CGFloat)getWidthWithArrayCount:(NSInteger)count;
@property (strong, nonatomic)  UICollectionView *photoCollectionView;
@property (assign,nonatomic) id<BEnergyXYPhotoViewDelegate> delegate;
@property (nonatomic,strong) NSArray *imgsArray;
@property (nonatomic,assign)NSInteger maxCount;//最多展示图片的张数
@end

NS_ASSUME_NONNULL_END
