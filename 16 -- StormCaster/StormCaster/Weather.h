//
//  Weather.h
//  StormCaster
//
//  Created by Jordan Anderson on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject <NSURLSessionDataDelegate>

@property (assign) NSString *city;


@property (assign) NSString *weatherLat;
@property (assign) NSString *weatherLng;

@property (assign) NSString *weatherTemp; //@property (assign) double temperature;
@property (assign) NSString *apparentTemp;
@property (strong, nonatomic) NSString *weatherSummary;
@property (strong, nonatomic) NSString *icon;

//- (NSString *)weatherTemp;

//-(BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary;

- (void)updateWeather;

@end
