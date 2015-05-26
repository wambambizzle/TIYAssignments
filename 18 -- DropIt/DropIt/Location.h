//
//  Location.h
//  DropIt
//
//  Created by Jordan Anderson on 5/26/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;



@interface Location : NSObject <MKAnnotation, NSCoding>




@property (strong, nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;



- (instancetype)initWithCoordinate:(CLLocationCoordinate2D ) coordinate userPinDescription:(NSString *)name;



@end
