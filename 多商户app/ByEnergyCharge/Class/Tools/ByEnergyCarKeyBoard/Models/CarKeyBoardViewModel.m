//
//  CarKeyBoardViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "CarKeyBoardViewModel.h"

NSString * const sc_province = @"京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领";
NSString * const sc_province_Regex = @"[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼A-Z]";
NSString * const sc_province_code_Regex = @"[A-Z]";
NSString * const sc_plateNo_code_Regex = @"[A-Z0-9]";
NSString * const sc_plateNo_code_end_Regx = @"[A-Z0-9挂学警港澳使领]";

@interface CarKeyBoardViewModel ()

@property (nonatomic, copy) NSArray *sc_provinces;
@property (nonatomic, copy) NSArray *sc_noAndChars;

@end

@implementation CarKeyBoardViewModel

- (instancetype)init {
    if (self = [super init]) {
        _isProvince = YES;
        self.dataSource = self.sc_provinces;
    }
    return self;
}

- (NSArray *)sc_provinces {
    if (!_sc_provinces) {
        NSArray <NSArray <NSString *>*> *province = @[@[@"京",@"津",@"冀",@"鲁",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪"],
                                                      @[@"苏",@"浙",@"皖",@"闽",@"赣",@"豫",@"鄂",@"湘",@"粤",@"桂"],
                                                      @[@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青"],
                                                      @[@"琼",@"新",@"港",@"澳",@"台",@"宁"]
                                                      ];
        NSMutableArray *array = [NSMutableArray new];
        [province enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull objArray, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *rowItems = [NSMutableArray new];
            [objArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CarKeyBoardCellModel *model = [[CarKeyBoardCellModel alloc] init];
                if ([obj isEqualToString:@"A"]) {
                    model.sc_isChangedKeyBoardBtnType = YES;
                    model.text = @"A";
                } else if ([obj isEqualToString:@"delete"]) {
                    model.sc_isDeleteBtnType = YES;
                    model.image = [UIImage imageNamed:@"CarKeyBoard_delete"];
                } else {
                    model.text = obj;
                }
                [rowItems addObject:model];
            }];
            [array addObject:rowItems];
        }];
        _sc_provinces = array.copy;
    }
    return _sc_provinces;
}

- (NSArray *)sc_noAndChars {
    if (!_sc_noAndChars) {
        NSArray <NSArray <NSString *>*> *province = @[
                                                      @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"],
                                                      @[@"港",@"警",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"P"],
                                                      @[@"澳",@"领",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                                                      @[@"学",@"使",@"O",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"delete"]
                                                      ];
        NSArray *speciaArray = @[@"港",@"警",@"澳",@"领",@"学",@"使"];
        NSMutableArray *array = [NSMutableArray new];
        [province enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull objArray, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *rowItems = [NSMutableArray new];
            [objArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CarKeyBoardCellModel *model = [[CarKeyBoardCellModel alloc] init];
                if ([obj isEqualToString:@"省"]) {
                    model.sc_isChangedKeyBoardBtnType = YES;
                    model.text = @"省";
                } else if ([obj isEqualToString:@"delete"]) {
                    model.sc_isDeleteBtnType = YES;
                    model.image = [UIImage imageNamed:@"CarKeyBoard_delete"];
                }else if ([speciaArray containsObject:obj]) {
                    model.sc_isSpeciaBtnType = YES;
                    model.text = obj;
                } else {
                    model.text = obj;
                }
                [rowItems addObject:model];
            }];
            [array addObject:rowItems];
        }];
        _sc_noAndChars = array.copy;
    }
    return _sc_noAndChars;
}

- (void)sc_changeKeyBoardType:(BOOL)showProvince {
    if (showProvince) {
        self.dataSource = self.sc_provinces.copy;
    } else {
        self.dataSource = self.sc_noAndChars.copy;
    }
    _isProvince = showProvince;
}


/**
 校验分四步
 1.拆分出省份（或军用） 即第一位是省份或字母
 2.拆分出城市代码      即第二位是字母
 3.拆分出中间录入的代码 即第三位至第6位（或更多位）
 4.拆分出最后一位      即最后一位可能为字母、数字、也可能是特殊汉字（如 学、警、挂）
 
 @param plateNo ..
 @return 将不合规则的字符移除
 */
+ (NSString *)sc_regexPlateNo:(NSString *)plateNo {
    NSMutableString *newText = [NSMutableString new];
    if (plateNo.length == 0) {
        return @"";
    }
    // 1
    NSString *province = [plateNo substringWithRange:NSMakeRange(0, 1)];
    BOOL result = [self sc_regexText:province regex:sc_province_Regex];
    if (result) {
        [newText appendString:province];
    }
    if (plateNo.length == 1) {
        return newText;
    }
    // 2
    NSString *provinceCode = [plateNo substringWithRange:NSMakeRange(1, 1)];
    result = [self sc_regexText:provinceCode regex:sc_province_code_Regex];
    if (result) {
        [newText appendString:provinceCode];
    }
    if (plateNo.length == 2) {
        return newText;
    }
    // 3
    NSString *plateCode = [plateNo substringWithRange:NSMakeRange(2, plateNo.length - 3)];
    for(int i =0; i < [plateCode length]; i++) {
        NSString *temp = [plateCode substringWithRange:NSMakeRange(i, 1)];
        result = [self sc_regexText:temp regex:sc_plateNo_code_Regex];
        if (result) {
            [newText appendString:temp];
        }
    }
    // 4
    NSString *plateEnd = [plateNo substringWithRange:NSMakeRange(plateNo.length - 1, 1)];
    result = [self sc_regexText:plateEnd regex:sc_plateNo_code_end_Regx];
    if (result) {
        [newText appendString:plateEnd];
    }
    return newText;
}

+ (NSString *)sc_regexPlateNo:(NSString *)plateNo index:(NSInteger)index maxCount:(NSInteger)maxCount {
    NSMutableString *newText = [NSMutableString new];
    BOOL result = NO;
    if (plateNo.length == 0) {
        return @"";
    }
    if (index == 0) {
        result = [self sc_regexText:plateNo regex:sc_province_Regex];
    }else if (index == 1) {
        result = [self sc_regexText:plateNo regex:sc_province_code_Regex];
    }else if (index == maxCount-1) {
        result = [self sc_regexText:plateNo regex:sc_plateNo_code_end_Regx];
    }else {
        result = [self sc_regexText:plateNo regex:sc_plateNo_code_Regex];
    }
    if (result) {
        [newText appendString:plateNo];
    }
    return newText;
}

+ (BOOL)sc_regexText:(NSString *)text regex:(NSString *)regex {
    NSString *regexText = [NSString stringWithFormat:@"^%@{%ld}$", regex, text.length];
    NSPredicate *regexResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexText];
    return [regexResult evaluateWithObject:text];
}


@end
