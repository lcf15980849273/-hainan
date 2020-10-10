//
//  ViewController.m
//  ByEnergyCharge
//
//  Created by newyea on 2020/2/22.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "ViewController.h"
#import "AFNetWorkUtils.h"
#import "BEnergyFocusViewModel.h"

@interface ViewController ()
@property (nonatomic, strong) BEnergyFocusViewModel *viewModel;
@end

@implementation ViewController

LCFLazyload(BEnergyFocusViewModel, viewModel)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"____%@",baseUrl)
//    [AFNetWorkUtils HTTPUnCacheWithMethod:MRequestMethodPOST url:NSStringFormat(@"%@appapi/%@",baseUrl,URL_FocusList) parameters:nil callback:^(id responseObject, NSError *error, BOOL isFromCache) {
//        NSLog(@"___%@___%@",responseObject,error);
////    }];
//    [AFNetWorkUtils HTTPUnCacheWithMethod:MRequestMethodPOST url:@"http://112.74.51.178:8432/app_manage/appapi/focusList" parameters:nil callback:^(id responseObject, NSError *error, BOOL isFromCache) {
//        
//    }];
//    LCFLazyload([BEnergyFocusViewModel class], viewModel);
//    [self.viewModel.hnFocusCommand execute:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
