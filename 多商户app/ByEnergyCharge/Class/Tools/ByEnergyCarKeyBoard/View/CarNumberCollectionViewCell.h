//
//  CarNumberCollectionViewCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/5/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarNumberCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)  UITextField *textField;
@property (nonatomic, copy) void(^textFieldBlock)(NSString *text,NSInteger tag,BOOL isDel);
@property (nonatomic, assign) BOOL isNewEnergyCar;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (void) fillCellContent:(NSString *)content isNewEnergyCar:(BOOL)isNewEnergyCar;
@end

NS_ASSUME_NONNULL_END
