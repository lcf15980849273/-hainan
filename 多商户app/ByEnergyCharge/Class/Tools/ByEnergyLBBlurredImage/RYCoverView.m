//
//  RYCoverView.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/3.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "RYCoverView.h"

@implementation RYCoverView

static RYCoverView   *_cover;
static UIView    *_fromView;
static UIView    *_contentView;
static BOOL      _animated;
static showBlock _showBlock;
static hideBlock _hideBlock;
static BOOL      _notclick;
static RYCoverViewType _showType;
static CGFloat   _topHeight;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _animated = NO;
    }
    return self;
}

+ (instancetype)cover
{
    return [[self alloc] init];
}

#pragma makr - 自定义遮罩 - (可实现固定遮罩的效果)
/**
 *  半透明遮罩构造方法
 */
+ (instancetype)translucentCoverWithTarget:(id)target action:(SEL)action
{
    RYCoverView *cover = [self cover];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.5;
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    
    return cover;
}

/**
 *  全透明遮罩构造方法
 */
+ (instancetype)transparentCoverWithTarget:(id)target action:(SEL)action
{
    RYCoverView *cover = [self cover];
    cover.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgView = [UIImageView new];
    bgView.size = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
    bgView.image = [UIImage imageNamed:@"transparent_bg"];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
    [cover addSubview:bgView];
    
    return cover;
}

#pragma mark - 固定遮罩-屏幕底部弹窗

/**
 *  半透明遮罩，默认黑色，0.5
 */
+ (void)translucentBottomCoverFrom:(UIView *)fromView content:(UIView *)contentView animated:(BOOL)animated showBlock:(showBlock)show hideBlock:(hideBlock)hide {
    [self translucentCoverFrom:fromView content:contentView animated:animated type:RYCoverViewTypeForBottom notClick:NO showBlock:show hideBlock:hide];
}

/**
 *  改变透明度(仅用于半透明遮罩)
 */
+ (void)changeAlpha:(CGFloat)alpha {
    _cover.alpha = alpha;
}

/**
 *  全透明遮罩
 */
+ (void)transparentBottomCoverFrom:(UIView *)fromView content:(UIView *)contentView animated:(BOOL)animated showBlock:(showBlock)show hideBlock:(hideBlock)hide {
    
    [self transparentCoverFrom:fromView content:contentView animated:animated type:RYCoverViewTypeForBottom notClick:NO showBlock:show hideBlock:hide];
}

#pragma mark - 固定遮罩(在window上)-屏幕中间弹窗

/**
 半透明遮罩，默认黑色，0.5
 
 */
+ (void)translucentWindowCenterCoverContent:(UIView *)contentView animated:(BOOL)animated showBlock:(showBlock)show hideBlock:(hideBlock)hide {
    
    UIWindow *window = [self getKeyWindow];
    [self translucentCoverFrom:window content:contentView animated:animated type:RYCoverViewTypeForCenter notClick:NO showBlock:nil hideBlock:nil];
}
/**
 全透明遮罩
 
 */
+ (void)transparentWindowCenterCoverContent:(UIView *)contentView animated:(BOOL)animated showBlock:(showBlock)show hideBlock:(hideBlock)hide {
    UIWindow *window = [self getKeyWindow];
    [self transparentCoverFrom:window content:contentView animated:animated type:RYCoverViewTypeForCenter notClick:NO showBlock:nil hideBlock:nil];
}

#pragma mark - 固定遮罩(在window上)-下落弹窗

/**
 半透明遮罩，默认黑色，0.5
 
 */
+ (void)translucentWindowTopCoverContent:(UIView *)contentView animated:(BOOL)animated showBlock:(showBlock)show hideBlock:(hideBlock)hide {
    UIWindow *window = [self getKeyWindow];
    [self translucentCoverFrom:window content:contentView animated:animated type:RYCoverViewTypeForTop notClick:NO showBlock:nil hideBlock:nil];
}
/**
 全透明遮罩
 
 */
+ (void)transparentWindowTopCoverContent:(UIView *)contentView animated:(BOOL)animated showBlock:(showBlock)show hideBlock:(hideBlock)hide {
    UIWindow *window = [self getKeyWindow];
    [self transparentCoverFrom:window content:contentView animated:animated type:RYCoverViewTypeForTop notClick:NO showBlock:nil hideBlock:nil];
}

/**
 指定下落高度
 */
+ (void)topHeight:(CGFloat)topHeight {
    _topHeight = topHeight;
}

#pragma mark - 新增方法，通过类型指定弹窗形式
/**
 半透明遮罩，默认黑色，0.5
 */
+ (void)translucentCoverFrom:(UIView *)fromView content:(UIView *)contentView type:(RYCoverViewType)type animated:(BOOL)animated showBlock:(showBlock)show hideBlock:(hideBlock)hide {
    [self translucentCoverFrom:fromView content:contentView animated:animated type:type notClick:NO showBlock:show hideBlock:hide];
}
/**
 全透明遮罩
 */
+ (void)transparentCoverFrom:(UIView *)fromView content:(UIView *)contentView type:(RYCoverViewType)type animated:(BOOL)animated showBlock:(showBlock)show hideBlock:(hideBlock)hide {
    [self transparentCoverFrom:fromView content:contentView animated:animated type:type notClick:NO showBlock:show hideBlock:hide];
}

#pragma makr - 新增功能：增加点击遮罩时是否消失的判断,notClick是否可以点击，默认是NO,代表能点击

+ (void)translucentCoverFrom:(UIView *)fromView content:(UIView *)contentView type:(RYCoverViewType)type animated:(BOOL)animated notClick:(BOOL)click {
    [self translucentCoverFrom:fromView content:contentView animated:animated type:RYCoverViewTypeForCenter notClick:click showBlock:nil hideBlock:nil];
}

+ (void)transparentCoverFrom:(UIView *)fromView content:(UIView *)contentView type:(RYCoverViewType)type animated:(BOOL)animated notClick:(BOOL)click {
    [self transparentCoverFrom:fromView content:contentView animated:animated type:RYCoverViewTypeForCenter notClick:click showBlock:nil hideBlock:nil];
}

+ (void)translucentWindowCenterCoverContent:(UIView *)contentView animated:(BOOL)animated notClick:(BOOL)click {
    UIWindow *window = [self getKeyWindow];
    [self translucentCoverFrom:window content:contentView animated:animated type:RYCoverViewTypeForCenter notClick:click showBlock:nil hideBlock:nil];
}

+ (void)transparentWindowCenterCoverContent:(UIView *)contentView animated:(BOOL)animated notClick:(BOOL)click {
    UIWindow *window = [self getKeyWindow];
    [self transparentCoverFrom:window content:contentView animated:animated type:RYCoverViewTypeForCenter notClick:click showBlock:nil hideBlock:nil];
}

#pragma mark - 私有方法
/**
 *  显示一个半透明遮罩
 *
 *  @param fromView          显示在此view上
 *  @param contentView       遮罩上面显示的内容view
 *  @param animated          是否有动画 ：默认是NO
 *  @param notClick          是否不能点击：默认是NO，即能点击
 *  @param show              显示时的block
 *  @param transparentBgView 隐藏时的block
 */
+ (void)translucentCoverFrom:(UIView *)fromView content:(UIView *)contentView animated:(BOOL)animated type:(RYCoverViewType)type notClick:(BOOL)notClick showBlock:(showBlock)showBlock hideBlock:(hideBlock)hideBlock
{
    // 创建遮罩
    RYCoverView *cover = [self cover];
    // 设置大小和颜色
    cover.frame = fromView.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.5;
    // 添加遮罩
    [fromView addSubview:cover];
    _cover = cover;
    
    // 如果遮罩能点
    if (!notClick) {
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    }
    
    // 赋值
    _fromView  = fromView;
    _contentView = contentView;
    _animated  = animated;
    _notclick  = notClick;
    _showBlock = showBlock;
    _hideBlock = hideBlock;
    _showType = type;
    // 显示内容view
    [self showContentView];
}

/**
 *  全透明遮罩
 *
 *  @param fromView    显示在此view上
 *  @param contentView 遮罩上面显示的内容view
 *  @param animated    是否有显示动画
 *  @param notClick    是否不能点击，默认是NO，即能点击
 *  @param showBlock   显示时的block
 *  @param hideBlock   隐藏时的block
 */
+ (void)transparentCoverFrom:(UIView *)fromView content:(UIView *)contentView animated:(BOOL)animated type:(RYCoverViewType)type notClick:(BOOL)notClick showBlock:(showBlock)showBlock hideBlock:(hideBlock)hideBlock
{
    // 创建遮罩
    RYCoverView *cover = [self cover];
    cover.frame = fromView.bounds;
    cover.backgroundColor = [UIColor clearColor];
    [fromView addSubview:cover];
    _cover = cover;
    
    // 赋值
    _fromView  = fromView;
    _contentView = contentView;
    _animated  = animated;
    _notclick  = notClick;
    _showBlock = showBlock;
    _hideBlock = hideBlock;
    _showType = type;
    // 添加透明背景
    [cover addSubview:[self transparentBgView]];
    // 显示内容view
    [self showContentView];
}

/**
 *  透明图片
 */
+ (UIImageView *)transparentBgView
{
    UIImageView *bgView = [UIImageView new];
    bgView.size = _cover.size;
    bgView.image = [UIImage imageNamed:@"transparent_bg"];
    bgView.userInteractionEnabled = YES;
    if (!_notclick) {
        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    }
    return bgView;
}

+ (UIImageView *)blurBgView
{
    UIImageView *bgView = [UIImageView new];
    bgView.size = _cover.size;
    [bgView setImageToBlur:[UIImage imageNamed:@"transparent_bg"] completionBlock:nil];
    if (!_notclick) {
        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    }
    return bgView;
}

+ (UIWindow *)getKeyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}


+ (void)showContentView
{
    if ([_fromView isKindOfClass:[UIWindow class]]) {
        _contentView.center = _fromView.center;
        [_fromView addSubview:_contentView];
        if (_animated) {
            switch (_showType) {
                case RYCoverViewTypeForTop:
                    [self animationTopAlert:_contentView];
                    break;
                case RYCoverViewTypeForCenter:
                    [self animationAlert:_contentView];
                    break;
                case RYCoverViewTypeForBottom:
                    [self show];
                    break;
                default:
                    break;
            }
        }
    }else{
        [_fromView addSubview:_contentView];
        if (_animated) {
            switch (_showType) {
                case RYCoverViewTypeForTop:
                    [self animationTopAlert:_contentView];
                    break;
                case RYCoverViewTypeForCenter:
                    [self animationAlert:_contentView];
                    break;
                case RYCoverViewTypeForBottom:
                    [self show];
                    break;
                default:
                    break;
            }
        }else {
           [self show];
        }
    }
}

/**
 *  中间弹窗动画
 */
+ (void)animationAlert:(UIView*)view{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.delegate = _cover;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    
    [view.layer addAnimation:animation forKey:nil];
}

/**
 *  下落弹窗动画
 */
+ (void)animationTopAlert:(UIView*)view{
    
    _contentView.bottom = _fromView.top;
    [UIView animateWithDuration:0.3 animations:^{
        if (_topHeight) {
            _contentView.top = _topHeight;
        }else {
            _contentView.center = _fromView.center;
        }
        
    } completion:^(BOOL finished) {
        [_cover animationDidStop:nil finished:YES];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    !_showBlock ? : _showBlock();
}

/**
 *  显示
 */
+ (void)show

{
    if (_animated) {
        _contentView.top = SCREENHEIGHT;
        [UIView animateWithDuration:0.25 animations:^{
            _contentView.top = SCREENHEIGHT - _contentView.height;
        }completion:^(BOOL finished) {
            !_showBlock ? : _showBlock();
        }];
    }else{
        !_showBlock ? : _showBlock();
        _contentView.top = SCREENHEIGHT - _contentView.height;
    }
}
/**
 *  隐藏
 */
+ (void)hide{
    if (_animated && ![_fromView isKindOfClass:[UIWindow class]]) {
        
        [UIView animateWithDuration:0.25 animations:^{
            _contentView.top = SCREENHEIGHT;
        }completion:^(BOOL finished) {
            [_cover removeFromSuperview];
            [_contentView removeFromSuperview];
            !_hideBlock ? : _hideBlock();
        }];
    }else{
        [_cover removeFromSuperview];
        [_contentView removeFromSuperview];
        !_hideBlock ? : _hideBlock();
    }
}

@end
