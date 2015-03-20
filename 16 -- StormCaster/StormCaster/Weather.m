//
//  Weather.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _weatherCity = nil;
        _weatherState = nil;
        _weatherLat = nil;
        _weatherLong = nil;
        _weatherTemp = nil;
    }
    
    return self;
}

@end
