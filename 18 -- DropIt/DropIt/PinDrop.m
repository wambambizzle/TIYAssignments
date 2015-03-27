//
//  PinDrop.m
//  DropIt
//
//  Created by Jordan Anderson on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "PinDrop.h"

@interface PinDrop ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation PinDrop


- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate name:(NSString *)name
{
    if (self)
    {
        self = [super init];
        _coordinate = coordinate;
        _name = name;
    }
    return self;
}


- (CLLocationCoordinate2D)coordinate
{
    return _coordinate; // if override a getter/setter must you "_" for instance variable
}

- (MKMapItem *)mapItem
{
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//    mapItem.name = self.name;
    
    return mapItem;
}


- (NSString *)title
{
    return self.name;
}

#pragma mark - NSCoding

#define kNameKey @"name"
#define klatitudeKey @"latitude"
#define klongitudeKey @"longitude"

- (void)encodeWithCoder:(NSCoder *)aCoder //aka saving the data
{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeDouble:self.coordinate.latitude forKey:klatitudeKey];
    [aCoder encodeDouble:self.coordinate.longitude forKey:klongitudeKey];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *name = [aDecoder decodeObjectForKey:kNameKey];
    double lat = [aDecoder decodeDoubleForKey:klatitudeKey];
    double lng = [aDecoder decodeDoubleForKey:klongitudeKey];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lng);
    return [self initWithCoordinate:coordinate name:name];
}

@end
