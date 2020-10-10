//
//  BEnergyFocusViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/27.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyFocusViewModel.h"
#import "BEnergyFocusModel.h"

@implementation BEnergyFocusViewModel


- (RACCommand *)hnFocusCommand {
    ByEnergyWeakSekf
    if (!_hnFocusCommand) {
        _hnFocusCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(FocusListUrl) parameters:params.api responseClass:[BEnergyFocusModel class] netWorksModel:self.hnFocusCommand.netWorksModel];
            [[requestSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *dataList = x;
                    self.value = x;
                    [self.datasArray removeAllObjects];
                    self.datasArray = [[dataList.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
                        BEnergyFocusModel *focus = value;
                        SCItemModel *pageModel = [[SCItemModel alloc] init];
                        if (byEnergyIsValidStr(focus.imgUrl)) {
                            pageModel.imageUrl = [StringUtils resoureUrlStrWithPath:focus.imgUrl baseUrl:URL_BASE compressMode:SCCompressModeWidthFit targetSize:self.focusViewSize];
                            pageModel.showTitle = NO;
                            pageModel.imgSrcType = SCItemImageSourceTypeWebUrl;
                        }
                        return pageModel;
                    }].toArray mutableCopy];
                    self.result = YES;
                }
            }error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            
            return requestSignal;
        }];
            
    }
    return _hnFocusCommand;
}


@end
