//
//  MapObject.h
//  VenueMenu
//
//  Created by Jordan Anderson on 4/6/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface MapObject : NSObject <MKAnnotation>


@property (strong, nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;


- (instancetype)initWithCoordinate:(CLLocationCoordinate2D ) coordinate userPinDescription:(NSString *)name;

@end
