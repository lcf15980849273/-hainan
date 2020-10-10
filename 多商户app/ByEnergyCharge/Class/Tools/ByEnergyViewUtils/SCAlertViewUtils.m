
//
//  SCAlertViewUtils.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "SCAlertViewUtils.h"
#import "FSActionSheet.h"

@interface SCAlertViewUtils ()<UIAlertViewDelegate, UIActionSheetDelegate>
@property (nonatomic, assign) SCAlertType alertType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *destructiveButtonTitle;
@property (nonatomic, strong) NSArray *otherButtonTitles;
@property (nonatomic, copy) SCAlertCompletionHandler completionHandler;
@property (nonatomic, weak) id alertObject;    //alert对象

@end


@implementation SCAlertViewUtils

static NSMutableArray * alertArray = nil;
SINGLETON_FOR_CLASS(SCAlertViewUtils);
+ (instancetype)showAlertWithType:(SCAlertType)alertType
                            title:(NSString *)title
                          message:(NSString *)message
                cancelButtonTitle:(NSString *)cancelButtonTitle
           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                otherButtonTitles:(NSArray *)otherButtonTitles
                completionHandler:(SCAlertCompletionHandler)completionHandler {
    if (alertArray.count > 0) {
        return nil;
    }
    SCAlertViewUtils *alert = [SCAlertViewUtils sharedSCAlertViewUtils];
    alert.alertType = alertType;
    alert.title = title;
    alert.message = message;
    alert.cancelButtonTitle = cancelButtonTitle;
    alert.destructiveButtonTitle = destructiveButtonTitle;
    alert.otherButtonTitles = otherButtonTitles;
    alert.completionHandler = completionHandler;
    [alert show];
    if (alertArray==nil) {
        alertArray = [NSMutableArray array];
    }
    [alertArray addObject:alert];
    
    return alert;
}


+ (instancetype)showActionSheetWithType:(SCAlertType)alertType
                                  title:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles
                      completionHandler:(SCAlertCompletionHandler)completionHandler{
    SCAlertViewUtils *alert = [SCAlertViewUtils sharedSCAlertViewUtils];
    FSActionSheet *actionSheet = [[FSActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle highlightedButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles];
    // 展示并绑定选择回调
    
    [actionSheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
        
        completionHandler(0,selectedIndex);
    }];
    
    return alert;
}

+ (instancetype)showSystemActionSheetWithTitle:(NSString *)title
                             cancelButtonTitle:(NSString *)cancelButtonTitle
                        destructiveButtonTitle:(NSString *)destructiveButtonTitle
                             otherButtonTitles:(NSArray *)otherButtonTitles
                             completionHandler:(SCAlertCompletionHandler)completionHandler{
    SCAlertViewUtils *alert = [SCAlertViewUtils sharedSCAlertViewUtils];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:alert
                                                    cancelButtonTitle:cancelButtonTitle
                                               destructiveButtonTitle:destructiveButtonTitle
                                                    otherButtonTitles:nil];
    for (NSString *buttonTitle in otherButtonTitles) {
        [actionSheet addButtonWithTitle:buttonTitle];
    }
    alert.completionHandler = completionHandler;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    alert.alertObject = actionSheet;
    return alert;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    @try {
        if (self.completionHandler) {
            self.completionHandler(SCAlertButtonTypeOther, buttonIndex);
        }
    } @catch (NSException *exception) {
        
    }
}


- (void)show {
    __weak typeof(self) weakSelf = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.title
                                                                                 message:self.message preferredStyle:(self.alertType==SCAlertTypeAlert)?UIAlertControllerStyleAlert:UIAlertControllerStyleActionSheet];
        if (self.cancelButtonTitle.length>0) {
            [alertController addAction:[UIAlertAction actionWithTitle:self.cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf didClickButtonWithType:SCAlertButtonTypeCancel atIndex:0];
            }]];
        }
        
        for (NSString *buttonTitle in self.otherButtonTitles) {
            [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf didClickButtonWithType:SCAlertButtonTypeOther atIndex:[self.otherButtonTitles indexOfObject:buttonTitle]];
            }]];
        }
        
        if (self.destructiveButtonTitle.length>0) {
            [alertController addAction:[UIAlertAction actionWithTitle:self.destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf didClickButtonWithType:SCAlertButtonTypeDestructive atIndex:0];
            }]];
        }
        
        int count = 0;
        UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        while(count<10 && presentingViewController.presentedViewController != nil) {
            count++;
            presentingViewController = presentingViewController.presentedViewController;
        }
        if (byEnergyIsNilOrNull(presentingViewController)==NO) {
            [presentingViewController presentViewController:alertController animated:YES completion:^{}];
        }
        
        self.alertObject = alertController;
    }
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    else {
        if (self.alertType==SCAlertTypeAlert) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.title
                                                            message:self.message
                                                           delegate:self
                                                  cancelButtonTitle:self.cancelButtonTitle
                                                  otherButtonTitles:self.destructiveButtonTitle, nil];
            for (NSString *buttonTitle in self.otherButtonTitles) {
                [alert addButtonWithTitle:buttonTitle];
            }
            [alert show];
            self.alertObject = alert;
        }
        else {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:self.title
                                                                     delegate:self
                                                            cancelButtonTitle:self.cancelButtonTitle
                                                       destructiveButtonTitle:self.destructiveButtonTitle
                                                            otherButtonTitles:nil];
            for (NSString *buttonTitle in self.otherButtonTitles) {
                [actionSheet addButtonWithTitle:buttonTitle];
            }
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
            self.alertObject = actionSheet;
        }
    }
#endif
}

- (void)didClickButtonWithType:(SCAlertButtonType)buttonType atIndex:(NSUInteger)buttonIndex {
    @try {
        if (self.completionHandler) {
            self.completionHandler(buttonType, buttonIndex);
            self.completionHandler = nil;
        }
        [alertArray removeObject:self];
    } @catch (NSException *exception) {
        
    }
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        if ([self.alertObject isKindOfClass:[UIAlertController class]]) {
            [(UIAlertController *)self.alertObject dismissViewControllerAnimated:YES completion:nil];
        }
    }
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
    else {
        if (self.alertType==SCAlertTypeAlert) {
            if ([self.alertObject isKindOfClass:[UIAlertView class]]) {
                [(UIAlertView *)self.alertObject dismissWithClickedButtonIndex:buttonIndex animated:NO];
            }
        }
        else {
            if ([self.alertObject isKindOfClass:[UIActionSheet class]]) {
                [(UIActionSheet *)self.alertObject dismissWithClickedButtonIndex:buttonIndex animated:NO];
            }
        }
    }
#endif
}

#pragma mark - UIAlertViewDelegate
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    SCAlertButtonType btnType = SCAlertButtonTypeCancel;
    NSInteger btnIndex = 0;
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:self.destructiveButtonTitle]) {
        btnType = SCAlertButtonTypeDestructive;
    }
    else if ([btnTitle isEqualToString:self.cancelButtonTitle]) {
        btnType = SCAlertButtonTypeCancel;
    }
    else {
        btnType = SCAlertButtonTypeOther;
        btnIndex = [self.otherButtonTitles indexOfObject:btnTitle];
    }
    [self didClickButtonWithType:btnType atIndex:btnIndex];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    SCAlertButtonType btnType = SCAlertButtonTypeCancel;
    NSInteger btnIndex = 0;
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:self.destructiveButtonTitle]) {
        btnType = SCAlertButtonTypeDestructive;
    }
    else if ([btnTitle isEqualToString:self.cancelButtonTitle]) {
        btnType = SCAlertButtonTypeCancel;
    }
    else {
        btnType = SCAlertButtonTypeOther;
        btnIndex = [self.otherButtonTitles indexOfObject:btnTitle];
    }
    [self didClickButtonWithType:btnType atIndex:btnIndex];
}
#endif

- (void)dealloc {
    NSLog(@"SCAlertViewController dealloc");
}


@end
