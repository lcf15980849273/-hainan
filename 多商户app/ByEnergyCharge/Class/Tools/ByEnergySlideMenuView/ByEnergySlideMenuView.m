//
//  ByEnergySlideMenuView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/4.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ByEnergySlideMenuView.h"

@interface ByEnergySlideMenuView()<UIScrollViewDelegate>
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *controllers;
@property(nonatomic,strong)UIScrollView *tabScrollView;
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,assign)int itemSelectedIndex;
@property(nonatomic,assign)CGFloat itemMargin;
@property(nonatomic,strong)NSMutableArray <UILabel *>*items;
@property(nonatomic,strong)UIImageView *indicatorView;
@property(nonatomic,assign)int leftIndex;
@property(nonatomic,assign)int rightIndex;
@property(nonatomic,assign)CGFloat indicatorAnimatePadding;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIVisualEffectView *blurView;
@property(nonatomic,strong)UIFont *itemFont;
@property(nonatomic,strong)UIColor *itemSelectedColor;
@property(nonatomic,strong)UIColor *itemUnselectedColor;
@property(nonatomic,assign)CGFloat bottomPadding;
@property(nonatomic,assign)CGFloat indicatorHeight;
@property(nonatomic,strong)UIImage *indicatorImg;
@property (nonatomic, copy) SlideMenuViewBlock slideMenuViewBlock;
@property(nonatomic,assign)BOOL isVertical;//竖直滚动
@end

@implementation ByEnergySlideMenuView

- (UIVisualEffectView *)blurView
{
    if (!_blurView) {
        _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _blurView.frame = self.bounds;
    }
    return _blurView;
}
- (UIView *)line {
    
    if (_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
        _line.frame = CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5);
    }
    return _line;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles childControllers:(NSArray<UIViewController *> *)controllers
{
    if (self = [super initWithFrame:frame]) {
        _itemMargin = 15.0;
        _indicatorAnimatePadding = 8.0;
        _itemFont = [UIFont systemFontOfSize:13];
        _itemSelectedColor = [UIColor redColor];
        _itemUnselectedColor = [UIColor blackColor];
        _bottomPadding = 2.0;
        _indicatorHeight = 2.0;
        _tabScrollView = [[UIScrollView alloc] init];
        _mainScrollView = [[UIScrollView alloc] init];
        _titles = titles;
        _controllers = controllers;
        _items = [NSMutableArray array];
        _indicatorView = [[UIImageView alloc] init];
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [self addSubview:self.blurView];
        [self setupTabScrollView];
        [self setupIndicatorView];
        [self addSubview:self.line];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame SlideMenuModel:(ByEnergySlideMenuModel *)slideMenuModel completion:(void (^)(NSInteger index))completion {
    if (self = [super initWithFrame:frame]) {
        self.slideMenuModel = slideMenuModel;
        _itemMargin = _slideMenuModel.itemMargin?:15.0;
        _indicatorAnimatePadding = _slideMenuModel.indicatorAnimatePadding?:8.0;
        _itemFont = _slideMenuModel.itemFont?:[UIFont systemFontOfSize:13];
        _itemSelectedColor = _slideMenuModel.itemSelectedColor?:[UIColor redColor];
        _itemUnselectedColor = _slideMenuModel.itemUnselectedColor?:[UIColor blackColor];
        _bottomPadding = _slideMenuModel.bottomPadding?:2.0;
        _indicatorHeight = _slideMenuModel.indicatorHeight?:2.0;
        _tabScrollView = [[UIScrollView alloc] init];
        _mainScrollView = [[UIScrollView alloc] init];
        _titles = _slideMenuModel.titles;
        _controllers = _slideMenuModel.controllers;
        _items = [NSMutableArray array];
        _indicatorView = [[UIImageView alloc] init];
        _indicatorImg = _slideMenuModel.indicatorImg;
        self.slideMenuViewBlock = completion;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [self addSubview:self.blurView];
        [self setupTabScrollView];
        [self setupIndicatorView];
        [self addSubview:self.line];
    }
    return self;
}

- (void)setSlideMenuModel:(ByEnergySlideMenuModel *)slideMenuModel {
    _slideMenuModel = slideMenuModel;
    _titles = slideMenuModel.titles;
    if (_items.count  == slideMenuModel.titles.count ) {
        kWeakSelf(self);
        [_titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *item = [weakself.items objectAtIndex:idx];
            item.userInteractionEnabled = YES;
            //计算title长度
            CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : weakself.itemFont}];
            item.width = size.width;
            //设置属性
            item.text = byEnergyClearNilStr(title);
            [weakself.items replaceObjectAtIndex:idx withObject:item];
        }];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupMainScrollView];
}
#pragma mark --- 配置控制器滑动scrollView
- (void)setupMainScrollView
{
    if (_mainScrollView.superview == nil) {
        _mainScrollView.frame = self.superview.bounds;
        [self.superview insertSubview:_mainScrollView belowSubview:self];
        _mainScrollView.contentSize = CGSizeMake(_controllers.count * _mainScrollView.bounds.size.width,0);
        _mainScrollView.bounces = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.showsVerticalScrollIndicator = _slideMenuModel.showsVerticalScrollIndicator?:false;
        _mainScrollView.showsHorizontalScrollIndicator = _slideMenuModel.showsHorizontalScrollIndicator?:false;
         _mainScrollView.bounces = _slideMenuModel.bounces;
    }
    
    [self setupChildControllers];
}
#pragma mark --- 配置子控制器
- (void)setupChildControllers
{
    kWeakSelf(self);
    [_controllers enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakself.mainScrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(idx * weakself.mainScrollView.bounds.size.width, 0,  weakself.mainScrollView.bounds.size.width, weakself.mainScrollView.bounds.size.height);
    }];
    
}
#pragma mark --- 配置导航栏
- (void)setupTabScrollView
{
    _tabScrollView.frame = self.bounds;
    _tabScrollView.showsVerticalScrollIndicator = false;
    _tabScrollView.showsHorizontalScrollIndicator = false;
    _tabScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tabScrollView];
    
    __block CGFloat originX = _itemMargin;
    kWeakSelf(self);
    [_titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *item = [[UILabel alloc] init];
        item.userInteractionEnabled = YES;
        //计算title长度
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : weakself.itemFont}];
        item.frame = CGRectMake(originX,0,size.width,self.bounds.size.height);
        //设置属性
        item.text = title;
        item.clipsToBounds = NO;
        item.font = weakself.itemFont;
        item.textColor = idx == weakself.itemSelectedIndex ? weakself.itemSelectedColor : weakself.itemUnselectedColor;
        //添加tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemDidClicked:)];
        [item addGestureRecognizer:tap];
        
        [weakself.items addObject:item];
        [weakself.tabScrollView addSubview:item];
        
        originX = CGRectGetMaxX(item.frame) + weakself.itemMargin * 2;
        
    }];
    
    _tabScrollView.contentSize = CGSizeMake(originX - _itemMargin,self.bounds.size.height);
    [_tabScrollView addSubview:_indicatorView];
    
    if (_tabScrollView.contentSize.width < self.bounds.size.width) {
        //如果item的长度小于self的width，就重新计算margin排版
        [self updateLabelsFrame];
    }
    
}
#pragma mark --- item点击事件
- (void)itemDidClicked:(UITapGestureRecognizer *)gesture
{
    UILabel *item = (UILabel *)gesture.view;
    if (item == _items[_itemSelectedIndex]) return;
    int fromIndex = _itemSelectedIndex;
    _itemSelectedIndex = (int)[_items indexOfObject:item];
    
    [self changeItemTitleFromIndex:fromIndex to:_itemSelectedIndex];
    [self changeIndicatorViewPositionFromIndex:fromIndex to:_itemSelectedIndex];
    
    
    [self resetTabScrollViewContentOffset:item];
    
    [self resetMainScrollViewContentOffset:_itemSelectedIndex isBlock:YES];
}

- (void)byEnergyslideSelectorItemDidClicked:(int)index {
    int fromIndex = _itemSelectedIndex;
    if (_itemSelectedIndex == index) {
        return;
    }
    _itemSelectedIndex = index;
    UILabel *item = _items[index];
    [self changeItemTitleFromIndex:fromIndex to:_itemSelectedIndex];
    [self changeIndicatorViewPositionFromIndex:fromIndex to:_itemSelectedIndex];
    
    
    [self resetTabScrollViewContentOffset:item];
    
    [self resetMainScrollViewContentOffset:_itemSelectedIndex isBlock:NO];
}

#pragma mark --- 改变itemTitle
- (void)changeItemTitleFromIndex:(int)from to:(int)to
{
    _items[from].textColor = _itemUnselectedColor;
    _items[to].textColor = _itemSelectedColor;
}
#pragma mark --- 改变indicatorView位置
- (void)changeIndicatorViewPositionFromIndex:(int)from to:(int)to
{
    CGRect frame = _items[to].frame;
    CGRect indicatorFrame = CGRectMake(frame.origin.x,_indicatorView.frame.origin.y,frame.size.width,_indicatorHeight);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.frame = indicatorFrame;
    }];
}
#pragma mark --- 点击item 修改tabScrollView的偏移量
- (void)resetTabScrollViewContentOffset:(UILabel *)item
{
    CGFloat destinationX = 0;
    CGFloat itemCenterX = item.center.x;
    CGFloat scrollHalfWidth = _tabScrollView.bounds.size.width / 2;
    //item中心点超过最高滚动范围时
    if (_tabScrollView.contentSize.width - itemCenterX < scrollHalfWidth) {
        destinationX = _tabScrollView.contentSize.width - scrollHalfWidth * 2;
        [_tabScrollView setContentOffset:CGPointMake(destinationX, 0) animated:YES];
        return;
    }
    //item中心点低于最低滚动范围时
    if (itemCenterX > scrollHalfWidth) {
        destinationX = itemCenterX - scrollHalfWidth;
        [_tabScrollView setContentOffset:CGPointMake(destinationX, 0) animated:YES];
        return;
    }
    [_tabScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark --- 点击item 修改mainScrollView的偏移量
- (void)resetMainScrollViewContentOffset:(int)index isBlock:(BOOL)isBlock
{
    [_mainScrollView setContentOffset:CGPointMake(index * _mainScrollView.bounds.size.width, 0) animated:NO];
    if (self.slideMenuViewBlock && isBlock) {
        _slideMenuViewBlock(index);
    }
}
#pragma mark --- 配置下标
- (void)setupIndicatorView
{
    CGRect frame = _items[_itemSelectedIndex].frame;
    frame.origin.y = self.bounds.size.height - _bottomPadding - _indicatorHeight;
    frame.size.height = _indicatorHeight;
    
    _indicatorView.frame = frame;
    _indicatorView.backgroundColor = _itemSelectedColor;
    _indicatorView.image = _indicatorImg;
    _indicatorView.layer.cornerRadius = frame.size.height * 0.5;
    _indicatorView.layer.masksToBounds = YES;
}
#pragma mark --- 当item过少时，更新item位置
- (void)updateLabelsFrame
{
    CGFloat newMargin = _itemMargin + (self.bounds.size.width - _tabScrollView.contentSize.width) / (_items.count * 2);
    CGFloat originX = newMargin;
    for (UILabel *item in _items) {
        CGRect frame = item.frame;
        frame.origin.x = originX;
        item.frame = frame;
        originX = CGRectGetMaxX(frame) + 2 * newMargin;
    }
    _tabScrollView.contentSize = CGSizeMake(originX - newMargin,self.bounds.size.height);
    
}
#pragma mark --- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    switch (_indicatorType) {
        case SlideMenuIndicatorTypeNormal:
        {
            [self dealNormalIndicatorType:offsetX];
        }
            break;
        case SlideMenuIndicatorTypeStrech:
        case SlideMenuIndicatorTypeStrechAndMove:
        {
            [self dealFollowTextIndicatorType:offsetX];
        }
            break;
            
        default:
            break;
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changeItemStatusBecauseDealNormalIndicatorType];
}
- (void)changeItemStatusBecauseDealNormalIndicatorType
{
    int to = (int)(_mainScrollView.contentOffset.x / _mainScrollView.bounds.size.width);
    UILabel *toItem = _items[to];
    UITapGestureRecognizer *g = toItem.gestureRecognizers.firstObject;
    [self itemDidClicked:g];
}
- (void)dealNormalIndicatorType:(CGFloat)offsetX
{
    if (offsetX <= 0) {
        //左边界
        _leftIndex = 0;
        _rightIndex = 0;
        
    } else if (offsetX >= _mainScrollView.contentSize.width) {
        //右边界
        _leftIndex = (int)(_items.count - 1);
        _rightIndex = _leftIndex;
    } else {
        //中间
        _leftIndex = (int)(offsetX / _mainScrollView.bounds.size.width);
        _rightIndex = _leftIndex + 1;
    }
    
    CGFloat ratio = offsetX / _mainScrollView.bounds.size.width - _leftIndex;
    if (ratio == 0) return;
    
    UILabel *leftItem = _items[_leftIndex];
    UILabel *rightItem = _items[_rightIndex];
    
    CGFloat totalSpace = rightItem.center.x - leftItem.center.x;
    _indicatorView.center = CGPointMake(leftItem.center.x + totalSpace * ratio,_indicatorView.center.y);
}
- (void)dealFollowTextIndicatorType:(CGFloat)offsetX
{
    if (offsetX <= 0) {
        //左边界
        _leftIndex = 0;
        _rightIndex = 0;
        
    } else if (offsetX >= _mainScrollView.contentSize.width) {
        //右边界
        _leftIndex = (int)(_items.count - 1);
        _rightIndex = _leftIndex;
    } else {
        //中间
        _leftIndex = (int)(offsetX / _mainScrollView.bounds.size.width);
        _rightIndex = _leftIndex + 1;
    }
    
    CGFloat ratio = offsetX / _mainScrollView.bounds.size.width - _leftIndex;
    if (ratio == 0) return;
    
    UILabel *leftItem = _items[_leftIndex];
    UILabel *rightItem = _items[_rightIndex];
    
    //-
    CGFloat distance = _indicatorType == SlideMenuIndicatorTypeStrech ? 0 : _indicatorAnimatePadding;
    CGRect frame = self.indicatorView.frame;
    CGFloat maxWidth = CGRectGetMaxX(rightItem.frame) - CGRectGetMaxX(leftItem.frame) - distance * 2;
    
    if (ratio <= 0.5) {
        frame.size.width = leftItem.frame.size.width + (maxWidth - leftItem.frame.size.width) * (ratio / 0.5);
        frame.origin.x = CGRectGetMinX(leftItem.frame) + distance * (ratio / 0.5);
    } else {
        frame.size.width = rightItem.frame.size.width + (maxWidth - rightItem.frame.size.width) * ((1 - ratio) / 0.5);
        frame.origin.x = CGRectGetMaxX(rightItem.frame) - frame.size.width - distance * ((1 - ratio) / 0.5);
    }
    
    self.indicatorView.frame = frame;
}

- (void)byEnergyslideSelectorScrollViewDidScroll:(UIScrollView *)scrollView {
    [self scrollViewDidScroll:scrollView];
}

- (void)byEnergyslideSelectorScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}


@end
