//
//  BEnergyStubListCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/2.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEnergyStubGroupModel.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const kBEnergyStubListCell = @"BEnergyStubListCell";
@interface BEnergyStubListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *loactionBtn;
@property (nonatomic, strong) BEnergyStubGroupModel *groupModel;
@end

NS_ASSUME_NONNULL_END
