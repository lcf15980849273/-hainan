//
//  GuideFigure.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/31.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "GuideFigure.h"
#import "GuideFigureShowViewController.h"

@interface GuideFigure ()
@property (nonatomic,strong) GuideFigureShowViewController *showVC;
@end
@implementation GuideFigure

+ (instancetype)sharedFigure
{
    static GuideFigure *figure;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        figure = [[GuideFigure alloc] init];
        //创建对应的控制器
        figure.showVC = [[GuideFigureShowViewController alloc] init];
        figure.showVC.originY = SCREENHEIGHT - 50;
    });
    return figure;
}

+ (void)figureWithImages:(NSArray *)images finashMainViewController:(UIViewController *)finashMainViewController
{
    GuideFigure *figure = [GuideFigure sharedFigure];
    //当前运行的版本
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    //本地保存的版本号
    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [userDe objectForKey:GuideAppVersionKey];
    
    
    if ([currentVersion isEqualToString:localVersion]) {
        //已经运行过该版本
        
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:finashMainViewController];
        return;
    } else {
        
        figure.showVC.images = images;
        figure.showVC.clickLastPage = ^(){
            //更新本地存储的版本
            [userDe setObject:currentVersion forKey:GuideAppVersionKey];
            [userDe synchronize];
            
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:finashMainViewController];
        };
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:figure.showVC];
    }
}

#pragma mark - 修改默认pageControl属性
-(void)setOtherPageColor:(UIColor *)otherPageColor
{
    [GuideFigure sharedFigure].showVC.otherPageColor = otherPageColor;
}
-(void)setCurrentPageColor:(UIColor *)currentPageColor
{
    [GuideFigure sharedFigure].showVC.currentPageColor = currentPageColor;
}
-(void)setOriginY:(float)originY
{
    [GuideFigure sharedFigure].showVC.originY = originY;
}

@end
