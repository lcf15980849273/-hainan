//
//  BEnergyStubDetailInfoCell.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import "BEnergyStubDetailInfoCell.h"
#import "BEnergyStubGroupDetailModel.h"
#import "BEnergyStubGroupDetailModel.h"
#import "CFProgressView.h"
@interface BEnergyStubDetailInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *stubIDLabel;//桩编号
@property (weak, nonatomic) IBOutlet UILabel *voltageLabel;//电压
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;//功率
@property (weak, nonatomic) IBOutlet UILabel *chargeTypeLabel;//类型
@property (weak, nonatomic) IBOutlet CFProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;//状态View

@end
@implementation BEnergyStubDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)byEnergyFillCellDataWithModel:(BEnergyBaseModel *)baseModel {
    Stublist *model = (Stublist *)baseModel;
    self.stubIDLabel.text = NSStringFormat(@"桩编号: %@",byEnergyClearNilStr(model.id));
    self.voltageLabel.text = NSStringFormat(@"电压: %@",byEnergyClearNilStr(model.chargeVoltage));
    self.powerLabel.text = NSStringFormat(@"功率: %@",byEnergyClearNilStr(model.strKw));
    
    switch (model.type) {
        case 0:
            self.chargeTypeLabel.text = @"交流慢充";
            break;
        case 1:
            self.chargeTypeLabel.text = @"直流快充";
            break;
        default:
            self.chargeTypeLabel.text = @"未知类型";
            break;
    }
    
}


- (void)setStubListModel:(Stublist *)stubListModel {
    _stubListModel = stubListModel;
    
    if ([_stubListModel.status isEqualToString:@"00"]) { //空闲
        self.stateImageView.hidden = NO;
        self.stateImageView.image = IMAGEWITHNAME(@"freeIcon");
        self.progressView.hidden = YES;
    }else if ([_stubListModel.status isEqualToString:@"01"]) { //充电
        self.progressView.progerssBackgroundColor = BYENERGYCOLOR(0xdbdbdb);
        self.progressView.progerssColor = BYENERGYCOLOR(0x00BFE5);
        self.progressView.stateLabel.text = @"充电中";
        self.progressView.stateLabel.textColor = BYENERGYCOLOR(0x00BFE5);
        self.progressView.progress =  _stubListModel.chargeSoc * 0.01;
        self.stateImageView.hidden = YES;
        self.progressView.hidden = NO;
    }else if ([_stubListModel.status isEqualToString:@"0C"]) { //占用中
        self.stateImageView.hidden = NO;
        self.stateImageView.image = IMAGEWITHNAME(@"useIcon");
        self.progressView.hidden = YES;
    }else { //维护
        self.stateImageView.hidden = NO;
        self.stateImageView.image = IMAGEWITHNAME(@"maintenanceIcon");
        self.progressView.hidden = YES;
    }
}


@end
@implementation SocProgressModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"stubList" : [Stublist class]
             };
}
@end
