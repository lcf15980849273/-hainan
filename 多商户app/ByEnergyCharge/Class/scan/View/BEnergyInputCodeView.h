//
//  BEnergyInputCodeView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/8.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyInputCodeView : UIView
@property (nonatomic, copy) void(^comitButtonBlock)(void);
@property (weak, nonatomic) IBOutlet UITextField *codeTextFiled;
- (void)viewHiden;
@end

NS_ASSUME_NONNULL_END
