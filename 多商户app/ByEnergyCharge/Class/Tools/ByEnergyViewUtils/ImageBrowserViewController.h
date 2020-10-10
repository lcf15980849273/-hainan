//
//  ImageBrowserViewController.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/18.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "BEnergyBaseViewController.h"
#import "ImageBrowserView.h"

/**
 * 跳转方式
 */
typedef NS_ENUM(NSUInteger,ImageBrowserVCType) {
    
    //modal
    ImageBrowserVCTypePush=0,
    
    //push
    ImageBrowserVCTypeModal,
    
    //zoom
    ImageBrowserVCTypeZoom,
};

@protocol ImageBrowserViewControllerDelegate <NSObject>

@optional

/**
 *  点击底部actionSheet回调,对于图片添加了长按手势的底部功能组件
 *
 *  @param browser 图片浏览器
 *  @param actionSheetindex   点击的actionSheet索引
 *  @param currentImageIndex    当前展示的图片索引
 */
- (void)photoBrowser:(ImageBrowserView *)browser clickActionSheetIndex:(NSInteger)actionSheetindex currentImageIndex:(NSInteger)currentImageIndex;
@end

@interface ImageBrowserViewController : BEnergyBaseViewController

@property (nonatomic, weak) id<ImageBrowserViewControllerDelegate>delegate;

// 隐藏当前显示窗口
-(void)hideScanImageVC:(void (^)(BOOL isFinished))completion;

/**
 *  初始化底部ActionSheet弹框数据 , 不实现此方法,则没有类似微信那种长按手势弹框
 *
 *  @param title                  ActionSheet的title
 *  @param delegate               XLPhotoBrowserDelegate
 *  @param cancelButtonTitle      取消按钮文字
 *  @param deleteButtonTitle      删除按钮文字,如果为nil,不显示删除按钮
 *  @param otherButtonTitles      其他按钮数组
 */
- (void)setActionSheetWithTitle:(NSString *)title delegate:(id<ImageBrowserViewControllerDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle deleteButtonTitle:( NSString *)deleteButtonTitle otherButtonTitles:( NSString *)otherButtonTitle, ... NS_REQUIRES_NIL_TERMINATION;
/**
 *  显示图片
 */
+(void)show:(UIViewController *)handleVC type:(ImageBrowserVCType)type index:(NSUInteger)index imagesBlock:(NSArray *(^)())imagesBlock completion:(void (^)(ImageBrowserViewController *browserVC))completion;

@end
