//
//  imagePicker.m
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/10/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ImagePicker.h"
#import "SheetStylePickerView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <MediaPlayer/MediaPlayer.h>

static  ImagePicker *imPicker = nil;
@implementation ImagePicker

+ (ImagePicker *)instance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
        
    });
    return _sharedObject;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

#pragma mark - 弹出拍照、相册、取消操作选择
+ (void)pickImage:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController *)viewController {
    if (imPicker == nil) {
        imPicker = [[ImagePicker alloc]init];
    }
    [imPicker pickImage:delegate inViewController:viewController];
}

- (void)pickImage:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController *)viewController {
    _delegate = delegate;
    _viewController = viewController;
    [self showActionSheet];
}

#pragma mark - 直接调用相机
+ (void)pickImageFromPhoto:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController *)viewController {
    if (imPicker == nil) {
        imPicker = [[ImagePicker alloc]init];
    }
    [imPicker pickImageFromPhoto:delegate inViewController:viewController];
}

- (void)pickImageFromPhoto:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController *)viewController {
    
    _delegate = delegate;
    _viewController = viewController;
    [self actionSheetShowClickButtonAtIndex:0];
}

#pragma mark - 直接调用相册
+ (void)pickImageFromAlbum:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController *)viewController {
    if (imPicker == nil) {
        imPicker = [[ImagePicker alloc]init];
    }
    [imPicker pickImageFromAlbum:delegate inViewController:viewController];
}

- (void)pickImageFromAlbum:(id<ImagePickerDelegate>)delegate inViewController:(UIViewController *)viewController {
    _delegate = delegate;
    _viewController = viewController;
    [self actionSheetShowClickButtonAtIndex:1];
}


- (void)showActionSheet {
//    weakify(self);
    SheetStylePickerView *sheetStylePickerView = [[SheetStylePickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREENWIDTH, SCREENHEIGHT)];
    sheetStylePickerView.textAlignment = NSTextAlignmentCenter;
    sheetStylePickerView.titles = @[@"拍照", @"相册",@"取消"];
    sheetStylePickerView.DidSelectedRowBlock = ^(NSString *title, long index) {
//        strongify(self);
        [self actionSheetShowClickButtonAtIndex:index];
    };
}

- (void)actionSheetShowClickButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    if (buttonIndex == 0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied) {
            return;
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isCameraDeviceAvailable:self.cameraDevice]) {
                imagePickerController.cameraDevice = self.cameraDevice;
            }
            imagePickerController.delegate = self;
            // 推出拍照选择器
            [_viewController presentViewController:imagePickerController animated:YES completion:nil];
        } else {
//            [MBProgressHUD showError:@"该设备不支持相机"];
        }
    }
    else if (buttonIndex == 1) {
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        if (authStatus == PHAuthorizationStatusDenied) {
            return;
        }
        // 判断是否能访问
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.delegate = self;
            [_viewController presentViewController:imagePickerController animated:YES completion:nil];
        }else{
//            [MBProgressHUD showError:@"该设备不支持相机"];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(imagePickerCanceled)]) {
            [_delegate imagePickerCanceled];
        }
    }
}

#pragma mark - 图像选择器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:NO completion:nil];//关闭picker
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage* img = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.format = @"jpg";
        [self imageSelected:img format:self.format];
    } else {
        if (self.library == nil) {//图库
            self.library = [[ALAssetsLibrary alloc] init];
        }
        NSURL *assetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        [self.library assetForURL:assetURL
                      resultBlock:^(ALAsset *asset) {
                          UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
                          self.format = [[assetURL pathExtension] lowercaseString];
                          [self imageSelected:img format:self.format];
                      } failureBlock:^(NSError *error) {
                          if ([self.delegate respondsToSelector:@selector(imagePickerCanceled)]) {
                              [self.delegate imagePickerCanceled];
                          }
                          imPicker = nil;
                      }];
    }
}

- (void)imageSelected:(UIImage *)image format:(NSString *)format {
    [_delegate imagePickerSuccessed:image format:(NSString *)format];
    imPicker = nil;// 释放内存
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([_delegate respondsToSelector:@selector(imagePickerCanceled)]) {
        [_delegate imagePickerCanceled];
    }
    imPicker = nil;// 释放内存
}

@end
