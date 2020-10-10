//
//  BEnergyLocationAnnotationView.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/6.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "BEnergyLocationAnnotationView.h"

@interface BEnergyLocationAnnotationView() {
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;

@end

@implementation BEnergyLocationAnnotationView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 70, 26);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 70, 26);
    }
    return self;
}


+ (instancetype)annotationViewWithMapView:(MAMapView *)mapView  {
    static NSString *viewID = @"BEnergyLocationAnnotationView";
    BEnergyLocationAnnotationView *annotationView = (BEnergyLocationAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:viewID];
    if (annotationView == nil) {
        annotationView = [ByEnergyLoadViews loadViewFromNib:viewID];
    }
    return annotationView;
}

- (void)setAnnotation:(id<MAAnnotation>)annotation {
    [super setAnnotation:annotation];
}

- (void)setStubGroupModel:(BEnergyStubGroupModel *)stubGroupModel {
    _stubGroupModel = stubGroupModel;
    self.titleLabel.text = [NSString stringWithFormat:@"快充: 空闲%d",_stubGroupModel.stubDcIdleCnt];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected){
        self.imageView.image = IMAGEWITHNAME(@"stubIcon");
        [self byEnergyViewWithAnimationtoNarrow:self sate:YES];
        self.titleLabel.textColor = BYENERGYCOLOR(0xffffff);
    }
    else{
        self.imageView.image = IMAGEWITHNAME(@"stubWhiteIcon");
        self.titleLabel.textColor = BYENERGYCOLOR(0x00bfe5);
        [self byEnergyViewWithAnimationtoNarrow:self sate:NO];
    }
    [super setSelected:selected animated:animated];
}

@end
