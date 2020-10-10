//
//  BEnergyChargingCoverView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/15.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyChargingCoverView.h"


@interface BEnergyChargingCoverView ()
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *gifImageView;
@end

@implementation BEnergyChargingCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self byEnergyInitViews];
    }
    return self;
}

- (void)byEnergyInitViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.navView];
    [self addSubview:self.gifImageView];
    [self addSubview:self.titleLabel];
    
    kWeakSelf(self);
//    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(kTopHeight);
//    }];
    
    [self.gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self).mas_offset(96);
        make.size.mas_equalTo(CGSizeMake(400, 300));
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.gifImageView.mas_bottom).mas_offset(-23);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(25);
    }];
    
}

//- (UIView *)navView {
//    if (_navView == nil) {
//        _navView = [[UIView alloc] init];
//        _navView.backgroundColor = [UIColor colorByEnergyWithBinaryString:@"#00D869"];
//    }
//    return _navView;
//}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"安全检测中…";
        _titleLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#737373"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = ByEnergyRegularFont(18);
    }
    return _titleLabel;
}

- (UIImageView *)gifImageView {
    if (_gifImageView == nil) {
        _gifImageView = [[UIImageView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"charging_loading" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage sd_imageWithGIFData:data];
        _gifImageView.image = image;
    }
    return _gifImageView;
}



@end
