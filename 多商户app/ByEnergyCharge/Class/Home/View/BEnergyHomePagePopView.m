//
//  BEnergyHomePagePopView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyHomePagePopView.h"

@interface BEnergyHomePagePopView ()
@end
@implementation BEnergyHomePagePopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"BEnergyHomePagePopView" owner:self options:nil]lastObject];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.advImageView.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.0;
    }
    return self;
}

- (IBAction)closeButtonClick:(UIButton *)sender {
    [self viewHiden];
}

- (void)viewShow {
     [UIView animateWithDuration:0.1
                             delay:0.3
                           options:UIViewAnimationOptionCurveEaseOut animations:^{
           self.alpha = 1.0;
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
