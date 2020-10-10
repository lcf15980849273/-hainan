//
//  BEnergyCellRenderProtocol.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BEnergyCellRenderProtocol <NSObject>
///Cell对应的重用标识
- (NSString *)cellIdentifier;
@end
