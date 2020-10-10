//
//  BEnergyStubGroupDetailModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@class Electricrulelist,Stublist,Pricedetails,auxiliaryList;
@interface BEnergyStubGroupDetailModel : BEnergyBaseModel

@property (nonatomic, copy) NSString *totalFeeInfoStr;
@property (nonatomic, copy) NSString *supplier;
@property (nonatomic, assign) NSInteger stubAcUseCnt;
@property (nonatomic, assign) float serviceFee;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSArray<NSString *> *imgUrls;
@property (nonatomic, assign) CGFloat gisGcj02Lat;
@property (nonatomic, assign) NSInteger stubAcBuildingCnt;
@property (nonatomic, assign) NSInteger stubAcErrorCnt;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *serviceTime;
@property (nonatomic, copy) NSString *usablePayType;
@property (nonatomic, assign) NSInteger stubAcIdleCnt;
@property (nonatomic, assign) NSInteger stubDcUseCnt;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger parkingType;
@property (nonatomic, copy) NSString *stubGroupInfo;
@property (nonatomic, assign) CGFloat gisGcj02Lng;
@property (nonatomic, copy) NSString *currentTime;
@property (nonatomic, strong) NSArray<Electricrulelist *> *electricRuleList;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, strong) NSArray<NSNumber *> *feeInfo;
@property (nonatomic, assign) NSInteger stubStoragingCnt;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, assign) float totalFee;
@property (nonatomic, copy) NSString *stubGroupUseStatus;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger stubBuildingCnt;
@property (nonatomic, assign) CGFloat gisBd09Lat;
@property (nonatomic, copy) NSString *cspId;
@property (nonatomic, copy) NSString *parkingInfo;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) NSInteger stubDcBuildingCnt;
@property (nonatomic, assign) CGFloat gisBd09Lng;
@property (nonatomic, assign) NSInteger stubDcIdleCnt;
@property (nonatomic, assign) NSInteger stubDcErrorCnt;
@property (nonatomic, copy) NSString *noticInfo;
@property (nonatomic, copy) NSString *miniImgUrl;
@property (nonatomic, assign) NSInteger parkingFree;
@property (nonatomic, assign) NSInteger stubAcCnt;
@property (nonatomic, assign) NSInteger stubAcOfflineCnt;
@property (nonatomic, assign) NSInteger stubDcCnt;
@property (nonatomic, assign) NSInteger stubDcOfflineCnt;
@property (nonatomic, copy) NSString *parkingFeeInfo;
@property (nonatomic, assign) NSInteger chargeMode;
@property (nonatomic, copy) NSString *serviceType;
@property (nonatomic, strong) NSArray<Stublist *> *stubList;
@property (nonatomic, strong) NSArray<auxiliaryList *> *auxiliaryList;
@property (nonatomic, copy) NSString *totalFeeInfo;
@property (nonatomic, assign) NSInteger stubGroupType;
@property (nonatomic, strong) NSArray<Pricedetails *> *priceDetails;
@property (nonatomic, assign) float electricFee;
@property (nonatomic, assign) NSInteger isBuilded;
@property (nonatomic, assign) CGFloat stubNameHeight;
@property (nonatomic, assign) CGFloat remarkHeight;
@property (nonatomic, assign) CGFloat parkingHeight;
@property (nonatomic, assign) BOOL isOpen;
@end

@interface Electricrulelist : BEnergyBaseModel
@property (nonatomic, copy) NSString *end;
@property (nonatomic, copy) NSString *start;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) float electricFeePrePower;
@property (nonatomic, assign) float serviceFeePrePower;
@property (nonatomic, assign) float fee;
@property (nonatomic, copy) NSString *startTime;
@end

@interface Stublist : BEnergyBaseModel
@property (nonatomic, assign) NSInteger equipmentType;
@property (nonatomic, assign) NSInteger existsGun;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) int chargeSoc;
@property (nonatomic, assign) NSInteger parkingStatus;
@property (nonatomic, copy) NSString *totalFeeInfo;
@property (nonatomic, assign) NSInteger ratedCurrent;
@property (nonatomic, copy) NSString *chargeVoltage;
@property (nonatomic, assign) NSInteger voltageLowerLimit;
@property (nonatomic, copy) NSString *parkingNo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *stubGroupId;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, assign) NSInteger kw;
@property (nonatomic, copy) NSString *strKw;
@property (nonatomic, assign) NSInteger voltageUpperLimit;
@property (nonatomic, assign) NSInteger voltageAuxiliary;
@property (nonatomic, copy) NSString *soc;
@property (nonatomic, copy) NSString *ratedVoltage;
@end

@interface Pricedetails : BEnergyBaseModel
@property (nonatomic, assign) float totalFee;
@property (nonatomic, assign) float serviceFee;
@property (nonatomic, copy) NSString *priceTime;
@property (nonatomic, assign) float electricFee;

@end

@interface auxiliaryList : BEnergyBaseModel
@property(nonatomic, assign)long value;
@property (nonatomic, copy) NSString *name;
@property(nonatomic, assign)long usable;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *imageUseStr;
@property (nonatomic, copy) NSString *imageUnuseStr;
@end
NS_ASSUME_NONNULL_END
