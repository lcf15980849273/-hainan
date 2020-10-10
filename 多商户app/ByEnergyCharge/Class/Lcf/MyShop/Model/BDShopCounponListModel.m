//
//  BDShopCounponListModel.m
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopCounponListModel.h"

@implementation BDShopCounponListModel

@end

@implementation BDShopCounponCollectListModel
- (BDShopCounponListModel *)counponListModel {
    if (self.extendJson.length > 0) {
        NSDictionary *dic = nil;
        BDShopCounponListModel *model = [BDShopCounponListModel yy_modelWithJSON:dic];
        _counponListModel = model;
        return model;
    }
    return nil;
}

@end
