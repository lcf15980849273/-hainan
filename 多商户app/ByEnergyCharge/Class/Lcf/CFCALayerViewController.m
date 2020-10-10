//
//  CFCALayerViewController.m
//  byCF
//
//  Created by 刘辰峰 on 2020/9/16.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import "CFCALayerViewController.h"
#import "RepayBottomView.h"
#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)

@interface CFCALayerViewController ()
@property(strong,nonatomic)CALayer *layer;
@property (nonatomic, strong) UIView *myView;

@property (nonatomic, strong) RepayBottomView *repayBottomView;
@end

@implementation CFCALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataAndViews];
    
    [self drawMyLayer];
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    [self.repayBottomView ViewShow];
    
}

- (void)initDataAndViews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myView];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //核心动画
//    CABasicAnimation *anim = [CABasicAnimation animation]; //基本动画
//    anim.keyPath = @"position";//通过属性去更改动画
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200,200)];
    //    anim.keyPath = @"transform";
    //    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
    
    //    anim.keyPath = @"transform.scale.x";
    //    anim.toValue = @(1.5);
    
    //    anim.keyPath = @"opacity";
    //    anim.toValue = @(0);
    
    //    anim.keyPath = @"backgroundColor";
    //    anim.toValue = (id) [UIColor greenColor].CGColor;
    
    //    anim.keyPath = @"transform.rotation.x"; //围绕x轴旋转
    //    anim.toValue = @(M_PI);
    
    //    anim.keyPath = @"content"; //围绕x轴旋转
    //    anim.toValue = (id) [UIImage imageNamed:@"to"].CGImage;
//    anim.duration = 1;
//    //    anim.repeatCount = 5;//动画重复次数
//    //动画执行完后不要删除动画
//    anim.removedOnCompletion = NO;
//    //保持最新的状态  （不回到原来的位置）
//    anim.fillMode = kCAFillModeForwards;
    
    
    
    
    //点赞动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation]; //帧动画
    anim.keyPath = @"transform.scale";
    anim.values = @[@(1.5),@(1)];
    anim.repeatCount = 1;
    anim.duration = 0.25;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.myView.layer addAnimation:anim forKey:nil];
    

    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    NSMutableArray *values = [[NSMutableArray alloc]initWithCapacity:3];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    animation.duration = 0.5;
//    animation.removedOnCompletion = YES;
//    [self.layer addAnimation:animation forKey:nil];
    
    
//    UITouch *touch = touches.anyObject;
//    CGPoint location = [touch locationInView:self.view];
//    [UIView animateWithDuration:5.0 delay:0
//         usingSpringWithDamping:0.1
//          initialSpringVelocity:1.0
//                        options:UIViewAnimationOptionCurveLinear animations:^{
//                            self.myView.center = location;
//                        } completion:nil];
}



- (void)drawMyLayer {
    CALayer *layer = [[CALayer alloc]init];//获得根图层
    
    [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
    
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;//设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用
    layer.position = CGPointMake(300, 300);//设置中心点
    layer.bounds = CGRectMake(0, 0, 50,50);//设置大小
    layer.cornerRadius = 50/2;//设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形layer.cornerRadius=WIDTH/2;//设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowRadius = 10.0f;
    layer.shadowOpacity = .9;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 0.9;//设置边框
    layer.anchorPoint = CGPointMake(1, 1);//设置锚点(与position点重合，决定着calayer哪个点在position所指的位置)
    layer.borderColor = [UIColor redColor].CGColor;
    self.layer = layer;
    [self.view.layer addSublayer:self.layer];
    //position是以父图层来定位坐标的，相当于frame。anchorPoint是以layer本身为坐标原点
}

- (void)imagejitter { //图片抖动
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation]; //帧动画
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(Angle2Radian(-5)),@(Angle2Radian(5)),@(Angle2Radian(-5)),];
    anim.repeatCount = MAXFLOAT;
    anim.duration = 0.25;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.myView.layer addAnimation:anim forKey:@"shake"];
}

- (void)transitionAnimation { //转场动画，想push那种效果
    
    CATransition *anim = [CATransition animation];
    anim.type = @"cube";
    anim.subtype = kCATransitionFromLeft;
    anim.duration = 0.5;
    [self.myView.layer addAnimation:anim forKey:nil];
}

//属性
//    static NSString *kCARotation = @"transform.rotation";
//    static NSString *kCARotationX = @"transform.rotation.x";
//    static NSString *kCARotationY = @"transform.rotation.y";
//    static NSString *kCARotationZ = @"transform.rotation.z";
//
//    /* 缩放x,y,z分别是对x,y,z方向进行缩放 */
//    static NSString *kCAScale = @"transform.scale";
//    static NSString *kCAScaleX = @"transform.scale.x";
//    static NSString *kCAScaleY = @"transform.scale.y";
//    static NSString *kCAScaleZ = @"transform.scale.z";
//
//    /* 平移x,y,z同上 */
//    static NSString *kCATranslation = @"transform.translation";
//    static NSString *kCATranslationX = @"transform.translation.x";
//    static NSString *kCATranslationY = @"transform.translation.y";
//    static NSString *kCATranslationZ = @"transform.translation.z";
//
//    /* 平面 */
//    /* CGPoint中心点改变位置，针对平面 */
//    static NSString *kCAPosition = @"position";
//    static NSString *kCAPositionX = @"position.x";
//    static NSString *kCAPositionY = @"position.y";
//
//    /* CGRect */
//    static NSString *kCABoundsSize = @"bounds.size";
//    static NSString *kCABoundsSizeW = @"bounds.size.width";
//    static NSString *kCABoundsSizeH = @"bounds.size.height";
//    static NSString *kCABoundsOriginX = @"bounds.origin.x";
//    static NSString *kCABoundsOriginY = @"bounds.origin.y";
//
//    /* 透明度 */
//    static NSString *kCAOpacity = @"opacity";
//    /* 背景色 */
//    static NSString *kCABackgroundColor = @"backgroundColor";
//    /* 圆角 */
//    static NSString *kCACornerRadius = @"cornerRadius";
//    /* 边框 */
//    static NSString *kCABorderWidth = @"borderWidth";
//    /* 阴影颜色 */
//    static NSString *kCAShadowColor = @"shadowColor";
//    /* 偏移量CGSize */
//    static NSString *kCAShadowOffset = @"shadowOffset";
//    /* 阴影透明度 */
//    static NSString *kCAShadowOpacity = @"shadowOpacity";
//    /* 阴影圆角 */
//    static NSString *kCAShadowRadius = @"shadowRadius";


- (RepayBottomView *)repayBottomView {
    if (!_repayBottomView) {
        _repayBottomView = [[RepayBottomView alloc]initWithFrame:CGRectZero];
    }
    return _repayBottomView;
}
@end
