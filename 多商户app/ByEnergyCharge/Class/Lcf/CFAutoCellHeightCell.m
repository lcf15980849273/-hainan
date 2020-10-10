//
//  CFAutoCellHeightCell.m
//  byCF
//
//  Created by 刘辰峰 on 2020/11/27.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import "CFAutoCellHeightCell.h"
@interface CFAutoCellHeightCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//label宽度属性，先在xib上随便设置一个宽度。然后在代码去改

@end
@implementation CFAutoCellHeightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //注意点1
    self.labelWidth.constant = SCREENWIDTH - 15 * 2;
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

@end
