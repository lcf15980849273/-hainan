//
//  BDShopCounponListModel.h
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDShopCounponListModel : NSObject
@property (nonatomic,copy) NSString *storeCardId;//小店优惠卡id
@property (nonatomic,copy) NSString *storeName;//小店店名
@property (nonatomic,copy) NSString *storeLogo;//小店logo
@property (nonatomic,copy) NSString *businessName;//来自商号的名称
@property (nonatomic,copy) NSString *cardDistinct;//优惠卡享受折扣
@property (nonatomic,assign) BOOL isCollection;
@end
@class BDShopCounponListModel;
@interface BDShopCounponCollectListModel : NSObject
@property (nonatomic,copy) NSString *extendJson;//我的收藏数据结构
@property (nonatomic,strong) BDShopCounponListModel *counponListModel;
@end


