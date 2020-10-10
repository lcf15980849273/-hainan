//
//  BaseScrollViewFollowTbaleView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/18.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MoveBolck)(BOOL value);
@interface BaseScrollViewFollowTbaleView : NSObject
@property (nonatomic,assign)BOOL canMove;
@property (nonatomic,assign)CGFloat scrollRange;//上滑动距离
@property (nonatomic, copy) void(^contentoffsetBlock)(CGFloat offset);
//利用initRoot创建 给予底部上下滑动的ScrollView 要滑动的ScrollRange 大小和左右滑动的Table数组
- (instancetype)initRootScrollView:(UIScrollView *)rootScrollView AndRootScrollViewScrollRange:(CGFloat)scrollRange moveBolck:(MoveBolck)moveBolck;
@end
