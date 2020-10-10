
//
//  AlertViewTools.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "AlertViewTools.h"


@interface AlertViewTools ()<UIAlertViewDelegate>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *cancelButtonTitle;
@property (nonatomic, copy) NSString *otherButtonTitles;
@property (nonatomic, copy) AlertToolsCompletionHandler completionHandler;
@end

@implementation AlertViewTools
static NSMutableArray * alertArray = nil;
SINGLETON_FOR_CLASS(AlertViewTools);

+ (void)showServiceNumber {
    
    NSLog(@"---%@",[[[BEnergyAppStorage sharedInstance] systemInfo]telephone]);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",byEnergyClearNilStr([[[BEnergyAppStorage sharedInstance] systemInfo]telephone])]]];//打电话
}

+ (void)showAlertMessage:(NSString *)message Cancel:(NSString *)cancel Submit:(NSString *)submit completionHandler:(SCAlertCompletionHandler)completionHandler{
    [SCAlertViewUtils showAlertWithType:SCAlertTypeAlert title:nil message:message cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:@[submit] completionHandler:^(SCAlertButtonType buttonType, NSUInteger buttonIndex) {
        if (completionHandler) {
            completionHandler(buttonType,buttonIndex);
        }
    }];
}

+ (instancetype)showSystemAlertViewTitle:(NSString *)title
                                  Message:(NSString *)message
                                   Cancel:(NSString *)cancel
                                   Submit:(NSString *)submit
                        completionHandler:(AlertToolsCompletionHandler)completionHandler {
    AlertViewTools *alert = [AlertViewTools sharedAlertViewTools];
    alert.message = message;
    alert.title = title;
    alert.cancelButtonTitle = cancel;
    alert.otherButtonTitles = submit;
    alert.completionHandler = completionHandler;
    [alert show];
    if (alertArray == nil) {
        alertArray = [NSMutableArray array];
    }
    [alertArray addObject:alert];
    return alert;
}

- (void)show {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.title
                                                    message:self.message
                                                   delegate:self
                                          cancelButtonTitle:self.cancelButtonTitle
                                          otherButtonTitles:self.otherButtonTitles, nil];
    [alert show];
}

#pragma mark -----UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.completionHandler) {
        self.completionHandler(buttonIndex);
    }
    [alertArray removeObject:self];
}


@end
