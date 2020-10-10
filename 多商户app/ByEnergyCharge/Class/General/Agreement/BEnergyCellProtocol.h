//
//  BEnergyCellProtocol.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyBaseModel.h"

@protocol BEnergyCellProtocol <NSObject>
@optional

- (void) byEnergyInitViews;


- (void) byEnergySetViewLayout;

- (void) byEnergyInitViewModel;

- (void) byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel;

@end
