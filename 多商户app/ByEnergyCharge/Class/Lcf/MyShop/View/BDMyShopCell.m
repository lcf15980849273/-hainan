//
//  BDMyShopCell.m
//  bydeal
//
//  Created by chenfeng on 2018/12/25.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDMyShopCell.h"
@interface BDMyShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSArray *titleArray;
@end
@implementation BDMyShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    self.titleLabel.text = self.titleArray[_index];
    self.iconImageView.image = IMAGEWITHNAME(self.iconArray[_index]);
}

#pragma mark - LazyLoad
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"小店信息",@"小店优惠卡",@"分类管理",@"我的业绩",@"问题反馈",@"供应商消息",@"跑单投诉",@"分销选货"];
    }
    //,@"我的业绩",@"问题反馈",@"供应商消息",@"分销申请明细",@"跑单投诉"
    return _titleArray;
}

- (NSArray *)iconArray {
    if (!_iconArray) {
        _iconArray = @[@"partner_icon_information",@"partner_icon_coupon",@"partner_icon_classification",@"partner_icon_achievement",@"partner_icon_feedback",@"partner_icon_news",@"partner_icon_complaint",@"partner_icon_distribution"];
    }
    return _iconArray;
}
@end
