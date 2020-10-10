//
//  BEnergyBaseTableViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/12/31.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewController.h"

@interface BEnergyBaseTableViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BEnergyBaseTableViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _statusBarStyle;
}
//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    _statusBarStyle = StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //默认的是黑色
    if (self.statusBarStyle == UIStatusBarStyleLightContent) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.statusBarStyle == UIStatusBarStyleLightContent) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
}

- (void)sc_WillPopBack {
    
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc respondsToSelector:@selector(sc_WillPopBack)]) {
            [vc performSelector:@selector(sc_WillPopBack)];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    @try {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        self.view.backgroundColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        [[self parentVcInNav].navigationItem setHidesBackButton:YES];
        if ([self parentVcInNav] == self && NLSystemVersionGreaterOrEqualThan(7) && self.navigationController.viewControllers.count == 1) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
        //是否显示返回按钮
        self.isShowLiftBack = YES;
        [self initLeftnavigationBar];
    }
    @catch (NSException *exception) {
        NSLog(@"gdViewDidLoad exception:%@", [exception description]);
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}

- (void)initLeftnavigationBar {
    //    [self byEnergyNavItemWithImgeNames:@[@"btn_return"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
}

/**
 *  点击返回键的事件
 */
- (void)backBtnClicked {
    if (self.presentingViewController != nil && self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ————— 导航栏 添加图片按钮 —————
/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)byEnergyNavItemWithImgeNames:(NSArray *)imageNames
                                 isLeft:(BOOL)isLeft
                                 target:(id)target
                                 action:(SEL)action
                                   tags:(NSArray *)tags {
    
    [self byEnergyNavItemWithImgeNames:imageNames
                              Highlighted:imageNames
                                   isLeft:isLeft
                                   target:target
                                   action:action
                                     tags:tags];
}

/**
 导航栏添加图标按钮 可添加高亮状态图片
 
 @param imageNames 图标数组
 @param lightedImages 高亮图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)byEnergyNavItemWithImgeNames:(NSArray *)imageNames
                            Highlighted:(NSArray *)lightedImages
                                 isLeft:(BOOL)isLeft
                                 target:(id)target
                                 action:(SEL)action
                                   tags:(NSArray *)tags {
    
    NSMutableArray * items = [[NSMutableArray alloc] init];
    //调整按钮位置
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        NSString * HighlightedName;
        if (lightedImages.count == imageNames.count) {
            HighlightedName = [lightedImages objectAtIndex:i];
        }
        UIBarButtonItem * item = [self byEnergyNavItemWithImgeName:imageName
                                                       Highlighted:HighlightedName
                                                            isLeft:isLeft
                                                            target:target
                                                            action:action
                                                              tags:[tags[i++] integerValue]];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

#pragma mark ————— 导航栏 添加文字按钮 —————
- (void)byEnergyNavItemWitnTitles:(NSArray *)titles
                             isLeft:(BOOL)isLeft
                             target:(id)target
                             action:(SEL)action
                               tags:(NSArray *)tags {
    
    NSMutableArray * items = [[NSMutableArray alloc] init];
    NSInteger i = 0;
    for (NSString * title in titles) {
        UIBarButtonItem * item = [self byEnergyNavItemWithTitle:title isLeft:isLeft target:target action:action tags:[tags[i++] integerValue]];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

- (UIBarButtonItem *)byEnergyNavItemWithTitle:(NSString *)title
                                      isLeft:(BOOL)isLeft
                                      target:(id)target
                                      action:(SEL)action
                                        tags:(NSInteger)tag {
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = ByEnergyRegularFont(16);
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor colorByEnergyWithBinaryString:@"#353535"] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn sizeToFit];
    
    //设置偏移
    if (isLeft) {
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    }else{
        //            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    }
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (UIBarButtonItem *)byEnergyNavItemWithImgeName:(NSString *)imageName
                                     Highlighted:(NSString *)lightedImage
                                          isLeft:(BOOL)isLeft
                                          target:(id)target
                                          action:(SEL)action
                                            tags:(NSInteger)tag {
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (byEnergyIsValidStr(lightedImage)) {
        [btn setImage:[UIImage imageNamed:lightedImage] forState:UIControlStateHighlighted];
    }
    btn.tag = tag;
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (isLeft) {
        self.backBtn = btn;
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
    }else{
        self.rightBtn = btn;
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

#pragma mark ----- LazyLoad




- (void)popToPointViewController:(NSString *)class {
    //在需要侧滑到指定控制器的控制器的 view 加载完毕后偷偷将当前控制器与目标控制器之间的所有控制器出栈
    // 1. 获取当行控制器所有子控制器
    NSMutableArray <UIViewController *>* tmp = self.navigationController.viewControllers.mutableCopy;
    // 2. 获取目标控制器索引
    UIViewController * targetVC = nil;
    for (NSInteger i = 0 ; i < tmp.count; i++) {
        
        UIViewController * vc = tmp[i];
        if ([vc isKindOfClass:NSClassFromString(class)]){
            targetVC = vc;
            // 也可在此直接获取 i 的数值
            break;
        }
    }
    NSInteger index = [tmp indexOfObject:targetVC];
    // 3. 移除目标控制器与当前控制器之间的所有控制器
    NSRange  range = NSMakeRange(index + 1, tmp.count - 1 - (index + 1));
    [tmp removeObjectsInRange:range];
    // 4. 重新赋值给导航控制器
    self.navigationController.viewControllers = [tmp copy];
}

#pragma mark - setter and getter
- (UIViewController *)parentVcInNav {
    UIViewController *vc = self;
    if ([self.parentViewController.parentViewController isKindOfClass:[UINavigationController class]]) {
        vc = self.parentViewController;
    }
    return vc;
}

/**
 *  是否显示返回按钮
 */
- (void)setIsShowLiftBack:(BOOL)isShowLiftBack {
    _isShowLiftBack = isShowLiftBack;
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if (isShowLiftBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
        [self byEnergyNavItemWithImgeNames:@[@"btn_return"]
                                       isLeft:YES
                                       target:self
                                       action:@selector(backBtnClicked)
                                         tags:nil];
        
    } else {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    if (@available(iOS 13.0, *)) {
        
    } else {
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = color;
        }
    }
    
}




@end
