//
//  BEnergyStubGroupDetailHeadView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/21.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyStubGroupDetailHeadView.h"
#import "UIButton+Layout.h"
#import "NYCycleScrollView.h"
#import "BEnergyStubGroupDetailModel.h"
#import "StringForUnit.h"
#import "CFPaddingLabel.h"
@interface BEnergyStubGroupDetailHeadView ()
@property (nonatomic, strong) UILabel *byTitleLabel;
@property (nonatomic, strong) UIView *byLine;
@property (nonatomic, strong) NYCycleScrollView *byBanner;
@property (nonatomic, strong) UILabel *stubInfoLabel;
@property (nonatomic, strong) UIStackView *backStackView;
@property (nonatomic, strong) UIButton *navButton;
@property (nonatomic, strong) UILabel *byDistanceLabel;
@property (nonatomic, strong) BEnergyStubGroupDetailModel *detailModel;
@property (nonatomic, strong) UILabel *byAddressLabel;
@property (nonatomic, strong) UIImageView *byAddressImageView;
@end

@implementation BEnergyStubGroupDetailHeadView

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
    
    [self addSubview:self.byBanner];
    [self addSubview:self.byTitleLabel];
    [self addSubview:self.stubInfoLabel];
    [self addSubview:self.backStackView];
    [self addSubview:self.byLine];
    [self addSubview:self.byAddressImageView];
    [self addSubview:self.byAddressLabel];
    [self addSubview:self.navButton];
    [self addSubview:self.byDistanceLabel];
    [self hidenBesideService];
}



- (void)byEnergySetViewLayout {
    
    
    [self.byBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(182);
    }];
    
    [self.byTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byBanner.mas_bottom).mas_offset(10);
        make.right.lessThanOrEqualTo(self.mas_right).mas_offset(-20);
        make.left.mas_equalTo(20);
    }];
    
    [self.stubInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byTitleLabel.mas_bottom).mas_offset(8);
        make.right.equalTo(self).offset(-20);
        make.left.mas_equalTo(20);
        make.height.mas_offset(11);
    }];
    
    [self.backStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stubInfoLabel.mas_bottom).mas_offset(7);
        make.leading.equalTo(self.stubInfoLabel);
        make.height.mas_offset(16);
    }];
    
    [self.byLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backStackView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_offset(1);
    }];
    
    [self.navButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byLine.mas_bottom).offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.width.mas_offset(30);
    }];
    
    [self.byDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navButton.mas_bottom).offset(0);
        make.centerX.equalTo(self.navButton);
    }];
    
    [self.byAddressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byLine.mas_bottom).offset(8);
        make.left.equalTo(self).offset(20);
        make.width.mas_offset(18);
        make.height.mas_offset(23);
    }];
   
    [self.byAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.byLine.mas_bottom).offset(10);
        make.left.equalTo(self.byAddressImageView.mas_right).offset(5);
        make.right.equalTo(self).offset(-70);
    }];
}


- (void)fillDataWithDataModel:(BEnergyBaseModel *)baseModel {
    BEnergyStubGroupDetailModel *model = (BEnergyStubGroupDetailModel *)baseModel;
    self.detailModel = model;
    kWeakSelf(self);
    [self.byBanner configUIWithFocusDataArray:model.imgUrls selectFocusBlock:^(NSInteger focusIndex) {
        [weakself.focusIndexSubject sendNext:@(focusIndex)];
    }];
    self.byTitleLabel.text = byEnergyClearNilStr(model.name);
    self.byAddressLabel.text = byEnergyClearNilStr(model.address);
    self.byDistanceLabel.text =  [StringForUnit getKmStrWithMeter:[model.distance intValue] unitStr:@"km"];
    NSMutableAttributedString *stubInfoStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"快充: 闲%ld/共%ld ｜ 慢充: 闲%ld/共%ld",(long)model.stubDcIdleCnt,(long)model.stubDcCnt,(long)model.stubAcIdleCnt,(long)model.stubAcCnt]];
    
    NSRange fastStubRange = [[stubInfoStr string] rangeOfString:[NSString stringWithFormat:@"%ld",(long)model.stubDcIdleCnt]];
    NSRange flowStubRange = NSMakeRange(15 + [NSString stringWithFormat:@"%ld",(long)model.stubDcIdleCnt].length + [NSString stringWithFormat:@"%ld",(long)model.stubDcCnt].length, [NSString stringWithFormat:@"%ld",(long)model.stubAcIdleCnt].length);
    [stubInfoStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"ff9c15"] range:fastStubRange];
    [stubInfoStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"ff9c15"] range:flowStubRange];
    self.stubInfoLabel.attributedText = stubInfoStr;
    
    UILabel *label = [self viewWithTag:1000];
    label.hidden = NO;
    label.text = model.isOpen ? @"对外开放" : @"不对外开放";
    
    if (model.auxiliaryList.count > 0) {
           for (auxiliaryList *Listmodel in model.auxiliaryList) {
               switch (Listmodel.value) {
                   case 1:
                       [self viewWithTag:1001].hidden = Listmodel.usable == 1 ? NO : YES;
                       break;
                   case 2:
                       [self viewWithTag:1002].hidden = Listmodel.usable == 1 ? NO : YES;
                       break;
                   case 3:
                       [self viewWithTag:1003].hidden = Listmodel.usable == 1 ? NO : YES;
                       break;
                   case 4:
                       [self viewWithTag:1004].hidden = Listmodel.usable == 1 ? NO : YES;
                       break;
                   default:
                       break;
               }
           }
       }else {
           [self hidenBesideService];
       }
    
}

- (void)hidenBesideService {
    [self viewWithTag:1000].hidden = YES;
    [self viewWithTag:1001].hidden = YES;
    [self viewWithTag:1002].hidden =  YES;
    [self viewWithTag:1003].hidden = YES;
    [self viewWithTag:1004].hidden = YES;
}

+ (CGFloat)calculateTableHeaderViewHeightWithModel:(BEnergyStubGroupDetailModel *)model {
    CGSize stubAddressSize = [model.address sizeWithFont:ByEnergyRegularFont(14) width:SCREENWIDTH - 113];
    CGSize stubTitleSize = [model.name sizeWithFont:ByEnergyRegularFont(18) width:SCREENWIDTH - 40];
    if (stubAddressSize.height < 65) {
        return 260  + stubTitleSize.height + 50;
    }else {
        return 260  + stubTitleSize.height + stubAddressSize.height;
    }
}

#pragma mark ----- lazyLoad
- (UILabel *)stubInfoLabel {
    if (!_stubInfoLabel) {
        _stubInfoLabel = [[UILabel alloc] init];
        _stubInfoLabel.font = ByEnergyRegularFont(13);
        _stubInfoLabel.textColor = BYENERGYCOLOR(0xb5b5b5);
    }
    return _stubInfoLabel;
}

- (RACSubject *)focusIndexSubject {
    if (_focusIndexSubject == nil) {
        _focusIndexSubject = [RACSubject subject];
    }
    return _focusIndexSubject;
}

- (UIView *)byLine {
    if (!_byLine) {
        _byLine = [[UIView alloc] init];
        _byLine.backgroundColor = BYENERGYCOLOR(0xf4f4f4);
    }
    return _byLine;
}

- (UILabel *)byTitleLabel {
    if (!_byTitleLabel) {
        _byTitleLabel = [[UILabel alloc] init];
        _byTitleLabel.font = ByEnergyRegularFont(18);
        _byTitleLabel.textColor = UIColor.byEnergyBlack;
        _byTitleLabel.numberOfLines = 0;
        _byTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byTitleLabel;
}


- (UILabel *)byAddressLabel {
    if (!_byAddressLabel) {
        _byAddressLabel = [[UILabel alloc] init];
        _byAddressLabel.font = ByEnergyRegularFont(14);
        _byAddressLabel.textColor = BYENERGYCOLOR(0x717171);
        _byAddressLabel.numberOfLines = 0;
        _byAddressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _byAddressLabel;
}

- (UIImageView *)byAddressImageView {
    if (!_byAddressImageView) {
        _byAddressImageView = [[UIImageView alloc] initWithImage:IMAGEWITHNAME(@"stubAddressIcon")];
    }
    return _byAddressImageView;;
}

- (NYCycleScrollView *)byBanner {
    if (!_byBanner) {
        _byBanner = [NYCycleScrollView cycleScrollViewShouldInfiniteLoop:YES imageGroups:nil];
        _byBanner.placeholderImage = [UIImage imageNamed:@"make_byBanner_StubDetail"];
        _byBanner.cellPlaceholderImage = [UIImage imageNamed:@"make_byBanner_StubDetail"];
        _byBanner.autoScrollTimeInterval = 3;
        _byBanner.autoScroll = YES;
        _byBanner.isZoom = NO;
        _byBanner.itemSpace = 11;
        _byBanner.imgCornerRadius = 4;
        _byBanner.itemWidth = SCREENWIDTH-22;
        _byBanner.pageControl.hidden = NO;
    }
    return _byBanner;
}

- (UIStackView *)backStackView {
    if (!_backStackView) {
        _backStackView = [[UIStackView alloc] init];
        _backStackView.axis = UILayoutConstraintAxisHorizontal;
        _backStackView.spacing = 5;
        _backStackView.alignment = UIStackViewAlignmentFill;
        NSArray *serviceArray = @[@"对外开放",@"卫生间",@"餐饮",@"便利店",@"休息室"];
        for (NSInteger i = 0; i < serviceArray.count; i++) {
            CFPaddingLabel *label = [[CFPaddingLabel alloc]init];
            label.font = ByEnergyRegularFont(10);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = BYENERGYCOLOR(0xff9c15);
            label.backgroundColor = [BYENERGYCOLOR(0xffaa36) colorWithAlphaComponent:0.2f];
            label.layer.cornerRadius = 3;
            label.clipsToBounds = YES;
            label.text = serviceArray[i];
            label.tag = i + 1000;
            label.insets = UIEdgeInsetsMake(3, 5, 3, 5);
            [_backStackView addArrangedSubview:label];
        }
    }
    return _backStackView;
}

- (UIButton *)navButton {
    if (!_navButton) {
        _navButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navButton.userInteractionEnabled = YES;
        [_navButton setImage:IMAGEWITHNAME(@"homeNavIcon") forState:UIControlStateNormal];
        ByEnergyWeakSekf
        [[_navButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ByEnergyStrongSelf
            [[BEnergyAppStorage sharedInstance] byEnergyOpenNaviWithLat:self.detailModel.gisGcj02Lat
                                                              destinationLng:self.detailModel.gisGcj02Lng
                                                             destinationName:self.detailModel.name
                                                             destinationView:self];
        }];
        
    }
    return _navButton;
}

- (UILabel *)byDistanceLabel {
    if (!_byDistanceLabel) {
        _byDistanceLabel = [[UILabel alloc] init];
        _byDistanceLabel.font = ByEnergyBoldFont(9);
        _byDistanceLabel.textColor = [UIColor colorByEnergyWithBinaryString:@"#00BFE5"];
    }
    return _byDistanceLabel;
}
@end
