//
//  BEnergyBasicMapAnnotation.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/5.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEnergyAnnotationModel.h"

@interface BEnergyBasicMapAnnotation : NSObject<MAAnnotation> {
    CLLocationDegrees _latitude;
    CLLocationDegrees _longitude;
}

@property (nonatomic, strong) BEnergyAnnotationModel *model;

- (id)initWithLatitude:(CLLocationDegrees)latitude
          andLongitude:(CLLocationDegrees)longitude;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;


@end
