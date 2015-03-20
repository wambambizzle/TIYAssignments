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

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _weatherCity = nil;
        _weatherSummary = nil;
        _weatherLat = nil;
        _weatherLng = nil;
        _weatherTemp = nil;
        _apparentTemp = nil;
    }
    
    return self;
}
   

-(void)updateWeather
{
    NSString *apiKey = @"2098819493d38893c26eca401b88ecfe";
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%@,%@", apiKey,self.weatherLat, self.weatherLng];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
    
}


#pragma mark - NSURLSession delegate

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}


- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData appendData:data];
    }
}

- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        NSLog(@"Download Successful.");
        
        NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        
        NSDictionary *currently = [userInfo objectForKey:@"currently"];
        self.weatherSummary = [currently objectForKey:@"temperature"];
        self.apparentTemp = [currently objectForKey:@"apparentTemperature"];
        
        
    }
}


@end
