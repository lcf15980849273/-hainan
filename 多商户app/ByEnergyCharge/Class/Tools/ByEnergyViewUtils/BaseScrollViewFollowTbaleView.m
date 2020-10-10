//
//  BaseScrollViewFollowTbaleView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/18.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BaseScrollViewFollowTbaleView.h"

@interface BaseScrollViewFollowTbaleView ()<UIScrollViewDelegate>
@property (nonatomic ,copy) MoveBolck block;

@end
@implementation BaseScrollViewFollowTbaleView

- (instancetype)initRootScrollView:(UIScrollView *)rootScrollView AndRootScrollViewScrollRange:(CGFloat)scrollRange moveBolck:(MoveBolck)moveBolck{
    if (self = [super init]) {
        rootScrollView.delegate = self;
        self.canMove = YES;
        _block = moveBolck;
        self.scrollRange = scrollRange;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.contentoffsetBlock) {
        self.contentoffsetBlock(scrollView.contentOffset.y);
    }
//    NSLog(@"----%f",scrollView.contentOffset.y);
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat maxOffsetY = self.scrollRange;
    if (contentOffsetY > maxOffsetY) {
        [scrollView setContentOffset:CGPointMake(0, maxOffsetY)]; //  设置最大偏移
        // 告诉底部内容视图能进行滑动了
        if (_block) {
            _block(YES);
        }
        self.canMove = NO;   // 自己不能滑动了
    }
    if (self.canMove == NO) {
        [scrollView setContentOffset:CGPointMake(0, maxOffsetY)];
    }
}

@end
