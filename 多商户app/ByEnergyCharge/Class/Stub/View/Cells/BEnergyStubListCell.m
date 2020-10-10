//
//  BEnergyStubListCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/2.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyStubListCell.h"
#import "CFPaddingLabel.h"
#import "UIButton+HitRec.h"
#import "StringForUnit.h"
#import "BEnergyStubGroupDetailModel.h"
@interface BEnergyStubListCell ()
@property (weak, nonatomic) IBOutlet CFPaddingLabel *openLabel;
@property (weak, nonatomic) IBOutlet CFPaddingLabel *wcLabel;
@property (weak, nonatomic) IBOutlet CFPaddingLabel *foodlabel;
@property (weak, nonatomic) IBOutlet CFPaddingLabel *restLabel;
@property (weak, nonatomic) IBOutlet CFPaddingLabel *storeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//电站名称
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;//价格
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;//距离
@property (weak, nonatomic) IBOutlet UIButton *parkingButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *stubInfoLabel;

@end
@implementation BEnergyStubListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initDataAndViews];
    
}

- (void)initDataAndViews {
    
    self.loactionBtn.adjustsImageWhenHighlighted = NO;
    self.parkingButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.parkingButton.userInteractionEnabled = NO;
    [self.parkingButton setImage:IMAGEWITHNAME(@"stubAddressIcon") forState:UIControlStateNormal];
    self.parkingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.openLabel.insets = UIEdgeInsetsMake(3, 5, 3, 5);
    self.wcLabel.insets = UIEdgeInsetsMake(3, 5, 3, 5);
    self.foodlabel.insets = UIEdgeInsetsMake(3, 5, 3, 5);
    self.restLabel.insets = UIEdgeInsetsMake(3, 5, 3, 5);
    self.storeLabel.insets = UIEdgeInsetsMake(3, 5, 3, 5);
    
    self.openLabel.layer.borderWidth = 0.5;
    self.openLabel.layer.borderColor = BYENERGYCOLOR(0xff9c15).CGColor;
    self.wcLabel.layer.borderWidth = 0.5;
    self.wcLabel.layer.borderColor = BYENERGYCOLOR(0xff9c15).CGColor;
    self.foodlabel.layer.borderWidth = 0.5;
    self.foodlabel.layer.borderColor = BYENERGYCOLOR(0xff9c15).CGColor;
    self.restLabel.layer.borderWidth = 0.5;
    self.restLabel.layer.borderColor = BYENERGYCOLOR(0xff9c15).CGColor;
    self.storeLabel.layer.borderWidth = 0.5;
    self.storeLabel.layer.borderColor = BYENERGYCOLOR(0xff9c15).CGColor;
    
    self.backView.layer.cornerRadius = 5.0f;

    self.backView.layer.shadowOffset = CGSizeMake(0, 2);
    self.backView.layer.shadowOpacity = 1.0;
    self.backView.layer.shadowRadius = 2; //设置阴影的大小
    self.backView.layer.shadowColor = [UIColor colorWithRed:0.0f/255.0f
                                                      green:0.0f/255.0f
                                                       blue:0.0f/255.0f
                                                      alpha:0.05].CGColor;
    [self hidenBesideService];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.loactionBtn.hitEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -15);
}

- (void)setGroupModel:(BEnergyStubGroupModel *)groupModel {
    
    _groupModel = groupModel;
    self.openLabel.text = groupModel.isOpen ? @"对外开放" : @"不对外开放";
    self.titleLabel.text = byEnergyClearNilStr(_groupModel.name);
    [self.parkingButton setTitle:(_groupModel.address) forState:UIControlStateNormal];
    self.distanceLabel.text = [StringForUnit getKmStrWithMeter:_groupModel.distance unitStr:@"km"];
    
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:NSStringFormat(@"%.4f 元/度",_groupModel.totalFee)];
    NSRange contentRange = [[contentStr string] rangeOfString:@"元/度"];
    [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"#A3A3A3"] range:contentRange];
    [contentStr addAttribute:NSFontAttributeName value:ByEnergyRegularFont(10) range:contentRange];
    self.contentLabel.attributedText = contentStr;

    NSMutableAttributedString *stubInfoStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"快充: 闲%d/共%d ｜ 慢充: 闲%d/共%d",_groupModel.stubDcIdleCnt,_groupModel.stubDcCnt,_groupModel.stubAcIdleCnt,_groupModel.stubAcCnt]];
    NSRange fastStubRange = [[stubInfoStr string] rangeOfString:[NSString stringWithFormat:@"%d",_groupModel.stubDcIdleCnt]];
    NSRange flowStubRange = NSMakeRange(15 + [NSString stringWithFormat:@"%d",_groupModel.stubDcIdleCnt].length + [NSString stringWithFormat:@"%d",_groupModel.stubDcCnt].length, [NSString stringWithFormat:@"%d",_groupModel.stubAcIdleCnt].length);
    [stubInfoStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"ff9c15"] range:fastStubRange];
    [stubInfoStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"ff9c15"] range:flowStubRange];
    self.stubInfoLabel.attributedText = stubInfoStr;
    
    if (groupModel.auxiliaryList.count > 0) {
        for (auxiliaryList *model in groupModel.auxiliaryList) {
            switch (model.value) {
                case 1:
                    self.wcLabel.hidden = model.usable == 1 ? NO : YES;
                    break;
                case 2:
                    self.foodlabel.hidden = model.usable == 1 ? NO : YES;
                    break;
                case 3:
                    self.restLabel.hidden = model.usable == 1 ? NO : YES;
                    break;
                case 4:
                    self.storeLabel.hidden = model.usable == 1 ? NO : YES;
                    break;
                default:
                    break;
            }
        }
    }else {
        [self hidenBesideService];
    }
}

- (IBAction)locationButtonClick:(id)sender {
    [[BEnergyAppStorage sharedInstance] byEnergyOpenNaviWithLat:self.groupModel.gisGcj02Lat
                                               destinationLng:self.groupModel.gisGcj02Lng
                                              destinationName:self.groupModel.name
                                              destinationView:self];
}


- (void)hidenBesideService {
    self.wcLabel.hidden = YES;
    self.foodlabel.hidden = YES;
    self.restLabel.hidden = YES;
    self.storeLabel.hidden = YES;
}
@end
