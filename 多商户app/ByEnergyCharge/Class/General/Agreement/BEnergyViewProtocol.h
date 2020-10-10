
//
//  BEnergyViewProtocol.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BEnergyViewProtocol <NSObject>

@optional

- (void) byEnergyInitViews;

- (void) byEnergySetViewLayout;

- (void) byEnergyInitViewModel;

- (void)fillDataWithDataModel:(BEnergyBaseModel *)baseModel;

@end

NS_ASSUME_NONNULL_END
