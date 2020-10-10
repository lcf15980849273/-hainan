//
//  UIViewController+ByEnergyStoryboard.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIViewController+ByEnergyStoryboard.h"

@implementation UIViewController (ByEnergyStoryboard)

+ (instancetype)loadFromClassNameIdentifierWithStoryboardName:(NSString *)name{
    return [self loadFromStoryboradName:name identifier:NSStringFromClass([self class])];
}

+ (instancetype)loadFromStoryboradName:(NSString *)name identifier:(NSString *)identifeir{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifeir];
}


+ (instancetype)byEnergyLoadStoryboardFromStoryboardName {
    return [self loadFromClassNameIdentifierWithStoryboardName:@"ByEnergy"];
}


@end
