//
//  BDMyShopSectionHeaderView.h
//  bydeal
//
//  Created by chenfeng on 2018/12/25.
//  Copyright © 2018年 BD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDMyShopParamModel.h"
typedef NS_ENUM(NSInteger, BDMyShopTableType) {
    BDMyShopTableTypeOnline = 1, // 上架
    BDMyShopTableTypeWaitOnline = 2, // 待上架
};
@protocol BDMyShopSectionHeaderViewDelegate<NSObject>
- (void)onLineViewTapWithType:(BDMyShopTableType)type;
- (void)waitOnLineViewTapWithType:(BDMyShopTableType)type;
- (void)addressViewTapWithType:(BDMyShopTableType)type;
- (void)typeViewTapWithType:(BDMyShopTableType)type;
- (void)bussinessViewTapWithType:(BDMyShopTableType)type;
- (void)searchViewTapWithType:(BDMyShopTableType)type;

@end
@interface BDMyShopSectionHeaderView : UIView
@property (nonatomic,assign) BDMyShopTableType type;
@property (nonatomic,strong) BDMyShopParamModel *paramModel;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (nonatomic,weak) id<BDMyShopSectionHeaderViewDelegate>delegate;
@end
