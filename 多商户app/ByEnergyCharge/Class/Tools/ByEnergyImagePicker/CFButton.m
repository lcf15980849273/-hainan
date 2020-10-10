//
//  CFButton.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/10/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "CFButton.h"

@implementation CFButton
#pragma mark - Overrides

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self byEnergyInitSubView];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    [self byEnergyInitSubView];
    
    return self;
}

- (void)byEnergyInitSubView {
    [self initBDButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.alignment != BDButtonAlignmentNone) {
        CGFloat totalWidth = self.imageView.width + self.titleLabel.width + self.titleImageSpacing;
        CGFloat totalHeight = self.imageView.height + self.titleLabel.height + self.titleImageSpacing;
        CGFloat centerX = self.width/2.0f;
        CGFloat centerY = self.height/2.0f;
        
        CGFloat titleLabelVerticalWidth = self.width - (self.contentEdgeInsets.left + self.contentEdgeInsets.right);
        
        CGFloat titleLabelHorizontalWidthDiff = (totalWidth + self.contentEdgeInsets.left + self.contentEdgeInsets.right) - self.width;
        titleLabelHorizontalWidthDiff = MAX(titleLabelHorizontalWidthDiff, 0.0f);
        totalWidth -= titleLabelHorizontalWidthDiff;
        
        switch (self.alignment) {
            case BDButtonAlignmentVerticalImageTop: {
                if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop) {
                    self.imageView.centerX = centerX;
                    self.imageView.top = self.contentEdgeInsets.top;
                    
                    self.titleLabel.width = titleLabelVerticalWidth;
                    self.titleLabel.centerX = centerX;
                    self.titleLabel.top = self.imageView.bottom + self.titleImageSpacing;
                }
                else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom) {
                    self.titleLabel.width = titleLabelVerticalWidth;
                    self.titleLabel.centerX = centerX;
                    self.titleLabel.bottom = self.height - self.contentEdgeInsets.bottom;
                    
                    self.imageView.centerX = centerX;
                    self.imageView.bottom = self.titleLabel.top - self.titleImageSpacing;
                }
                else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter) {
                    self.imageView.centerX = centerX;
                    self.imageView.top = centerY - totalHeight / 2.0f;
                    
                    self.titleLabel.width = titleLabelVerticalWidth;
                    self.titleLabel.centerX = centerX;
                    self.titleLabel.top = self.imageView.bottom + self.titleImageSpacing;
                }
                break;
            }
            case BDButtonAlignmentVerticalImageBottom: {
                if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop) {
                    self.titleLabel.width = titleLabelVerticalWidth;
                    self.titleLabel.centerX = centerX;
                    self.titleLabel.top = self.contentEdgeInsets.top;
                    
                    self.imageView.centerX = centerX;
                    self.imageView.bottom = self.titleLabel.bottom + self.titleImageSpacing;
                }
                else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom) {
                    self.imageView.centerX = centerX;
                    self.imageView.bottom = self.height - self.contentEdgeInsets.bottom;
                    
                    self.titleLabel.width = titleLabelVerticalWidth;
                    self.titleLabel.centerX = centerX;
                    self.titleLabel.bottom = self.imageView.top - self.titleImageSpacing;
                }
                else {
                    self.imageView.centerX = centerX;
                    self.imageView.bottom = centerY + totalHeight / 2.0f;
                    
                    self.titleLabel.width = titleLabelVerticalWidth;
                    self.titleLabel.centerX = centerX;
                    self.titleLabel.top = self.imageView.top - self.titleImageSpacing;
                }
                break;
            }
            case BDButtonAlignmentHorizontalImageLeft: {
                if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                    self.imageView.left = self.contentEdgeInsets.left;
                    self.imageView.centerY = centerY;
                    
                    self.titleLabel.centerY = centerY;
                    self.titleLabel.width -= titleLabelHorizontalWidthDiff;
                    self.titleLabel.left = self.imageView.right + self.titleImageSpacing;
                }
                else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
                    self.titleLabel.width -= titleLabelHorizontalWidthDiff;
                    self.titleLabel.right = self.width - self.contentEdgeInsets.right;
                    self.titleLabel.centerY = centerY;
                    
                    self.imageView.right = self.titleLabel.left - self.titleImageSpacing;
                    self.imageView.centerY = centerY;
                }
                else {
                    self.imageView.left = centerX - totalWidth / 2.0f;
                    self.imageView.centerY = centerY;
                    
                    self.titleLabel.centerY = centerY;
                    self.titleLabel.width -= titleLabelHorizontalWidthDiff;
                    self.titleLabel.left = self.imageView.right + self.titleImageSpacing;
                    
                    if (self.imageView.left < 0.0f) {
                        self.imageView.left = 0.0f;
                        self.titleLabel.left = self.imageView.right + self.titleImageSpacing;
                    }
                }
                break;
            }
            case BDButtonAlignmentHorizontalImageRight: {
                if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                    self.titleLabel.width -= titleLabelHorizontalWidthDiff;
                    self.titleLabel.left = self.contentEdgeInsets.left;
                    self.titleLabel.centerY = centerY;
                    
                    self.imageView.left = self.titleLabel.right + self.titleImageSpacing;
                    self.imageView.centerY = centerY;
                }
                else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
                    self.imageView.right = self.width - self.contentEdgeInsets.right;
                    self.imageView.centerY = centerY;
                    
                    self.titleLabel.width -= titleLabelHorizontalWidthDiff;
                    self.titleLabel.right = self.imageView.left - self.titleImageSpacing;
                    self.titleLabel.centerY = centerY;
                }
                else {
                    self.imageView.right = centerX + totalWidth / 2.0f - 20;
                    self.imageView.centerY = centerY;
                    
                    self.titleLabel.centerY = centerY;
                    self.titleLabel.width -= titleLabelHorizontalWidthDiff;
                    self.titleLabel.right = self.imageView.left - self.titleImageSpacing - 20;
                    
                    if (self.titleLabel.left < 0.0f) {
                        self.titleLabel.left = 0.0f;
                        self.imageView.left = self.titleLabel.right + self.titleImageSpacing;
                    }
                }
                break;
            }
            default:
                break;
        }
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    size = [super sizeThatFits:size];
    
    if (self.alignment == BDButtonAlignmentNone) {
        return size;
    }
    
    if (self.alignment == BDButtonAlignmentVerticalImageTop ||
        self.alignment == BDButtonAlignmentVerticalImageBottom) {
        CGFloat totalHeight = 0.0f;
        totalHeight += [self.imageView sizeThatFits:size].height;
        totalHeight += [self.titleLabel sizeThatFits:size].height;
        totalHeight += self.titleImageSpacing;
        totalHeight += self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
        size.height = totalHeight;
    }
    else if (self.alignment == BDButtonAlignmentHorizontalImageLeft ||
             self.alignment == BDButtonAlignmentHorizontalImageRight) {
        CGFloat totalWidth = 0.0f;
        totalWidth += [self.imageView sizeThatFits:size].width;
        totalWidth += [self.titleLabel sizeThatFits:size].width;
        totalWidth += self.titleImageSpacing;
        totalWidth += self.contentEdgeInsets.left + self.contentEdgeInsets.right;
        size.width = totalWidth;
    }
    
    return size;
}

#pragma mark - Private Method

- (void)initBDButton {
    _titleImageSpacing = 5.0f;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addTarget:self
             action:@selector(buttonDidClick)
   forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (void)buttonDidClick {
    if (self.buttonDidClickOperation) {
        self.buttonDidClickOperation(self);
    }
}

#pragma mark - Setter Getter

- (void)setAlignment:(BDButtonAlignment)alignment {
    _alignment = alignment;
    [self setNeedsLayout];
}

- (void)setTitleImageSpacing:(CGFloat)titleImageSpacing {
    _titleImageSpacing = titleImageSpacing;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title {
    if (title.length > 0) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    else {
        [self setTitle:@"" forState:UIControlStateNormal];
    }
    [self setNeedsLayout];
}

- (void)setImageName:(NSString *)imageName {
    if (imageName.length > 0) {
        if ([imageName rangeOfString:@"http"].length > 0) {
//            [self sd_setImageWithURL:[imageName zm_url] forState:UIControlStateNormal];
        }
        else {
            [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        }
    }
    else {
        [self setImage:nil forState:UIControlStateNormal];
    }
}

- (void)setSelectTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateSelected];
    [self setNeedsLayout];
}



@end
