//
//  CFButton.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/10/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, BDButtonObserveType) {
    BDButtonObserveTypeNone,
    BDButtonObserveTypeRCMessage,
    BDButtonObserveTypeShoppingCart,
    BDButtonObserveTypeCustomeService,
};


// 图文排版
typedef NS_ENUM(NSInteger, BDButtonAlignment) {
    BDButtonAlignmentNone, /**< 默认 */
    BDButtonAlignmentVerticalImageTop, /**< 图片居上，文字居下【contentVerticalAlignment 调整整体位置】【contentEdgeInsets 调整边距】 */
    BDButtonAlignmentVerticalImageBottom, /**< 图片居下，文字居上【contentVerticalAlignment 调整整体位置】【contentEdgeInsets 调整边距】 */
    BDButtonAlignmentHorizontalImageRight, /**< 图片居右，文字居左【contentHorizontalAlignment 调整整体位置】【contentEdgeInsets 调整边距】 */
    BDButtonAlignmentHorizontalImageLeft, /**< 图片居左，文字居右【contentHorizontalAlignment 调整整体位置】【contentEdgeInsets 调整边距】 */
};
@interface CFButton : UIButton

// 图文排版 default BDButtonAlignmentVerticalCenter
@property (nonatomic, assign) BDButtonAlignment alignment;

// 文字和图片的间距
@property (nonatomic, assign) CGFloat titleImageSpacing;

@property (nonatomic,copy) void(^buttonDidClickOperation) (CFButton *button);

- (void)setTitle:(NSString *)title;
- (void)setImageName:(NSString *)imageName;
- (void)setSelectTitle:(NSString *)title;

- (void)byEnergyInitSubView;

@end

NS_ASSUME_NONNULL_END
