//
//  ChargeMoneyPopViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ChargeMoneyPopViewCell.h"
#import "MoneyCell.h"
@interface ChargeMoneyPopViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end

@implementation ChargeMoneyPopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:kMoneyCell bundle:nil] forCellWithReuseIdentifier:kMoneyCell];
}


- (void)setInfoModel:(BEnergyChargePayInfoModel *)infoModel {
    _infoModel = infoModel;
    self.tipsLabel.text = _infoModel.tips;
    for (int i = 0; i  < self.infoModel.chargeMoney.count; i ++) {
        ChargeMoneyModel *model = _infoModel.chargeMoney[i];
        model.isSelcet = i == 0 ? YES : NO;
    }
    [self.collectionView reloadData];
}



#pragma mark - CollectionView delegate and dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.infoModel.chargeMoney.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoneyCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kMoneyCell forIndexPath:indexPath];
    cell.model = self.infoModel.chargeMoney[indexPath.row];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREENWIDTH - 126) / 3, 34);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0,0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (int i = 0; i  < self.infoModel.chargeMoney.count; i ++) {
        if (i == indexPath.row) {
            ChargeMoneyModel *model = self.infoModel.chargeMoney[i];
            if (!model.isSelcet) {
                model.isSelcet = !model.isSelcet;
            }
        }else {
            ChargeMoneyModel *model = self.infoModel.chargeMoney[i];
            model.isSelcet = NO;
        }
    }
    [self.collectionView reloadData];
}
@end
