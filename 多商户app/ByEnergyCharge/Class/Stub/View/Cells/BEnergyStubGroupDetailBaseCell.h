//
//  BEnergyStubGroupDetailBaseCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum: NSInteger {
    BaseCellTypeForText,
    BaseCellTypeForChoose,
}BEnergyStubGroupDetailBaseCellType;

@interface BEnergyStubGroupDetailBaseCell : BEnergyBaseTableViewCell

- (instancetype)initWithType:(BEnergyStubGroupDetailBaseCellType)type reuseIdentifier:(NSString *)reuseIdentifier;

- (void)configUIWithTitle:(NSString *)title Content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
