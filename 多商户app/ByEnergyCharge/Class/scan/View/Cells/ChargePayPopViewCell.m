//
//  ChargePayPopViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/9.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ChargePayPopViewCell.h"

@interface ChargePayPopViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectIamgeView;

@end
@implementation ChargePayPopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(ChargeTypeModel *)model {
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@支付",_model.name];
//    self.iconImageView.image = IMAGEWITHNAME(@"");
    self.selectIamgeView.image = _model.isSelcet ? IMAGEWITHNAME(@"selecticon") : IMAGEWITHNAME(@"selectNomal");
}

@end
