//
//  TodoDetailTableViewController.h
//  Todo
//
//  Created by Jordan Anderson on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TodoItem.h"

@protocol DueDatePickerDelegate

- (void)taskDueDateWasChosen:(NSDate *)dueDate;

@end

@interface TodoDetailTableViewController : UITableViewController <DueDatePickerDelegate>

@property (nonatomic, strong) TodoItem *aTask;

@end


