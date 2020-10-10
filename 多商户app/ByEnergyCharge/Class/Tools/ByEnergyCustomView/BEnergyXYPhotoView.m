//
//  BEnergyXYPhotoView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyXYPhotoView.h"
#import "BEnergyPhotoEditCell.h"
#define COUNT self.imgsArray.count
@implementation BEnergyXYPhotoView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

-(void)setUp {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.photoCollectionView];
    [_photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

+(CGFloat)getHeightWithArrayCount:(NSInteger)count {
    CGFloat heightD = 165 / 3;
    switch ((int)SCREENWIDTH) {
        case 375:
            heightD = 225 / 3;
            break;
        case 414:
            heightD = 280 / 3;
            break;
        default:
            break;
    }
    CGFloat height = 0;
    NSInteger rate = 1;
    if (count > 3 && count < 6) {
        rate = 2;
    }else if (count >= 6){
        rate = 3;
    }
    height = heightD * rate;
    return height;
}

+(CGFloat)getWidthWithArrayCount:(NSInteger)count {
    CGFloat width = 261 / 3;
    switch ((int)SCREENWIDTH) {
        case 375:
            width = 291 / 3;
            break;
        case 414:
            width = 255 / 3;
            break;
        default:
            break;
    }
    CGFloat collectViewWidth = 0;
    NSInteger rate = 1;
    if (count >= 2) {
        rate = 3;
    }else {
        rate = 2;
    }
    collectViewWidth = width * rate;
    return collectViewWidth;
}

-(void)setImgsArray:(NSArray *)imgsArray {
    _imgsArray = imgsArray;
    for (UIView *view in self.photoCollectionView.subviews) {
        [view removeFromSuperview];
    }
    [UIView transitionWithView:self.photoCollectionView duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
            [self.photoCollectionView reloadData];
        }  completion: ^(BOOL isFinished) {
            
        }];
   
   
}

#pragma mark - CollectionView delegate and dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (COUNT == self.maxCount) {
        return COUNT;
    }
    return COUNT + 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    BEnergyPhotoEditCell *myCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"BEnergyPhotoEditCell" forIndexPath:indexPath];
    [myCell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [myCell.imageView setContentMode:UIViewContentModeScaleToFill];
    myCell.imageView.tag = row;
    myCell.deleteButton.tag = row;
    
    if (COUNT == self.maxCount) {
        myCell.deleteButton.hidden = NO;
        id pic = self.imgsArray[row];
        if ([pic isKindOfClass:[NSString class]]) {
            [myCell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imgsArray[row]] placeholderImage:nil];
        }else{
            myCell.imageView.image = self.imgsArray[row];
        }
    }else if (COUNT < self.maxCount){
        if (row == COUNT) {
            myCell.imageView.image = [UIImage imageNamed:@"add_pic"];
            [myCell.imageView setContentMode:UIViewContentModeScaleToFill];
            myCell.deleteButton.hidden = YES;
        }else{
            myCell.deleteButton.hidden = NO;
            myCell.imageView.image = self.imgsArray[row];
        }
    }
    return myCell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (SCREENWIDTH == 320) {
        return CGSizeMake(55, 55);
    }else if (SCREENWIDTH == 375){
        return CGSizeMake(75, 75);
    }
    return CGSizeMake(85, 85);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (COUNT != self.maxCount && indexPath.row == COUNT) {//弹出选择照片选项
        if ([self.delegate respondsToSelector:@selector(addPictureInPhotoEditView:)]) {
            [self.delegate addPictureInPhotoEditView:self];
        }
    }else {
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.sourceImagesContainerView = self.photoCollectionView;
        browser.delegate = self;
        browser.currentImageIndex = indexPath.row;
        browser.imageCount = self.imgsArray.count;
        [browser show];
    }
}


- (void)deleteButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteImageaWithIndex:)]) {
        [self.delegate deleteImageaWithIndex:sender.tag];
    }
}

#pragma mark - SDPhotoBrowserDelegate
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return self.imgsArray[index];
    
}

#pragma mark - lazyLoad
-(UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        _photoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_photoCollectionView registerClass:[BEnergyPhotoEditCell class] forCellWithReuseIdentifier:@"BEnergyPhotoEditCell"];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.backgroundColor = [UIColor clearColor];
    }
    return _photoCollectionView;
}

@end
