//
//  BEnergyPayInfoCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/24.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyPayInfoCell.h"
@interface BEnergyPayInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *payIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *payTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *payDesCribLbel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@end
@implementation BEnergyPayInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setModel:(BEnergyPayTypeModel *)model {
    _model = model;
    self.payIconImageView.image = IMAGEWITHNAME(_model.payTypeIcon);
    self.payTitleLabel.text = _model.payTitle;
    self.payDesCribLbel.text = _model.payDescrib;
    self.selectImageView.image = _model.isSelect ? IMAGEWITHNAME(@"nomalPaySelect") : IMAGEWITHNAME(@"selectPayNomal");
}

@end
@implementation BEnergyPayTypeModel

@end
