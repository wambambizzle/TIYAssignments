//
//  Location.m
//  DropIt
//
//  Created by Jordan Anderson on 5/26/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Location.h"


@interface Location ()

@end

@implementation Location

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

#pragma mark -- NSCoding

#define kNameKey @"name"
#define kLatitudeKey @"latitude"
#define kLongitudekey @"longitude"

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeDouble:self.coordinate.latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:self.coordinate.longitude forKey:kLongitudekey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *name = [aDecoder decodeObjectForKey:kNameKey];
    double latitude = [aDecoder decodeDoubleForKey:kLatitudeKey];
    double longitude = [aDecoder decodeDoubleForKey:kLongitudekey];
    
    return [self initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) userPinDescription:name];
}

@end


