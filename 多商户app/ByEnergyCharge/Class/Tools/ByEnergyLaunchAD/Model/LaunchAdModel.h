//
//  LaunchAdModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/19.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LaunchAdModel : JSONModel

/**
 *  广告URL
 */
@property (nonatomic, copy) NSString *imgUrl;

/**
 *  点击打开连接
 */
@property (nonatomic, copy) NSString *refId;

/**
 *  广告类型ID
 */
@property (nonatomic, assign) int refType;


/**
 *  ID
 */
@property (nonatomic, copy) NSString *id;


/**
 *  广告分辨率
 */
@property (nonatomic, copy) NSString *contentSize;

/**
 *  广告停留时间
 */
@property (nonatomic, assign) NSInteger duration;


/**
 *  分辨率宽
 */
@property(nonatomic,assign,readonly)CGFloat width;
/**
 *  分辨率高
 */
@property(nonatomic,assign,readonly)CGFloat height;


@end
