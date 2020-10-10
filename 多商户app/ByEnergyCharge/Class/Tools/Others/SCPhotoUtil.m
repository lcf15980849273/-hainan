
//
//  SCPhotoUtil.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/26.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "SCPhotoUtil.h"
#import "SCImageUtil.h"
#import <AVFoundation/AVFoundation.h>
#import "SCAlertViewUtils.h"
#import <Photos/PHPhotoLibrary.h>
#import "SCPermission.h"

@interface SCPhotoUtil ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
@property (nonatomic) BOOL editEnabled;
@property (nonatomic) CGSize targetSize;
@property (nonatomic) CGFloat compressionQuality;
@property (copy, nonatomic) SCPhotoCompleteBlock completeBlock;

@end

static SCPhotoUtil *sharedInstance = nil;

@implementation SCPhotoUtil

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
}

+ (instancetype)sharedInstance {
    return sharedInstance;
}

+ (NSString *)getPhotoLocalPathWithFolder:(NSString *)folder fileName:(NSString *)fileName {
    if ([fileName length]==0) {
        return @"";
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *folderPath = [cachesDirectory stringByAppendingPathComponent:folder];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    return filePath;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)takePhotoWithEditEnabled:(BOOL)editEnabled
                      targetSize:(CGSize)targetSize
              compressionQuality:(CGFloat)compressionQuality
                       completed:(SCPhotoCompleteBlock)completeBlock {
    self.editEnabled = editEnabled;
    self.targetSize = targetSize;
    self.compressionQuality = compressionQuality;
    self.completeBlock = completeBlock;
    [self takePhoto];
}

- (void)takePhoto {
    //创建UIImagePickerController对象，并设置代理和可编辑
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance]setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAlways];
    }
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.navigationBar.translucent = NO;
    [imagePicker.navigationBar setBackgroundImage:[UIImage imageFromColorMu:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    //创建sheet提示框，提示选择相机还是相册
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //相册选项
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //选择相册时，设置UIImagePickerController对象相关属性
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //跳转到UIImagePickerController控制器弹出相册
        
        [ByEnergyAppWindow.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    //相机选项
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"手机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //选择相机时，设置UIImagePickerController对象相关属性
        [SCPermission authorizedWithType:SCPermissionType_Camera WithResult:^(BOOL granted) {
            if (granted) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
                imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                
                //跳转到UIImagePickerController控制器弹出相机
                
                [ByEnergyAppWindow.rootViewController presentViewController:imagePicker animated:YES completion:nil];
            }
        }];
    }];
    //取消按钮
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [ByEnergyAppWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
        if (@available(iOS 11.0, *)) {
            [[UIScrollView appearance]setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        
    }];
    //添加各个按钮事件
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancel];
    //弹出sheet提示框
    [ByEnergyAppWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance]setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSData *imageData = nil;
    @try {
        UIImage* image = [info objectForKey:self.editEnabled?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage];
        //设置image的尺寸
        CGSize imagesize = self.targetSize;
        //对图片大小进行压缩--
        UIImage *imageNew = [SCImageUtil imageCompressForSize:image targetSize:imagesize];
        imageData = UIImageJPEGRepresentation(imageNew, self.compressionQuality);
    } @catch (NSException *exception) {
        if ([imageData isKindOfClass:[NSNull class]]) {
            imageData = nil;
        }
    } @finally {
        [picker dismissViewControllerAnimated:YES completion:^{
            @try {
                if (self.completeBlock) {
                    self.completeBlock(imageData);
                }
            } @catch (NSException *exception) {
                
            }
        }];
    }
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance]setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}
@end
