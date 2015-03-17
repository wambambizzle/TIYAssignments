//
//  TodoItem.h
//  Todo
//
//  Created by Jordan Anderson on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject

@property(strong, nonatomic) NSString *taskName;
@property (assign) BOOL taskIsComplete;


@end
