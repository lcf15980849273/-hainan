//
//  BEnergyStubDetailInfoCell.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/4/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEnergyCellProtocol.h"
@class Stublist,SocProgressMode;
NS_ASSUME_NONNULL_BEGIN
static NSString *const kBEnergyStubDetailInfoCell = @"BEnergyStubDetailInfoCell";
@interface BEnergyStubDetailInfoCell : UITableViewCell<BEnergyCellProtocol>
@property (nonatomic, assign) BOOL showLine;
@property (nonatomic, strong) Stublist *stubListModel;
@end


@interface SocProgressModel : NSObject
@property (nonatomic, assign) NSTimeInterval frequence;//请求频率
@property (nonatomic, strong) NSArray <Stublist *> *stubList;
@end
NS_ASSUME_NONNULL_END
