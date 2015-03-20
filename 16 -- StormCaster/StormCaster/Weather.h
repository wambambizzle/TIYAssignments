//
//  Weather.h
//  StormCaster
//
//  Created by Jordan Anderson on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject <NSURLSessionDataDelegate>

@property (strong, nonatomic) NSString *weatherCity;


@property (strong, nonatomic) NSString *weatherLat;
@property (strong, nonatomic) NSString *weatherLng;

@property (strong, nonatomic) NSString *weatherTemp;
@property (strong, nonatomic) NSString *weatherSummary;
@property (strong, nonatomic) NSString *apparentTemp;


-(void)updateWeather;

@end
