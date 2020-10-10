//
//  Created by Ole Gammelgaard Poulsen on 05/12/13.
//  Copyright (c) 2012 SHAPE A/S. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SubscribeViewModel;


@interface SubscribeViewController : UIViewController

/*选择城市*/
- (void)selectAddressWithType:(NSString *)type;
/*选择身份行业*/
- (void)selectIndutryOrIdentifyWithType:(NSString *)type;

- (void)handleSaveButtonTaped;
/*选择照片*/
- (void)choosePictureWithUploadIdentityStyle;
/*选择性别*/
- (void)showSheetStylePickerViewWithLastText:(NSString *)text;
@end
