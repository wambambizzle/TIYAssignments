//
//  PinDrop.h
//  DropIt
//
//  Created by Jordan Anderson on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;


@interface PinDrop : NSObject <MKAnnotation>

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

- (instancetype)initWithCoorindate:(CLLocationCoordinate2D)coordinate;

- (CLLocationCoordinate2D)coordinate;


@end
