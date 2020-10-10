//
//  imagePicker.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/10/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
NS_ASSUME_NONNULL_BEGIN

@protocol ImagePickerDelegate <NSObject>

- (void)imagePickerCanceled;
- (void)imagePickerSuccessed:(UIImage *)image format:(NSString *)format;
@end

@interface ImagePicker : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, weak) id<ImagePickerDelegate> delegate;
@property NSString *format;
@property(nonatomic, strong) ALAssetsLibrary *library;
@property(nonatomic, strong) UIViewController *viewController;
@property (nonatomic, assign) UIImagePickerControllerCameraDevice cameraDevice;
+ (ImagePicker *)instance;

/*弹出拍照、相册、取消操作选择*/
+ (void)pickImage:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController*)viewController;

/*直接调用相机*/
+ (void)pickImageFromPhoto:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController*)viewController;

/*直接调用相册*/
+ (void)pickImageFromAlbum:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
