//
//  BDCityBusinessModel.h
//  bydeal
//
//  Created by chenfeng on 2019/1/2.
//  Copyright © 2019年 BD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BDCityModel,BDBusinessModel,BDBusinessItemModel;
@interface BDCityBusinessModel : NSObject
@property (nonatomic,strong) NSArray <BDCityModel *>*citys;
@property (nonatomic,strong) NSArray <BDBusinessModel *>*business;
@end

@interface BDCityModel : NSObject
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *cityKey;
@end

@interface BDBusinessModel : NSObject
@property (nonatomic,strong) NSArray <BDBusinessItemModel *>*business;
@property (nonatomic,copy) NSString *cityKey;
@end

@interface BDBusinessItemModel : NSObject
@property (nonatomic,copy) NSString *businessId;
@property (nonatomic,copy) NSString *businessName;
@property (nonatomic,copy) NSString *businessType;
@end
