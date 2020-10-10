//
//  CoreGraphicsViewController.h
//  byCF
//
//  Created by newyea on 2020/4/7.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreGraphicsViewController : UIViewController

- (void)setupNaviWithTintColor:(UIColor *)color
               backgroundImage:(UIImage *)image
                statusBarstyle:(UIStatusBarStyle)style
                    attributes:(NSDictionary *)attributes;

- (void)selectedProvince:(NSString *)pro
                 AndCity:(NSString *)city
                 AndArea:(NSString *)area
             withAllName:(NSString *)rea;
@end


NS_ASSUME_NONNULL_END
