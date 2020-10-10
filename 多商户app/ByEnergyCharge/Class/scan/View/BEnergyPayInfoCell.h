//
//  BEnergyPayInfoCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/24.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BEnergyPayTypeModel;
static NSString *const kBEnergyPayInfoCell = @"BEnergyPayInfoCell";
@interface BEnergyPayInfoCell : UITableViewCell
@property (nonatomic, strong) BEnergyPayTypeModel *model;
@end

@interface BEnergyPayTypeModel : NSObject
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *payTypeIcon;
@property (nonatomic, copy) NSString *payTitle;
@property (nonatomic, copy) NSString *selectIcon;
@property (nonatomic, copy) NSString *payDescrib;
@property (nonatomic, assign) BOOL isSelect;
@end
NS_ASSUME_NONNULL_END
