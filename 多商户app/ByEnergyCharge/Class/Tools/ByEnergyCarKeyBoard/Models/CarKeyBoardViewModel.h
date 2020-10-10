//
//  CarKeyBoardViewModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarKeyBoardCellModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const sc_province;
extern NSString * const sc_province_Regex;
extern NSString * const sc_province_code_Regex;
extern NSString * const sc_plateNo_code_Regex;
extern NSString * const sc_plateNo_code_end_Regx;

@interface CarKeyBoardViewModel : NSObject

@property (nonatomic, copy) NSArray <NSArray <CarKeyBoardCellModel *> *> *dataSource;

@property (nonatomic, assign) BOOL isProvince;

- (void)sc_changeKeyBoardType:(BOOL)showProvince;


+ (NSString *)sc_regexPlateNo:(NSString *)plateNo;
+ (NSString *)sc_regexPlateNo:(NSString *)plateNo index:(NSInteger)index maxCount:(NSInteger)maxCount;
+ (BOOL)sc_regexText:(NSString *)text regex:(NSString *)regex;
@end

NS_ASSUME_NONNULL_END
