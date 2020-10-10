//
//  BEnergyCarListModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/27.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyCarListModel : BEnergyBaseModel

@property (nonatomic, copy) NSString *carNumber;
@property (nonatomic, assign) BOOL defaultFlag;
@property (nonatomic, copy) NSString *carTypeUserId;
@end

NS_ASSUME_NONNULL_END
