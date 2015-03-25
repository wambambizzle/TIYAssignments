//
//  PowerCalculator.m
//  High Voltage
//
//  Created by Jordan Anderson on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "PowerCalculator.h"

@implementation PowerCalculator

+(NSMutableArray *)allEnergyTypes
{
    
    return  [[NSMutableArray alloc] initWithObjects:@"Volts", @"Amps", @"Ohms", @"Watts", nil];
   
}


- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _energyType = EngeryTypeNone; // only use _ in init
        _volts = 0;
        _amps = 0;
        _ohms = 0;
        _watts = 0;
    }
    
    return self;
}

- (NSString *)engeryAsString
{
    NSString *rc;
    
    switch (self.energyType)
    {
        case EngeryTypeVolts:
            if (self.amps && self.ohms)
            {
                
            }
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
