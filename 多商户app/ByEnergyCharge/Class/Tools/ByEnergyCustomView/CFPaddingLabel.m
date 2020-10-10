//
//  CFPaddingLabel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/2.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "CFPaddingLabel.h"

@interface CFPaddingLabel ()
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@end

@implementation CFPaddingLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.edgeInsets = self.insets;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.edgeInsets = self.insets;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.edgeInsets = self.insets;
}

- (void)setInsets:(UIEdgeInsets)insets {

    _insets = insets;
    self.edgeInsets = _insets;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,self.edgeInsets)
                    limitedToNumberOfLines:numberOfLines];
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}
@end
