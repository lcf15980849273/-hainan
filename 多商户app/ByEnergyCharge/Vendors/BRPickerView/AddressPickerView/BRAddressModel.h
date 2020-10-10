//
//  BRAddressModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BRProvinceModel, BRCityModel, BRTownModel;

@interface BRProvinceModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *city;

@end

@interface BRCityModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *town;

@end


@interface BRTownModel : NSObject

@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
