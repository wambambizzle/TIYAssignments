//
//  MapObject.m
//  VenueMenu
//
//  Created by Jordan Anderson on 4/6/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "MapObject.h"

@implementation MapObject


- (instancetype)initWithCoordinate:(CLLocationCoordinate2D )coordinate userPinDescription:(NSString *)name
{
    if (self) {
        self = [super init];
        
        _coordinate = coordinate;
        _name = name;
        
    }
    return self;
}


- (NSString *)title
{
    return self.name;
}


@end
