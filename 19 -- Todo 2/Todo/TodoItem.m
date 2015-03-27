//
//  TodoItem.m
//  Todo
//
//  Created by Jordan Anderson on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem


- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _taskIsComplete = NO;
    }
    
    return self;
}




@end
