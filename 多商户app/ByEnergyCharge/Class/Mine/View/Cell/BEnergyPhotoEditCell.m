//
//  BEnergyPhotoEditCell.m
//  chuxin
//
//  Created by yoke on 16/1/14.
//  Copyright © 2016年 chuxin. All rights reserved.
//

#import "BEnergyPhotoEditCell.h"
@interface BEnergyPhotoEditCell()

@end
@implementation BEnergyPhotoEditCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.deleteButton];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.width.and.height.mas_equalTo(20);
    }];

}

#pragma mark - lazyLoad
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"deleteImage"] forState:UIControlStateNormal];
    }
    return _deleteButton;
}
@end
