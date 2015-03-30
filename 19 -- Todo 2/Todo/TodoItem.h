//
//  TodoItem.h
//  Todo
//
//  Created by Jordan Anderson on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface TodoItem : NSObject

@property(strong, nonatomic) NSString *taskName;
@property(strong, nonatomic) NSDate *dueDate;
@property(strong, nonatomic) NSString *notes;
@property(strong, nonatomic) MKLocalSearch *localSearch;
@property (assign) BOOL taskIsComplete;
@property(strong, nonatomic) MKMapItem *mapItem;
@property(strong, nonatomic) NSString *addressName;
@property(strong, nonatomic) NSString *addressStreet;

- (instancetype)init;

- (instancetype)initWithDueDate:(NSDate *)duedate;

- (instancetype)initWithTaskName:(NSString *)taskName dueDate:(NSDate *)dueDate notes:(NSString *)notes localSearch:(MKLocalSearch *)localSearch taskIsComplete:(BOOL)taskIsComplete;


@end
