//
//  TodoItem.m
//  Todo
//
//  Created by Jordan Anderson on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _taskIsComplete = NO;
    }
    
    return self;
}

- (instancetype)initWithDueDate:(NSDate *)duedate
{
    self = [super init];
    if (self)
    {
        _dueDate = duedate;
    }
    
    return self;
}

- (instancetype)initWithTaskName:(NSString *)taskName dueDate:(NSDate *)dueDate notes:(NSString *)notes localSearch:(MKLocalSearch *)localSearch taskIsComplete:(BOOL)taskIsComplete;
{
    self = [super init];
    if (self)
    {
        _taskName = nil;
        _dueDate = nil;
        _notes = nil;
        _localSearch = nil;
        _taskIsComplete = NO;
    }
    
    return self;
}




@end
