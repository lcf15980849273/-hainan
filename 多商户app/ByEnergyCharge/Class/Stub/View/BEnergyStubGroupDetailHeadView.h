//
//  BEnergyStubGroupDetailHeadView.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseView.h"
#import "BEnergyStubGroupDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BEnergyStubGroupDetailHeadView : BEnergyBaseView

@property (nonatomic, strong) RACSubject *focusIndexSubject;

+ (CGFloat)calculateTableHeaderViewHeightWithModel:(BEnergyStubGroupDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
