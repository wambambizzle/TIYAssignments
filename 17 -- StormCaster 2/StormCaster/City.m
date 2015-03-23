//
//  City.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "City.h"

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
        rc = YES;
    }
    
    return rc;
}

@end