//
//  Count.m
//  Counter
//
//  Created by Jordan Anderson on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Count.h"

@implementation Count

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _currentCount = 0;
        
    }
    
    return self;
}

- (void) calcCountUp
{
    self.currentCount++;
}

- (void)calcCountDown
{
    if (self.currentCount >= 1)
    {
        self.currentCount--;
    }
    
}


@end
