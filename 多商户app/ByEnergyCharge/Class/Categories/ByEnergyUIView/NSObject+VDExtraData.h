//
//  NSObject+VDExtraData.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VDExtraData;
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (VDExtraData)
- (VDExtraData *)vd_extraDataForKey:(NSString *)key;
- (VDExtraData *)vd_extraDataForSelector:(SEL)selector;
@end
@interface VDExtraData : NSObject

@property (nonatomic, strong) id data;
@property (nonatomic, weak) id weakData;
@property (nonatomic, strong) NSMutableArray *array;

@end

NS_ASSUME_NONNULL_END
