//
//  BEnergyFeedBackViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/1/3.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyFeedBackViewModel.h"
#import "BEnergyFeedBackTypeModel.h"
#import "BEnergyMyFeedBackListModel.h"
#import "BEnergyFeedBackCallBackListModel.h"
#import "SCPhotoUtil.h"
#import "SystemUtils.h"
@implementation BEnergyFeedBackViewModel

- (RACCommand *)hnFeedBackTypeCommand {
    if (!_hnFeedBackTypeCommand) {
        ByEnergyWeakSekf;
        _hnFeedBackTypeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            self.hnFeedBackTypeCommand.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiFeedbackCategorylUrl) parameters:params.api responseClass:[BEnergyFeedBackTypeModel class] netWorksModel:self.hnFeedBackTypeCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                [self.datasArray removeAllObjects];
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *array = x;
                    [self.datasArray addObjectsFromArray:array];
                    self.result = YES;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnFeedBackTypeCommand;
}

- (RACCommand *)hnMyFeedBackListCommand {
    if (!_hnMyFeedBackListCommand) {
        ByEnergyWeakSekf;
        _hnMyFeedBackListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnMyFeedBackListCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            params.pageIndex = self.page.PageIndex;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiFeedbackListForUserUrl) parameters:params.api responseClass:[BEnergyMyFeedBackListModel class] netWorksModel:self.hnMyFeedBackListCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSArray *array = x;
                    self.result = YES;
                    if ([array count] > 0) {
                        [self.datasArray addObjectsFromArray:array];
                    }
                    self.page.SizeCount = [array count];
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
                self.page.PageIndex --;
                
            }];
            return requestSignal;
        }];
    }
    return _hnMyFeedBackListCommand;
}

- (RACCommand *)hnFeedBackResoveCommand {
    if (!_hnFeedBackResoveCommand) {
        ByEnergyWeakSekf;
        _hnFeedBackResoveCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:self.feedbackId forKey:@"feedbackId"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiFeedbackSolveUrl) parameters:params.api responseClass:nil netWorksModel:self.hnFeedBackResoveCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnFeedBackResoveCommand;
}

- (RACCommand *)hnFeedBackAdditionalCommand {
    if (!_hnFeedBackAdditionalCommand) {
        ByEnergyWeakSekf;
        _hnFeedBackAdditionalCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:self.feedbackId forKey:@"feedbackId"];
            [params setObject:self.info forKey:@"info"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiFeedbackAppendUrl) parameters:params.api responseClass:nil netWorksModel:self.hnFeedBackAdditionalCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnFeedBackAdditionalCommand;
}


- (RACCommand *)hnFeedBackCallListCommand {
    if (!_hnFeedBackCallListCommand) {
        ByEnergyWeakSekf;
        _hnFeedBackCallListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            self.hnFeedBackCallListCommand.netWorksModel.isHidenHUD = YES;
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            [params setObject:self.feedbackId forKey:@"feedbackId"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiFeedbackLogListUrl) parameters:params.api responseClass:nil netWorksModel:self.hnFeedBackCallListCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSDictionary *dic = x;
                    BEnergyFeedBackCallBackListModel *model = [BEnergyFeedBackCallBackListModel mj_objectWithKeyValues:dic];
                    self.result = YES;
                    self.value = model;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnFeedBackCallListCommand;
}

- (RACCommand *)hnUploadFeedBackImageCommand {
    ByEnergyWeakSekf
    if (!_hnUploadFeedBackImageCommand) {
        _hnUploadFeedBackImageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSArray *fileDatas = input;
            NSMutableArray *filePaths = [NSMutableArray array];
            for (int i=0; i<[fileDatas count]; i++) {
                NSData *fileData = [fileDatas objectAtIndex:i];
                NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg",[SystemUtils getUUID],i];
                NSString *filePath = [SCPhotoUtil getPhotoLocalPathWithFolder:@"PhotoCacheFolder" fileName:fileName];
                [fileData writeToFile:filePath atomically:YES];
                [filePaths addObject:filePath];
            }
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:[NSNumber numberWithInt:2] forKey:@"resultFlag"];
            [params setObject:@"user_feedback" forKey:@"storeName"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestUploadImagesWithURL:NSStringFormat(@"%@api/%@",URL_BASE,UploadFileUrl) params:params.api filePaths:filePaths netWorksModel:self.hnUploadFeedBackImageCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    NSDictionary *result = x;
                    NSArray *idList = [result objectForKey:@"fileIdList"];
                    self.result = YES;
                    self.value = idList;
                }
                
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnUploadFeedBackImageCommand;
}

- (RACCommand *)hnFeedBackAddCommand {
    ByEnergyWeakSekf
    if (!_hnFeedBackAddCommand) {
        _hnFeedBackAddCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            self.hnFeedBackAddCommand.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiFeedbackAddUrl) parameters:params.api responseClass:nil netWorksModel:self.hnFeedBackAddCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    self.value = x;
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnFeedBackAddCommand;
}

@end
