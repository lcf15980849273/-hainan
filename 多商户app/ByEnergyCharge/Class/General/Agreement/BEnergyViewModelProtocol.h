//
//  BEnergyViewModelProtocol.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyBaseModel.h"

@protocol BEnergyViewModelProtocol <NSObject>

@optional
- (void)sc_setModel:(BEnergyBaseModel *)baseModel;

@end
