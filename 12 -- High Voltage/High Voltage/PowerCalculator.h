//
//  PowerCalculator.h
//  High Voltage
//
//  Created by Jordan Anderson on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    EngeryTypeNone,
    EngeryTypeVolts,
    EngeryTypeAmps,
    EngeryTypeOhms,
    EngeryTypeWatts
}
EngeryType;

@interface PowerCalculator : NSObject

@property(assign) EngeryType energyType;
@property (assign) float *volts;
@property (assign) float *amps;
@property (assign) float *ohms;
@property (assign) float *watts;

+(NSMutableArray *)allEnergyTypes;

- (NSString *)engeryAsString;





@end
