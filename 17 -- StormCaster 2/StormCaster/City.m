//
//  City.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "City.h"

@interface City ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation City

- (instancetype)initWithZipCode:(NSString *)zip
{
    self = [super init];
    if (self)
    {
        _zipCode = zip;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipcode:(NSString *)zip
{
    self = [super init];
    if (self)
    {
        _name = name;
        _latitude = lat;
        _longitude = lng;
        _zipCode = zip;
        _coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    
    return self;
}

- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary
{
    BOOL rc = NO;
    if (mapsDictionary)
    {
        NSArray *results = [mapsDictionary objectForKey:@"results"];
        NSDictionary *locationInfo = results[0];
        NSArray *addressComps = [locationInfo objectForKey:@"address_components"];
        NSDictionary *city = addressComps[1];
        NSString *cityName = [city objectForKey:@"long_name"];
        
        self.name = cityName;
        
        NSDictionary *geometry = [locationInfo objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        self.latitude = [[location objectForKey:@"lat"] doubleValue];
        self.longitude = [[location objectForKey:@"lng"] doubleValue];
        
        self.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        
        rc = YES;
    }
    
    return rc;
}


- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return [self.currentWeather currentTemperature];
}

- (CLLocationCoordinate2D)coordinate
{
    return _coordinate; // if override a getter/setter must you "_" for instance variable
}

- (MKMapItem *)mapItem
{
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.name;
    
    return mapItem;
    
}

#pragma mark - NSCoding

#define kNameKey @"name"
#define klatitudeKey @"latitude"
#define klongitudeKey @"longitude"
#define kZipCodeKey @"zipCode"

- (void)encodeWithCoder:(NSCoder *)aCoder //aka saving the data
{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeDouble:self.latitude forKey:klatitudeKey];
    [aCoder encodeDouble:self.longitude forKey:klongitudeKey];
    [aCoder encodeObject:self.zipCode forKey:kZipCodeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *cityName = [aDecoder decodeObjectForKey:kNameKey];
    double latitude = [aDecoder decodeDoubleForKey:klatitudeKey];
    double longitude = [aDecoder decodeDoubleForKey:klongitudeKey];
    NSString *zipCode = [aDecoder decodeObjectForKey:kZipCodeKey];
   return [self initWithName:cityName latitude:latitude longitude:longitude andZipcode:zipCode]; //create and then return a City object
}





























@end