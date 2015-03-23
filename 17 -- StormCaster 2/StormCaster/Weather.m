//
//  Weather.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Weather.h"

#import "StormCasterTableViewController.h"

@implementation Weather
{
    NSMutableData *receivedData;
}


- (BOOL)parseWeatherInfo:(NSDictionary *)infoDictionary
{
    BOOL rc = NO;
    if (infoDictionary)
    {
        NSDictionary *currently = [infoDictionary objectForKey:@"currently"];
        self.temperature = [[currently objectForKey:@"temperature"] doubleValue];
        self.apparentTemperature = [[currently objectForKey:@"apparentTemperature"] doubleValue];
        self.summary = [currently objectForKey:@"summary"];
        
        NSDictionary *minutely = [infoDictionary objectForKey:@"minutely"];
        self.icon = [minutely objectForKey:@"icon"];
        rc = YES;
    }
    
    return rc;
    
}


- (NSString *)currentTemperature
{
    return [NSString stringWithFormat:@"%.0f℉", self.temperature];
}

- (NSString *)feelsLikeTemperature
{
    return [NSString stringWithFormat:@"%.0f℉", self.apparentTemperature];
}

- (NSString *)dewPointTemperature
{
    return [NSString stringWithFormat:@"%.0f", self.dewPoint];
}

- (NSString *)humidityPercentage
{
    return [NSString stringWithFormat:@"%.0f", self.humidity];
}

- (NSString *)chanceOfRain
{
    return [NSString stringWithFormat:@"%.0f", self.precipProbability];
}

- (NSString *)windSpeedMPH
{
    return [NSString stringWithFormat:@"%.0f MPH", self.windSpeed];
}


@end
