//
//  BEnergyStubGroupInfoView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BEnergyStubGroupModel;
@interface BEnergyStubGroupInfoView : BEnergyBaseView
@property (nonatomic, strong) BEnergyStubGroupModel *stubGroup;
@property (nonatomic, strong) UIButton *loactionBtn;
@property (nonatomic, strong) RACSubject *detailSubject;
@property (nonatomic, strong) RACSubject *updataHeightSubject;
@end

NS_ASSUME_NONNULL_END
