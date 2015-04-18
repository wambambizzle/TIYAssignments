//
//  CurrentRates.m
//  Coinless
//
//  Created by Jordan Anderson on 4/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CurrentRates.h"

@implementation CurrentRates

- (instancetype)initWithRate:(NSString *)rate code:(NSString *)code symbol:(NSString *)symbol
{
    self = [super init];
    if (self)
    {
        _rate = rate;
        _code = code;
        _symbol = symbol;
        
    }
    
    return self;
}

@end
