//
//  BEnergyFeedBackPoupView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyFeedBackPoupView.h"

@interface BEnergyFeedBackPoupView ()



@end
@implementation BEnergyFeedBackPoupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"BEnergyFeedBackPoupView" owner:self options:nil]lastObject];
        [self initDataAndViews];
    }
    return self;
}

- (void)initDataAndViews {
    self.contentTextView.placeholder = @"请简要描述您的问题和意见，以便我们 提供更好的帮助";
    self.alpha = 0.0;
}

- (IBAction)feedBackButtonClick:(UIButton *)sender {
    if (self.commitAddtionalFeedBackBlock) {
        self.commitAddtionalFeedBackBlock();
    }
}

- (IBAction)closeButtonClick:(UIButton *)sender {
     [self viewHiden];
}

- (void)viewShow {
    
    [UIView animateWithDuration:0.1
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1.0;
        [self.contentTextView.inputTextView becomeFirstResponder];
    } completion:^(BOOL finished) {
        
    }];
    
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}

- (void)viewHiden {
    
    [UIView animateWithDuration:0.3
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformMakeScale(1, 1);
        [self removeFromSuperview];
    }];
}
@end
