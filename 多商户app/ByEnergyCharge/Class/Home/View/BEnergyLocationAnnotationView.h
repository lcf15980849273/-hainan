//
//  BEnergyLocationAnnotationView.h
//  ByEnergyCharge
//
//  Created by newyea on 2018/12/6.
//  Copyright © 2018年 newyea. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "BEnergyBasicMapAnnotation.h"
#import "BEnergyStubGroupModel.h"
@interface BEnergyLocationAnnotationView : MAAnnotationView
@property (nonatomic, strong) BEnergyStubGroupModel *stubGroupModel;
+ (instancetype)annotationViewWithMapView:(MAMapView *)mapView;

@end
