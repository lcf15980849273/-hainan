//
//  BEnergyStubGroupDetailFooterView.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyStubGroupDetailFooterView.h"
#import "ByEnergyScanManager.h"
@interface BEnergyStubGroupDetailFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *byTotalLabel;


@end
@implementation BEnergyStubGroupDetailFooterView

- (void)setGropDetailModel:(BEnergyStubGroupDetailModel *)gropDetailModel {
      _gropDetailModel = gropDetailModel;
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:NSStringFormat(@"%.4f 元/度",_gropDetailModel.totalFee)];
    NSRange contentRange = [[contentStr string] rangeOfString:@"元/度"];
    [contentStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorByEnergyWithBinaryString:@"#717171"] range:contentRange];
    [contentStr addAttribute:NSFontAttributeName value:ByEnergyRegularFont(12) range:contentRange];
    self.byTotalLabel.attributedText = contentStr;
}



- (IBAction)chargeButtonClick:(UIButton *)sender {
    //登录逻辑修改前
    if (isLogOut) {
        [BEnergyLoginManger ByEnergyPresentLoginViewController];return;
    }//
    
    [[ByEnergyScanManager sharedByEnergyScanManager] setController:ByEnergyTopVC];
    [[ByEnergyScanManager sharedByEnergyScanManager] pushBEnergyScanQRViewController];
    
    
}
@end
