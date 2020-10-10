
//
//  HUDManager.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/23.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "HUDManager.h"

/* 默认网络提示*/
static NSString         *LoadingMessage = @"加载中...";

/* 默认成功提示*/
static NSString         *SuccessMessage = @"成功";
/* 默认成功显示图片*/
static NSString         *SuccessImgName = @"hud_success";

/* 默认失败提示*/
static NSString         *FailMessage = @"失败";
/* 默认失败显示图片*/
static NSString         *FailImgName = @"hud_error";

/* 默认警告提示*/
static NSString         *WarningMessage = @"提示";
/* 默认警告显示图片*/
static NSString         *WarningImgName = @"hud_info";

/*默认简短提示语显示的时间*/
static NSTimeInterval   ShowTime = 1.5f;

/*默认遮罩颜色*/
static CGFloat   White = 0.3f;

/*默认遮罩透明度*/
static CGFloat   Alpha = 0.5f;

/*文字大小*/
#define TEXT_SIZE    16.0f

@implementation HUDManager

#pragma mark - 属性设置
+ (void)setLoadingMessage:(NSString *)logingMessage{
    LoadingMessage = logingMessage;
}

+ (void)setSuccessMessage:(NSString *)successMessage{
    SuccessMessage = successMessage;
}

+ (void)setSuccessImgName:(NSString *)successImgName{
    SuccessImgName = successImgName;
}

+ (void)setFailMessage:(NSString *)failMessage{
    FailMessage = failMessage;
}

+ (void)setFailImgName:(NSString *)failImgName{
    FailImgName = failImgName;
}

+ (void)setWarningMessage:(NSString *)warningMessage{
    WarningMessage = warningMessage;
}

+ (void)setWarningImgName:(NSString *)warningImgName{
    WarningImgName = warningImgName;
}

+ (void)setShowTime:(NSTimeInterval)showTime{
    ShowTime = showTime;
}

+(void)setWhite:(CGFloat)white{
    White = white;
}

+(void)setAlpha:(CGFloat)alpha{
    Alpha = alpha;
}

#pragma mark - 加载显示
+(void)showLoading{
    [self showLoadingHud:nil];
}

+ (void)showLoadingHud:(NSString *)message{
    [self showLoadingHud:message onView:nil];
}

+ (void)showLoadingHud:(NSString *)message onView:(UIView *)view{
    [self showLoadingHud:message onView:view completionBlock:nil];
}

+ (void)showLoadingHud:(NSString *)message onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock{
    if (view == nil) view = ByEnergyAppWindow;
    //预想中一个视图上不应该出现两个以上的提示，因此调用一下隐藏方法
    [MBProgressHUD hideHUDForView:view animated:YES];
    //添加新的hud
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.bezelView.color = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.contentColor = [UIColor whiteColor];
    hud.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    hud.label.text = message ? message:LoadingMessage;
    // 隐藏的时候从父控件中移除
    
    hud.removeFromSuperViewOnHide = YES;
    
    hud.completionBlock = completionBlock;
}

+ (void)showStateHud:(NSString *)message state:(HUDStateType)state afterDelay:(NSTimeInterval)delay onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock{

}


#pragma mark - 显示状态
+ (void)showStateHud:(NSString *)message state:(HUDStateType)state{
    [self showStateHud:message state:state afterDelay:ShowTime];
}

+ (void)showStateHud:(NSString *)message state:(HUDStateType)state  onView:(UIView *)view{
    [self showStateHud:message state:state afterDelay:ShowTime onView:view];
}

+ (void)showStateHud:(NSString *)message state:(HUDStateType)state  afterDelay:(NSTimeInterval)delay onView:(UIView *)view{
    [self showStateHud:message state:state imgName:nil afterDelay:delay onView:view];
}

+ (void)showStateHud:(NSString *)message state:(HUDStateType)state afterDelay:(NSTimeInterval)delay{
    [self showStateHud:message state:state imgName:nil afterDelay:delay];
}

+ (void)showStateHud:(NSString *)message state:(HUDStateType)state imgName:(NSString *)imgName afterDelay:(NSTimeInterval)delay{
    [self showStateHud:message state:state imgName:imgName afterDelay:delay onView:nil];
}

+ (void)showStateHud:(NSString *)message state:(HUDStateType)state imgName:(NSString *)imgName afterDelay:(NSTimeInterval)delay onView:(UIView *)view{
    [self showStateHud:message state:state imgName:imgName afterDelay:delay onView:view completionBlock:nil];
}

+ (void)showStateHud:(NSString *)message state:(HUDStateType)state imgName:(NSString *)imgName afterDelay:(NSTimeInterval)delay onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock{
    NSString *title;
    NSString *imgString;
    switch (state) {
        case HUDStateTypeSuccess:
            title = message ? message:SuccessMessage;
            imgString = imgName?imgName:SuccessImgName;
            break;
        case HUDStateTypeFail:
            title = message ? message:FailMessage;
            imgString = imgName?imgName:FailImgName;
            break;
        case HUDStateTypeWarning:
            title = message ? message:WarningMessage;
            imgString = imgName?imgName:WarningImgName;
            break;
        default:
            break;
    }
    UIImageView *successImgView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:imgString]];
    [self showHud:title customImgView:successImgView Mode:MBProgressHUDModeCustomView isShowMaskView:NO afterDelay:delay onView:view completionBlock:completionBlock];
}

#pragma mark - 显示文字
+(void)showTextHud:(NSString *)message{
    [self showTextHud:message afterDelay:ShowTime];
}

+(void)showTextHud:(NSString *)message  onView:(UIView *)view{
    [self showTextHud:message afterDelay:ShowTime onView:view];
}

+(void)showTextHud:(NSString *)message afterDelay:(NSTimeInterval)delay{
    [self showTextHud:message afterDelay:delay onView:nil];
}

+(void)showTextHud:(NSString *)message afterDelay:(NSTimeInterval)delay onView:(UIView *)view{
    [self showTextHud:message afterDelay:delay onView:view completionBlock:nil];
}

+(void)showTextHud:(NSString *)message afterDelay:(NSTimeInterval)delay onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock{
    [self showHud:message customImgView:nil Mode:MBProgressHUDModeText isShowMaskView:NO afterDelay:delay onView:view completionBlock:completionBlock];
}

#pragma mark - 自定义视图显示

+ (void)showHudCustomView:(UIView *)customView{
    [self showHudCustomView:customView onView:nil];
}

+ (void)showHudCustomView:(UIView *)customView  onView:(UIView *)view{
    [self showHudCustomView:customView isShowMaskView:NO onView:view];
}

+ (void)showHudCustomView:(UIView *)customView isShowMaskView:(BOOL)isShowMaskView  onView:(UIView *)view{
    [self showHudCustomView:customView isShowMaskView:isShowMaskView afterDelay:ShowTime onView:view];
}

+ (void)showHudCustomView:(UIView *)customView isShowMaskView:(BOOL)isShowMaskView afterDelay:(NSTimeInterval)delay{
    [self showHudCustomView:customView isShowMaskView:isShowMaskView afterDelay:delay onView:nil];
}

+ (void)showHudCustomView:(UIView *)customView isShowMaskView:(BOOL)isShowMaskView afterDelay:(NSTimeInterval)delay onView:(UIView *)view{
    [self showHud:nil customView:customView isShowMaskView:isShowMaskView afterDelay:delay onView:view completionBlock:nil];
}

+ (void)showHud:(NSString *)message customView:(UIView *)customView isShowMaskView:(BOOL)isShowMaskView afterDelay:(NSTimeInterval)delay onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock{
    [self showHud:message customImgView:customView Mode:MBProgressHUDModeCustomView isShowMaskView:isShowMaskView afterDelay:delay onView:view completionBlock:completionBlock];
}

+ (void)showHud:(NSString *)message customImgView:(UIView *)customImgView Mode:(MBProgressHUDMode)mode isShowMaskView:(BOOL)isShowMaskView afterDelay:(NSTimeInterval)delay onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock{
    if (view == nil) view = ByEnergyAppWindow;
    //预想中一个视图上不应该出现两个以上的提示，因此调用一下隐藏方法
    [MBProgressHUD hideHUDForView:view animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = mode;
    if (mode == MBProgressHUDModeCustomView) {
        hud.customView  = customImgView;
    }
    //hud.mode = MBProgressHUDModeCustomView;
    
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    //如果只想显示一行，后面的用。。。显示，可以注释这一行
    hud.label.numberOfLines = 0;
    
    //detailsLabel和上面的lable差不多，如果想用detailsLabel可以上面设置lable的注释
    //    hud.detailsLabel.text = message;
    //    hud.detailsLabel.textColor = [UIColor whiteColor];
    //    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:17];
    
    
    //去掉黑色框背景，只显示图片
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.color = [UIColor clearColor];
//    hud.bezelView.alpha = 1;
//    hud.label.hidden = YES;

    hud.contentColor = [UIColor whiteColor];
    hud.completionBlock = completionBlock;
    if (isShowMaskView) {
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = [UIColor colorWithWhite:White alpha:Alpha];
    }
    // 隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // delay秒后隐藏
    if (delay) {
        [hud hideAnimated:YES afterDelay:delay];
    }else {
        [hud hideAnimated:YES afterDelay:10];
    }
}

//#pragma mark - 自定义视图和按钮


+ (void)showHud:(NSString *)message customImgView:(UIView *)customImgView btnTitle:(NSString *)btnTitle btnFont:(UIFont *)font btnTitleColor:(UIColor *)titleColor btnBackColor:(UIColor *)backColor Target:(nullable id)target action:(SEL)action isShowMaskView:(BOOL)isShowMaskView  isHide:(BOOL)isHide onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock{
    
    [self showHud:message customImgView:customImgView btnTitle:btnTitle btnFont:font btnTitleColor:titleColor btnBackColor:backColor Target:target action:action isShowMaskView:isShowMaskView afterDelay:ShowTime isHide:isHide onView:view completionBlock:completionBlock];
}

+ (void)showHud:(NSString *)message customImgView:(UIView *)customImgView btnTitle:(NSString *)btnTitle btnFont:(UIFont *)font btnTitleColor:(UIColor *)titleColor btnBackColor:(UIColor *)backColor Target:(nullable id)target action:(SEL)action isShowMaskView:(BOOL)isShowMaskView afterDelay:(NSTimeInterval)delay isHide:(BOOL)isHide onView:(UIView *)view completionBlock:(MBProgressHUDCompletionBlock)completionBlock{
    if (view == nil) view = ByEnergyAppWindow;
    //预想中一个视图上不应该出现两个以上的提示，因此调用一下隐藏方法
    [MBProgressHUD hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (customImgView) {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView  = customImgView;
    }
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    hud.contentColor = [UIColor whiteColor];
    hud.completionBlock = completionBlock;
    if (btnTitle) {
        [hud.button setTitle:btnTitle forState:UIControlStateNormal];
    }
    if (titleColor) {
        [hud.button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (backColor) {
        [hud.button setBackgroundColor:backColor];
    }
    if (target) {
        [hud.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (font) {
        hud.button.titleLabel.font = font;
    }
    if (isShowMaskView) {
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = [UIColor colorWithWhite:White alpha:Alpha];
    }
    // 隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // delay秒后隐藏
    if (isHide) {
        [hud hideAnimated:YES afterDelay:delay>0?delay:ShowTime];
    }
    
}

+ (void)hidenHudFromView:(UIView *)view{
    if (view == nil) view = ByEnergyAppWindow;
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)hidenHud{
    [self hidenHudFromView:nil];
}


@end
