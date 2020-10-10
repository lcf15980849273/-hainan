//
//  BEnergyHistorySearchCollectionCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/27.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyHistorySearchCollectionCell.h"

@implementation BEnergyHistorySearchCollectionCell
- (instancetype)init {
    if (self = [super init]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self byEnergyInitViews];
        [self byEnergySetViewLayout];
    }
    return self;
}

- (void)byEnergyInitViews {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#ABA8A8"];
    self.titleLabel.font = ByEnergyRegularFont(14);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#F3F3F3"];
    [self addSubview:self.titleLabel];
}

- (void)byEnergySetViewLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

@end
