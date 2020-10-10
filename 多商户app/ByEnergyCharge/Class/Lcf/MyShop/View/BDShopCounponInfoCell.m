//
//  BDShopCounponInfoCell.m
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopCounponInfoCell.h"
//#import "BDActionBackgroundView.h"
//#import "BDQRCodeView.h"
//#import "BDBorderLineView.h"
@interface BDShopCounponInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *bussinessNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;
@property (weak, nonatomic) IBOutlet UILabel *disCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
//@property (weak, nonatomic) IBOutlet BDBorderLineView *phoneView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewHeight;
@end
@implementation BDShopCounponInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.hintLabel.hidden = YES;
    self.disCountLabel.hidden = YES;
    self.QRImageView.hidden = YES;
    
//    ByEnergyWeakSekf;
//    [self.QRImageView zm_performActionOnTap:^(__kindof UIView *view) {
//        ByEnergyStrongSelf;
//        BDActionBackgroundView *actionBGView = [BDActionBackgroundView actionBackgroundViewCoverInWindow];
//        [actionBGView showWithView:^UIView *(BDActionBackgroundView *actionBgView) {
//            BDQRCodeView *qrcodeView = [BDQRCodeView QRCodeView];
//            qrcodeView.QRCodeImgView.image = self.QRImageView.image;
//            qrcodeView.disCountLabel.text = [NSString stringWithFormat:@"享受%@折优惠卡",self.model.cardDistinct];
//            CGFloat space = 55.f * (ScreenWidth / 375);
//            CGFloat width = ScreenWidth - 2 * space;
//            CGFloat height = width * 14.f / 13.f + 30 + 44;
//            qrcodeView.frame = CGRectMake(space, (ScreenHeight - height) / 2, width, height);
//            return qrcodeView;
//        }];
//        actionBGView.hiddenWhenTouch = YES;
//    }];
}

- (void)setModel:(BDShopCounponDetailModel *)model {
    _model = model;
    self.phoneLabel.text = _model.businessTel;
    if (_model.businessTel.length == 0) {
//        self.phoneView.hidden = YES;
        self.phoneViewHeight.constant = 0;
        self.stackViewHeight.constant = 256.0f;
    }else {
//        self.phoneView.hidden = NO;
        self.phoneViewHeight.constant = 44.0f;
        self.stackViewHeight.constant = 300.0f;
    }
    self.addressLabel.text = _model.storeAddress;
    self.bussinessNameLabel.text = _model.businessName;
//    [self.shopIconImageView sd_setImageWithURL:[_model.storeLogo zm_url]];
    self.shopNameLabel.text = _model.storeName;
    self.disCountLabel.text = [NSString stringWithFormat:@"%@折优惠卡",_model.cardDistinct];
//    NSString *url = [NSString stringWithFormat:@"http://t.cn/%@",_model.storeCardId];
//    self.QRImageView.image = [ImageTool outputQRImageWithURL:_model.storeCardId
//                                                           size:ScreenWidth * 0.41];
//
}


@end
