//
//  CoreGraphicsViewController.m
//  byCF
//
//  Created by newyea on 2020/4/7.
//  Copyright © 2020 刘辰峰. All rights reserved.
//

#import "CoreGraphicsViewController.h"
#import "coreGraphicsCustomView.h"
@interface CoreGraphicsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tImageView;
@property (nonatomic, strong) coreGraphicsCustomView *customView;
@end

@implementation CoreGraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    [self.view addSubview:self.customView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获得普通图片
    UIImage *image = [UIImage imageNamed:@"touxiang"];
#pragma mark ----------------------------------------
    // 调用 方法将普通图片转换为灰白图片
    UIImage *grayImage = [self grayImage:image];
#pragma mark ----------------------------------------
    // 根据图片宽度进行等比缩放适应屏幕的宽度
    self.tImageView.image = grayImage;
    self.tImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
}

- (void)selectedProvince:(NSString *)pro AndCity:(NSString *)city AndArea:(NSString *)area withAllName:(NSString *)rea {
    
}

- (void)setupNaviWithTintColor:(UIColor *)color backgroundImage:(UIImage *)image statusBarstyle:(UIStatusBarStyle)style attributes:(NSDictionary *)attributes {
    
}

- (UIImage *)grayImage:(UIImage *)image{

    int width  = image.size.width;
    int height = image.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();

    CGContextRef context = CGBitmapContextCreate(nil,
                                                 width,
                                                 height,
                                                 8, // bits per component
                                                 0,
                                                 colorSpace,
                                                 kCGBitmapByteOrderDefault);

    CGColorSpaceRelease(colorSpace);

    if (context == NULL) {

        return nil;
    }

    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), image.CGImage);
    CGImageRef imageRef   = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    CGContextRelease(context);

    return grayImage;
}

#pragma mark ----- LazyLoad

- (coreGraphicsCustomView *)customView {
    if (!_customView) {
        _customView = [[coreGraphicsCustomView alloc] initWithFrame:CGRectMake(0,100, SCREENWIDTH, 500)];
        _customView.backgroundColor = [UIColor grayColor];
    }
    return _customView;
}
@end
