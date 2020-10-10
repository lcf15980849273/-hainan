//
//  UIImage+byEnergyCompression.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/9/21.
//  Copyright © 2020 newyea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (byEnergyCompression)
- (void)byEnergyCompressWithMaxKB:(NSUInteger)maxLengthKB
                          image:(UIImage *)image
                         Block :(void (^)(NSData *imageData))block;
@end

NS_ASSUME_NONNULL_END
