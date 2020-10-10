//
//  BDMyShopParamModel.h
//  bydeal
//
//  Created by chenfeng on 2018/12/26.
//  Copyright © 2018年 BD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDMyShopParamModel : NSObject
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *cityCode;
@property (nonatomic,copy) NSString *businessName;
@property (nonatomic,copy) NSString *typeName;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,copy) NSString *mainCategoryId;//类目ID
@property (nonatomic,copy) NSString *businessId;//类目ID

@property (nonatomic,assign) NSInteger outNum;
@property (nonatomic,assign) NSInteger putNum;
@end
