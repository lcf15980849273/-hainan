//
//  BDShopCounponIntroduceCell.m
//  bydeal
//
//  Created by chenfeng on 2018/12/28.
//  Copyright © 2018年 BD. All rights reserved.
//

#import "BDShopCounponIntroduceCell.h"
@interface BDShopCounponIntroduceCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end
@implementation BDShopCounponIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (CGFloat)cellHeightWithModel:(BDShopCounponDetailModel *)model {
    
    CGSize contentSize;
    if (model.isMyshop) {
        contentSize = [model.cobberRight sizeWithFont:ByEnergyRegularFont(14) width:SCREENWIDTH - 30];
        return 54 + contentSize.height;
    }else {
        if (model.cardExp.length > 0) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 10;
            NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:model.cardExp];
            [attributes addAttribute:NSFontAttributeName value:ByEnergyRegularFont(14) range:NSMakeRange(0, model.cardExp.length)];
            [attributes addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.cardExp.length)];
            CGSize attSize = [attributes boundingRectWithSize:CGSizeMake(SCREENWIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
            return 54 + attSize.height;
        }else {
            return 5;
        }
    }
}

- (void)setModel:(BDShopCounponDetailModel *)model {
    _model = model;
    if (model.isMyshop) {
        self.hintLabel.text = @"合伙人权益";
        self.contentLabel.text = _model.cobberRight;
    }else {
        self.hintLabel.text = @"说明";
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_model.cardExp dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:ByEnergyRegularFont(14) } documentAttributes:nil error:nil];
        self.contentLabel.attributedText = attrStr;
    }
    
}

@end
