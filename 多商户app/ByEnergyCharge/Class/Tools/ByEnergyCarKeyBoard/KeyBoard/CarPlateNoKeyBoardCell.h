//
//  CarPlateNoKeyBoardCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarKeyBoardCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarPlateNoKeyBoardCell : UICollectionViewCell
@property (nonatomic, strong) CarKeyBoardCellModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void(^sc_clicked)(NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
