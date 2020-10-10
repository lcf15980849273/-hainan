//
//  BEnergyBaseTableViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/1.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseTableViewCell.h"
#import "UITableViewCell+SC.h"

@interface BEnergyBaseTableViewCell ()
@end

@implementation BEnergyBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
        [self byEnergyInitViewModel];
    }
    return self;
}

- (void)byEnergyInitViews {
    
}

- (void)byEnergySetViewLayout {
    
}

- (void)byEnergyInitViewModel {
    
}


@end
