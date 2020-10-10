//
//  CarKeyBoardCellModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarKeyBoardCellModel : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, assign) BOOL sc_isChangedKeyBoardBtnType;
@property (nonatomic, assign) BOOL sc_isDeleteBtnType;
@property (nonatomic, assign) BOOL sc_isSpeciaBtnType;

@end

NS_ASSUME_NONNULL_END
