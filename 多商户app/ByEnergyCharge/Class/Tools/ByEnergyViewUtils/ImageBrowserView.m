//
//  ImageBrowserView.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/18.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "ImageBrowserView.h"
#import <SDWebImageManager.h>
#import "SCPermission.h"
#import <Photos/PHPhotoLibrary.h>
#import "SCAlertViewUtils.h"
//#import "UIImageView+WebCache.h"
//#import <MBProgressHUD.h>

// 图片保存成功提示文字
#define SDPhotoBrowserSaveImageSuccessText @"保存成功";

// 图片保存失败提示文字
#define SDPhotoBrowserSaveImageFailText @"保存失败";

@interface ImageBrowserView ()<UIScrollViewDelegate>{
    
    
}

/**
 *   保存图片的过程指示菊花
 */
@property (nonatomic , strong) UIActivityIndicatorView  *indicatorView;
@property (nonatomic , strong) MBProgressHUD *hud;
@end

@implementation ImageBrowserView
-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl withHasShowedFistView:(BOOL)hasShowedFistView{
    self = [super initWithFrame:frame];
    if (self) {
        kWeakSelf(self);
        self.hasShowedFistView = hasShowedFistView;
        //添加图片
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [self cachedImageExistsForManager:manager URL:[NSURL URLWithString:photoUrl] completion:^(BOOL isInCache) {
            if (!isInCache) {//没有缓存
                weakself.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
                weakself.hud.mode = MBProgressHUDModeDeterminate;
                
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:[UIImage imageNamed:@"no_image"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                    weakself.hud.progress = ((float)receivedSize)/expectedSize;
                } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    CGRect targetTemp = [weakself caculateOriginImageSizeWith:image];
                    if (!weakself.hasShowedFistView) {
                        weakself.imageView.center = ByEnergyAppWindow.center;
                        [UIView animateWithDuration:0.3f animations:^{
                            weakself.imageView.bounds = (CGRect){CGPointZero, targetTemp.size};
                        } completion:^(BOOL finished) {
                        }];
                    }else{
                        self.imageView.frame = targetTemp;
                    }
                    NSLog(@"图片加载完成");
                    if (!isInCache) {
                        [weakself.hud hideAnimated:YES];
                    }
                }];
                
            }else{//直接取出缓存的图片，减少流量消耗
                UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:photoUrl];
                CGRect targetTemp = [self caculateOriginImageSizeWith:cachedImage];
                if (!weakself.hasShowedFistView) {
                    weakself.imageView.center = ByEnergyAppWindow.center;
                    [UIView animateWithDuration:0.3f animations:^{
                        weakself.imageView.bounds = (CGRect){CGPointZero, targetTemp.size};
                    } completion:^(BOOL finished) {
                    }];
                }else{
                    weakself.imageView.frame = targetTemp;
                }
                weakself.imageView.image=cachedImage;
            }
        }];
        
    }
    return self;
}

- (void)cachedImageExistsForManager:(SDWebImageManager *)manager URL:(nullable NSURL *)url
                         completion:(nullable void(^)(BOOL isInCache))completionBlock {
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    
    BOOL isInMemoryCache = ([[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:key] != nil);
    
    if (isInMemoryCache) {
        // making sure we call the completion block on the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(YES);
            }
        });
        return;
    }
    
    [[SDImageCache sharedImageCache] diskImageExistsWithKey:key completion:^(BOOL isInDiskCache) {
        // the completion block of checkDiskCacheForImageWithKey:completion: is always called on the main queue, no need to further dispatch
        if (completionBlock) {
            completionBlock(isInDiskCache);
        }
    }];
}

-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image withHasShowedFistView:(BOOL)hasShowedFistView{
    self = [super initWithFrame:frame];
    if (self) {
        //添加图片
        self.imageView.frame=[self caculateOriginImageSizeWith:image];
        [self.imageView setImage:image];
        
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
/**scroll view处理缩放和平移手势，必须需要实现委托下面两个方法,另外 maximumZoomScale和minimumZoomScale两个属性要不一样*/

//1.返回要缩放的图片
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

//让图片保持在屏幕中央，防止图片放大时，位置出现跑偏
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (_scrollView.bounds.size.width > _scrollView.contentSize.width)?(_scrollView.bounds.size.width - _scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (_scrollView.bounds.size.height > _scrollView.contentSize.height)?
    (_scrollView.bounds.size.height - _scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX,_scrollView.contentSize.height * 0.5 + offsetY);
}

//2.重新确定缩放完后的缩放倍数
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}


#pragma mark - 图片的点击，touch事件
//单击
-(void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.numberOfTapsRequired == 1) {
        [self.delegate tapHiddenPhotoView];
    }
}

//双击
-(void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.numberOfTapsRequired == 2) {
        if(_scrollView.zoomScale == 1){
            float newScale = [_scrollView zoomScale] *2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }else{
            float newScale = [_scrollView zoomScale]/2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [_scrollView zoomToRect:zoomRect animated:YES];
        }
    }
}

//长按
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(handleLongPressGestureToPhotoView:)]) {
            [_delegate handleLongPressGestureToPhotoView:self];
        }
    }
}

//2手指操作
-(void)handleTwoFingerTap:(UITapGestureRecognizer *)gestureRecongnizer{
    float newScale = [_scrollView zoomScale]/2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecongnizer locationInView:gestureRecongnizer.view]];
    [_scrollView zoomToRect:zoomRect animated:YES];
}


#pragma mark - 缩放大小获取方法
-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    //大小
    zoomRect.size.height = [_scrollView frame].size.height/scale;
    zoomRect.size.width = [_scrollView frame].size.width/scale;
    //原点
    zoomRect.origin.x = center.x - zoomRect.size.width/2;
    zoomRect.origin.y = center.y - zoomRect.size.height/2;
    return zoomRect;
}

#pragma mark - 懒加载
-(UIScrollView *)scrollView{
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 3;
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        [_scrollView setZoomScale:1];
        
        //添加scrollView
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIImageView *)imageView{
    
    if (_imageView==nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled=YES;
        
        //添加手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
        
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        doubleTap.numberOfTapsRequired = 2;//需要点两下
        twoFingerTap.numberOfTouchesRequired = 2;//需要两个手指touch
        
        [_imageView addGestureRecognizer:singleTap];
        [_imageView addGestureRecognizer:doubleTap];
        [_imageView addGestureRecognizer:twoFingerTap];
        [_imageView addGestureRecognizer:longPressGesture];
        [singleTap requireGestureRecognizerToFail:doubleTap];//如果双击了，则不响应单击事件
        
        [self.scrollView addSubview:_imageView];
    }
    return _imageView;
}

#pragma mark - 计算图片原始高度，用于高度自适应
-(CGRect)caculateOriginImageSizeWith:(UIImage *)image{
    
    CGFloat originImageHeight=[self imageCompressForWidth:image targetWidth:SCREENWIDTH].size.height;
    if (originImageHeight>=SCREENHEIGHT) {
        originImageHeight=SCREENHEIGHT;
    }
    
    CGRect frame=CGRectMake(0, (SCREENHEIGHT-originImageHeight)*0.5, SCREENWIDTH, originImageHeight);
    
    return frame;
}

/**指定宽度按比例缩放图片*/
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark    -   private -- save image

- (void)saveImage
{
    kWeakSelf(self);
    [SCPermission authorizedWithType:SCPermissionType_Photos WithResult:^(BOOL granted) {
        if (granted) {
            UIImageWriteToSavedPhotosAlbum(weakself.imageView.image, weakself, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [self.indicatorView removeFromSuperview];
    NSString *showText = nil;
    if (error) {
        showText = SDPhotoBrowserSaveImageFailText;
        [HUDManager showStateHud:showText state:HUDStateTypeFail];
    }   else {
        showText = SDPhotoBrowserSaveImageSuccessText;
        [HUDManager showStateHud:showText state:HUDStateTypeSuccess];
    }
}

@end
