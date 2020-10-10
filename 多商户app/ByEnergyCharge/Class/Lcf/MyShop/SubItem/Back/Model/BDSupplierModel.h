//
//  BDSupplierModel.h
//  bydeal
//
//  Created by yeenbin on 2019/1/10.
//  Copyright © 2019 BD. All rights reserved.
//

#import "BDModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDSupplierModel : BDModel

@property (nonatomic, copy) NSString *businessId; // 商户id
@property (nonatomic, copy) NSString *businessType; // 商户类型
@property (nonatomic, copy) NSString *businessName; // 商户名称

@end

NS_ASSUME_NONNULL_END
