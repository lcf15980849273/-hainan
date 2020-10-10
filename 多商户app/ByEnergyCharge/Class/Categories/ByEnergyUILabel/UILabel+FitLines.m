

//
//  UILabel+FitLines.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "UILabel+FitLines.h"
#import <objc/runtime.h>

static const void *kfirstLineHeadIndent = @"firstLineHeadIndent";


@implementation UILabel (FitLines)

- (CGFloat)firstLineHeadIndent {
    return [objc_getAssociatedObject(self, kfirstLineHeadIndent) floatValue];
}

- (void)setFirstLineHeadIndent:(CGFloat)indent {

    objc_setAssociatedObject(self, kfirstLineHeadIndent, [NSNumber numberWithFloat:indent], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = indent;
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:byEnergyClearNilStr(self.text) attributes:@{ NSParagraphStyleAttributeName : style}];
    self.attributedText = attrText;
}





@end
