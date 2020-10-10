//
//  BDShopCounponCell.m
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopCounponCell.h"
@interface BDShopCounponCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *dicountLabel;
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@end
@implementation BDShopCounponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (IBAction)showButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buttonTapWithModel:isMyShop:)]) {
        [self.delegate buttonTapWithModel:self.model isMyShop:self.isMyShop];
    }
}

- (void)setModel:(BDShopCounponListModel *)model {
    _model = model;
//    [self.shopIconImageView sd_setImageWithURL:[_model.storeLogo zm_url]];
//    self.shopNameLabel.text = _model.storeName;
//    self.fromLabel.text = [NSString stringWithFormat:@"来自商号:%@",_model.businessName];
//    self.dicountLabel.text = [NSString stringWithFormat:@"%@折优惠卡",_model.cardDistinct];
//    if (!self.isMyShop) {
//        if (model.isCollection) {
//            [self.showButton setTitle:@"已收藏" forState:UIControlStateNormal];
//            self.showButton.backgroundColor = APPGrayColor;
//        }else {
//            [self.showButton setTitle:@"收藏" forState:UIControlStateNormal];
//            self.showButton.backgroundColor = COLOR_ffd500;
//        }
//    }
}

- (void)setIsMyShop:(BOOL)isMyShop {
    _isMyShop = isMyShop;
    if (!_isMyShop) {
        [self.showButton setTitle:@"收藏" forState:UIControlStateNormal];
    }else {
        [self.showButton setTitle:@"查看" forState:UIControlStateNormal];
    }
}
@end
