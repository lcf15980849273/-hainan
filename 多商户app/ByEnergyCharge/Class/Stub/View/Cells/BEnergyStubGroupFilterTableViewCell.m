//
//  BEnergyStubGroupFilterTableViewCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/16.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubGroupFilterTableViewCell.h"
#import "UIButton+HitRec.h"
#import "UIView+BorderLine.h"

@interface BEnergyStubGroupFilterTableViewCell ()
@property (nonatomic,strong) UIImageView *line;
//@property (nonatomic,strong) UIImageView *topLine;
@end

@implementation BEnergyStubGroupFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.selectedBtn.hitEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
}

- (void)setupView {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = UIColor.byEnergyBlack;
    self.titleLabel.font = ByEnergyRegularFont(12);
    [self addSubview:self.titleLabel];
    
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectedBtn.userInteractionEnabled = YES;
    [self.selectedBtn setImage:IMAGEWITHNAME(@"check_nor_StubList") forState:UIControlStateNormal];
    [self.selectedBtn setImage:IMAGEWITHNAME(@"check_selected_StubList") forState:UIControlStateSelected];
    [self addSubview:self.selectedBtn];
    
    self.line = [[UIImageView alloc] init];
    self.line.backgroundColor = UIColor.byEnergyLineGray;
    [self addSubview:_line];
    
//    self.topLine = [[UIImageView alloc] init];
//    self.topLine.backgroundColor = UIColor.byEnergyLineGray;
//    [self addSubview:_topLine];
    
    [self setViewLayout];
}

- (void)setViewLayout {
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).mas_offset(0);
        make.left.equalTo(self.selectedBtn.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(95, 20));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
    }];
    
//    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_offset(0);
//        make.height.mas_equalTo(1);
//    }];
}

- (void)configUIWithStartChargeCellModel:(BEnergyStartChargeCellModel *)model {
    self.titleLabel.text = byEnergyClearNilStr(model.title);
    [self.selectedBtn setSelected:[model.value intValue]];
}


@end
