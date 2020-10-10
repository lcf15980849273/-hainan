//
//  BEnergyMyInformationViewModel.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/28.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyMyInformationViewModel.h"
#import "SCPhotoUtil.h"
#import "SystemUtils.h"
#import "RACCommand+NetWorks.h"

@implementation BEnergyMyInformationViewModel

- (RACCommand *)hnUploadUserIconCommand {
    ByEnergyWeakSekf
    if (!_hnUploadUserIconCommand) {
        _hnUploadUserIconCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSArray *fileDatas = input;
            NSMutableArray *filePaths = [NSMutableArray array];
            for (int i=0; i<[fileDatas count]; i++) {
                NSData *fileData = [fileDatas objectAtIndex:i];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[SystemUtils getUUID]];
                NSString *filePath = [SCPhotoUtil getPhotoLocalPathWithFolder:@"PhotoCacheFolder" fileName:fileName];
                [fileData writeToFile:filePath atomically:YES];
                [filePaths addObject:filePath];
            }
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:[NSNumber numberWithInt:2] forKey:@"resultFlag"];
            RACSignal *requestSignal = [AFNetWorkUtils RequestUploadImagesWithURL:NSStringFormat(@"%@api/%@",URL_BASE,UploadFileUrl) params:params.api filePaths:filePaths netWorksModel:self.hnUploadUserIconCommand.netWorksModel];
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
    return _hnUploadUserIconCommand;
}


- (RACCommand *)hnEditUserInfoCommand {
    ByEnergyWeakSekf
    if (!_hnEditUserInfoCommand) {
        _hnEditUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            ByEnergyStrongSelf
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:input];
            self.hnEditUserInfoCommand.netWorksModel.isHidenHUD = YES;
            RACSignal *requestSignal = [AFNetWorkUtils RequestPOSTWithURL:URL_API(ApiModifyUrl) parameters:params.api responseClass:[BEnergyUserInfoModel class] netWorksModel:self.hnEditUserInfoCommand.netWorksModel];
            [requestSignal subscribeNext:^(id  _Nullable x) {
                ByEnergyStrongSelf
                self.result = NO;
                if (!byEnergyIsNilOrNull(x)) {
                    self.result = YES;
                    self.value = x;
                    [[BEnergySCUserStorage sharedInstance] saveUserInfo:(BEnergyUserInfoModel *)x];
                }
            } error:^(NSError * _Nullable error) {
                ByEnergyStrongSelf
                self.result = NO;
            }];
            return requestSignal;
        }];
    }
    return _hnEditUserInfoCommand;
}

@end
