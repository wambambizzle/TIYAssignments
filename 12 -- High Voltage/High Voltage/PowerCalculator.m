//
//  PowerCalculator.m
//  High Voltage
//
//  Created by Jordan Anderson on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "PowerCalculator.h"

@implementation PowerCalculator

+(NSArray *)allEnergyTypes
{
    return  @[@"Volts", @"Amps", @"Ohms", @"Watts"];
}


- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _energy = EngeryTypeNone; // only use _ in init
        
    }
    
    return self;
}

- (NSString *)engeryAsString
{
    NSString *rc;
    
    switch (self.energy)
    {
        case EngeryTypeVolts:
            rc = @"volt";
            break;
        case EngeryTypeAmps:
            rc = @"amps";
            break;
        case EngeryTypeOhms:
            rc = @"ohms";
            break;
        case EngeryTypeWatts:
            rc = @"watts";
            break;
            
        default:
            
            break;
    }

    
    return rc;
}

@end
