//
//  ByEnergyUpateVersionTool.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/7/17.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "ByEnergyUpateVersionTool.h"

static ByEnergyUpateVersionTool *sharedInstance = nil;
@implementation ByEnergyUpateVersionTool

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ByEnergyUpateVersionTool alloc]init];
    });
}

+ (instancetype)sharedInstance {
    return sharedInstance;
}

- (void)checkAppStoreVesionWithCompleteBlock:(CompleteBlock)completeBlock {
    
    ByEnergyWeakSekf
    [[[[self.viewModel.hnSystemInfoCommand executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            if ([[[BEnergyAppStorage sharedInstance] systemInfo] updateEnabled] >= 0) {
                [self.viewModel.hnCheckAppStoreVersion execute:nil];
            }
        }
    }];
    
    [self.viewModel.hnSystemInfoCommand execute:nil];
    
    [[[[self.viewModel.hnCheckAppStoreVersion executionSignals] switchToLatest] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ByEnergyStrongSelf
        if (self.viewModel.result) {
            NSDictionary *returnInfo = [NSJSONSerialization JSONObjectWithData:x options:0 error:nil];
            NSArray *returnArray = returnInfo[@"results"];
            if (returnArray.count <= 0) {
                return;
            }
            NSDictionary *releaseInfo = [returnArray firstObject];
            NSString *latestVersion = releaseInfo[@"version"];
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
            NSComparisonResult comparisonResult = [currentVersion compare:latestVersion options:NSNumericSearch];
            if (comparisonResult == NSOrderedAscending) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *appstoreUrl = [releaseInfo objectForKey:@"trackViewUrl"];
                    NSString *releaseNotes = [releaseInfo objectForKey:@"releaseNotes"];
                    int isEnabled = [[[BEnergyAppStorage sharedInstance] systemInfo] updateEnabled];
                    [SCAlertViewUtils showAlertWithType:SCAlertTypeAlert
                                                  title:@"更新提示！"
                                                message:([releaseNotes length] > 0 ? releaseNotes:@"有新版本发布了！")
                                      cancelButtonTitle:isEnabled == 2 ? nil : @"稍后再说"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@[@"立即升级"]
                                      completionHandler:^(SCAlertButtonType buttonType, NSUInteger buttonIndex) {
                        if (buttonType == SCAlertButtonTypeOther) {
                            if ([[[[[BEnergyAppStorage sharedInstance] systemInfo] auth] versionUpdate] value] == 2) {
                                completeBlock();
                            }
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl]];
                        }
                    }];
                });
            }
        }
    }];
    
    
}

#pragma mark ----- Lazyload
LCFLazyload(BEnergySystemInfoViewModel, viewModel)
LCFLazyload(BEnergyStubGroupViewModel, stubGroupViewModel)

@end
