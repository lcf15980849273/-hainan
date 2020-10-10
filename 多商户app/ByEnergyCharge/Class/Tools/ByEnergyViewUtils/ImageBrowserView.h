//
//  ImageBrowserView.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/18.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageBrowserViewDelegate <NSObject>

@optional

- (void)handleLongPressGestureToPhotoView:(UIView *)browserView;

/**
 *  点击图片时，隐藏图片浏览器
 */
-(void)tapHiddenPhotoView;

@end

@interface ImageBrowserView : UIView

/** 父视图 */
@property(nonatomic,strong)  UIScrollView *scrollView;

/** 图片视图 */
@property(nonatomic, strong) UIImageView *imageView;

/** 代理 */
@property(nonatomic, weak) id<ImageBrowserViewDelegate> delegate;

@property(nonatomic, assign) BOOL hasShowedFistView;

//保存图片到本地
- (void)saveImage;

/**
 *  传图片Url
 */
-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl withHasShowedFistView:(BOOL)hasShowedFistView;

/**
 *  传具体图片
 */
-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image withHasShowedFistView:(BOOL)hasShowedFistView;

@end
