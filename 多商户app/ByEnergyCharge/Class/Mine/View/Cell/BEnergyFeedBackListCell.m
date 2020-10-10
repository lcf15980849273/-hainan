//
//  BEnergyFeedBackListCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/2.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyFeedBackListCell.h"

@interface BEnergyFeedBackListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation BEnergyFeedBackListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(BEnergyFeedBackTypeModel *)model {
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@: %@",_model.title,_model.remark];
    self.iconImageView.image = _model.select ? IMAGEWITHNAME(@"feedBackSelect") : IMAGEWITHNAME(@"feedBackNomal");
    if (_model.select) {
        [self.iconImageView byEnergyViewWithAnimation:self.iconImageView];
    }
}
@end
