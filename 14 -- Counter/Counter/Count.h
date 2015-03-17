//
//  Count.h
//  Counter
//
//  Created by Jordan Anderson on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Count : NSObject

@property(strong, nonatomic) NSString *name;


@property(assign) NSInteger currentCount;

- (void) calcCountUp;
- (void) calcCountDown;

@end
