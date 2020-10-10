//
//  CarNumberView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"
#import "CarNumberModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarNumberView : BEnergyBaseView

@property (nonatomic, strong) CarNumberModel *carNumberModel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isNewEnergyCar;
@property (nonatomic, copy) NSString *carNumber;
@property (nonatomic, copy) NSString *text;
@end

NS_ASSUME_NONNULL_END
