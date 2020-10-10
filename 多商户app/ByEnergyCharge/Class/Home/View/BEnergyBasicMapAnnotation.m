//
//  BEnergyBasicMapAnnotation.m
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/5.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import "BEnergyBasicMapAnnotation.h"

@interface BEnergyBasicMapAnnotation()

@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;

@end

@implementation BEnergyBasicMapAnnotation

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

- (id)initWithLatitude:(CLLocationDegrees)latitude
          andLongitude:(CLLocationDegrees)longitude {
    if (self = [super init]) {
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    self.latitude = newCoordinate.latitude;
    self.longitude = newCoordinate.longitude;
}
@end
