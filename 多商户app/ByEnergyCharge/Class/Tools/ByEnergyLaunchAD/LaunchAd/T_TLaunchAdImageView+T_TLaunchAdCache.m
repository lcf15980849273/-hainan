//
//  T_TLaunchAdImageView+T_TLaunchAdCache.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/4/18.
//  Copyright © 2018年 隔壁老王. All rights reserved.
//

#import "T_TLaunchAdImageView+T_TLaunchAdCache.h"
#import "FLAnimatedImage.h"
#import "T_TLaunchAdConst.h"

@implementation T_TLaunchAdImageView (T_TLaunchAdCache)
- (void)tt_setImageWithURL:(nonnull NSURL *)url{
    [self tt_setImageWithURL:url placeholderImage:nil];
}

- (void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder{
    [self tt_setImageWithURL:url placeholderImage:placeholder options:T_TLaunchAdImageDefault];
}

-(void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(T_TLaunchAdImageOptions)options{
    [self tt_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)tt_setImageWithURL:(nonnull NSURL *)url completed:(nullable T_TExternalCompletionBlock)completedBlock {
    
    [self tt_setImageWithURL:url placeholderImage:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable T_TExternalCompletionBlock)completedBlock{
    [self tt_setImageWithURL:url placeholderImage:placeholder options:T_TLaunchAdImageDefault completed:completedBlock];
}

-(void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(T_TLaunchAdImageOptions)options completed:(nullable T_TExternalCompletionBlock)completedBlock{
    [self tt_setImageWithURL:url placeholderImage:placeholder GIFImageCycleOnce:NO options:options GIFImageCycleOnceFinish:nil completed:completedBlock ];
}

- (void)tt_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder GIFImageCycleOnce:(BOOL)GIFImageCycleOnce options:(T_TLaunchAdImageOptions)options GIFImageCycleOnceFinish:(void(^_Nullable)(void))cycleOnceFinishBlock completed:(nullable T_TExternalCompletionBlock)completedBlock {
    if(placeholder) self.image = placeholder;
    if(!url) return;
    T_TWeakSelf
    [[T_TLaunchAdImageManager sharedManager] loadImageWithURL:url options:options progress:nil completed:^(UIImage * _Nullable image,  NSData *_Nullable imageData, NSError * _Nullable error, NSURL * _Nullable imageURL) {
        if(!error){
            if(T_TISGIFTypeWithData(imageData)){
                weakSelf.image = nil;
                weakSelf.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
                weakSelf.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
                    if(GIFImageCycleOnce){
                        [weakSelf stopAnimating];
                        T_TLaunchAdLog(@"GIF不循环,播放完成");
                        if(cycleOnceFinishBlock) cycleOnceFinishBlock();
                    }
                };
            }else{
                weakSelf.image = image;
                weakSelf.animatedImage = nil;
            }
        }
        if(completedBlock) completedBlock(image,imageData,error,imageURL);
    }];
}

@end

